package com.ycgwl.kylin.web.report.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.ExportError;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.TurnoverModel;

/**
 * 指标管理
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/targetManage")
public class TargetManagementController extends BaseController {
	private static Logger logger = Logger.getLogger(TargetManagementController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();

	/**
	 * 销售指标指标导入
	 *
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @return
	 * @throws Exception
	 * @explain 每个分公司/事业部都有12个月的销售指标，导入后显示当月的销售指标
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/revenueLeading.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> revenueLeading(@RequestParam("file") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||SaleTarget Leading");
		ExportError ee = new ExportError();
		Map<String, Object> map = new HashMap<String, Object>();
		if (!file.isEmpty()) {
			List<TurnoverModel> tList = new ArrayList<TurnoverModel>();

			ee = tu.menagementXlsLead(file, response, request);// 销售指标导入

			if (ee != null) {
		
				try {
					tList = (List<TurnoverModel>) ee.getData();
					if (tList != null) {
						// OrderRequest or = tu.getOrderRequest(request,
						// response, tList);
						// if (or != null && "1".equals(or.getRole())) {
						String json = JSONObject.toJSONString(tList);
						logger.info("=====================================传输数据:" + json);
						if (null != json) {
							String entity = tu.RequestPost(response, json, LHX_URL + Global.BRASALIMP_URL);
							if (StringUtils.isEmpty(entity)) {
								logger.info("----------entity is null------------------");
								map.put("mas", "error");
							} else {
								try {
									JSONObject httpresult = JSONObject.parseObject(entity);
									String resultCode = httpresult.getString("resultCode");// 状态码
									logger.info("状态码:" + resultCode);
									String reason = httpresult.getString("reason");// 返回信息
									logger.info("返回信息:" + reason);
									if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
										map.put("mas", "success");
									} else {
										map.put("mas", reason);
									}
								} catch (Exception e) {
									logger.error("错误信息:" + e);
								}
							}

						}
						// } else {
						// map.put("mas", "login");
						// }
					}
				} catch (Exception e) {
					logger.error("错误信息:" + e);
					map.put("mas", "error");
				}
			}
		} else {
			map.put("mas", "error");
		}
		return map;
	}

	/**
	 * 销售指标搜索
	 * 
	 * @param file
	 * @param year
	 *            month
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/revenueSearch.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> revenueSearch(int year, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("|||||||||||||||||||||||||||||||||||||||RevenueSearch");
		String jsonMessage = null;
		if (year != -1) {
			jsonMessage = "{\"year\":\"" + year + "\"}";
		}
		OrderRequest or = tu.getOrderRequest(request, response, null);
		// if (or != null) {
		try {
			JSONObject json = JSONObject.parseObject(jsonMessage);
			logger.info("=====================================传输数据:" + json.toString());
			if (null != json) {
				String entity = tu.RequestPost(response, json.toString(), LHX_URL + Global.BRAMONLS_URL);
			
				JSONObject httpresult = JSONObject.parseObject(entity);
				logger.info("=====================================返回结果:" + httpresult.getString("resultInfo"));
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					try {
						List<TurnoverModel> tl = JSONObject.parseArray(httpresult.get("resultInfo").toString(),
								TurnoverModel.class);
						map.put("mas", "success");
						map.put("turnoverList", tl);
					} catch (Exception e) {
						logger.error("错误信息:" + e);
						map.put("mas", "error");
					}
				} else {
					logger.info(resultCode + "-------------------" + reason);
					map.put("mas", "error");
				}
			}
		} catch (Exception e1) {
			logger.error("错误信息:" + e1);
			map.put("mas", "error");
		}
		return map;
	}

	/**
	 * 销售指标管理列表
	 * 
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/revenueList.do", method = RequestMethod.GET)
	public ModelAndView revenueList(HttpServletRequest request, HttpServletResponse response, Map<String, Object> map)
			throws Exception {
		map.clear();
		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);
		logger.info("=====================================传输数据:" + json);
		String entity = tu.RequestPost(response, "", LHX_URL + Global.BRAMONLS_URL);
	
		try {
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("==================返回结果:" + resultInfo);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				List<TurnoverModel> tl = JSONObject.parseArray(httpresult.get("resultInfo").toString(),
						TurnoverModel.class);
				if (tl.size() == 0) {
					map.put("mas", "没有查到记录");
				} else {
					map.put("turnoverList", tl);
				}
			} else {
				logger.info(resultCode + "-------------------" + reason);
				map.put("mas", reason);
			}
		} catch (Exception e) {
			logger.info(e);
			map.put("mas", "查询失败");
		}
		return new ModelAndView("sheet/saleTarget").addAllObjects(map);
	}
}
