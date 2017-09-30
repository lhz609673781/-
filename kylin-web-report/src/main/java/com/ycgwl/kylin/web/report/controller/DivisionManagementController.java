package com.ycgwl.kylin.web.report.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.EditDivison;
import com.ycgwl.kylin.web.report.domain.ExportError;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.BindCusTomerAndDivisionModel;
import ycapp.Model.DivisionReason;
import ycapp.dbinterface.PageModel;

@Controller
@RequestMapping("/divisionManage")
public class DivisionManagementController extends BaseController {
	private static Logger logger = Logger.getLogger(DivisionManagementController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();

	/**
	 * 事业部和关联客户信息导入
	 *
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @explain 客户名称对应多个客户代码，客户代码用逗号分隔
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cognateCusLeading.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> cognateCustLeading(@RequestParam("file") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||CognateCus Leading");
		Map<String, Object> map = new HashMap<String, Object>();
		ExportError ee = new ExportError();
		if (!file.isEmpty()) {
			List<BindCusTomerAndDivisionModel> btaList = new ArrayList<BindCusTomerAndDivisionModel>();

			ee = tu.cognateCustXlsLead(file, response, request);// 事业部关联客户导入
	
			if (ee.getError() != null) {
				map.put("mas", ee.getError());
			} else if (ee.getData() != null && ee.getError() == null) {
				try {
					btaList = (List<BindCusTomerAndDivisionModel>) ee.getData();
					if (btaList != null) {
						// OrderRequest or = tu.getOrderRequest(request,
						// response, btaList);
						// if (or != null && "1".equals(or.getRole())) {
						String json = JSONObject.toJSONString(btaList);
						logger.info("=====================================传输数据:" + json);
						if (null != json) {
							String entity = tu.RequestPost(response, json, LHX_URL + Global.BRALEAD_URL);
							if (entity == null) {
								logger.info("----------entity is null------------------");
								map.put("mas", ee.getError());
							}
							try {
								JSONObject httpresult = JSONObject.parseObject(entity);
								String resultCode = httpresult.getString("resultCode");// 状态码
								logger.info("状态码:" + resultCode);
								String reason = httpresult.getString("reason");// 返回信息
								logger.info("返回信息:" + reason);
								if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
									map.put("mas", "success");
								} else {
									map.put("mas", ee.getError());
								}
							} catch (Exception e) {
								logger.error("错误信息:" + e);
							}
						}
						// } else {
						// map.put("mas", "error");
						// }
					}
				} catch (Exception e) {
					logger.error("错误信息:" + e);
					map.put("mas", "error");
				}
			} else {
				map.put("mas", "error");
			}
			
		} else {
			map.put("mas", "error");
		}
		return map;
	}

	/**
	 * 事业部和关联客户信息搜索
	 * 
	 * @param file
	 * @param customer
	 *            code bu
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cognateCustSearch.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> cognateCustSearch(String customerName, String bindDivision,
			String customerType, String pageSize, String currPage, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		if (ToolUtil.isEmpty(customerName)){
			customerName = null;
		}
			
		if (ToolUtil.isEmpty(bindDivision)){
			bindDivision = null;
		}
			
		if (ToolUtil.isEmpty(customerType)){
			customerType = null;
		}
			
		BindCusTomerAndDivisionModel bca = new BindCusTomerAndDivisionModel();
		PageModel<BindCusTomerAndDivisionModel> pageModel = new PageModel<BindCusTomerAndDivisionModel>();
		pageModel.setPageNo(Integer.parseInt(currPage));
		pageModel.setPageSize(Integer.parseInt(pageSize));
		bca.setCustomerName(customerName);
		bca.setBindDivision(bindDivision);
		bca.setCustomerType(customerType);
		pageModel.setObj(bca);
		// OrderRequest or = tu.getOrderRequest(request, response, pageModel);
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			logger.info("=====================================传输数据:" + json);
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRASEARCH_URL);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);

				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					logger.info("返回数据:" + resultInfo);
					pageModel = JSONObject.parseObject(resultInfo, PageModel.class);
					map.put("page", pageModel);
					map.put("mas", "success");
				} else {
					logger.info(resultCode + "-------------------" + reason);
					map.put("mas", "error");
				}
			} catch (Exception e) {
				logger.info(e);
				map.put("mas", "error");
			}		
		}
		return map;
	}

	/**
	 * 事业部和关联客户信息列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cognateCustList.do", method = RequestMethod.GET)
	public ModelAndView cognateCustList(String pageSize, String currPage, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		BindCusTomerAndDivisionModel bca = new BindCusTomerAndDivisionModel();
		PageModel<BindCusTomerAndDivisionModel> pageModel = new PageModel<BindCusTomerAndDivisionModel>();
		pageModel.setPageNo(Integer.parseInt(currPage));
		pageModel.setPageSize(Integer.parseInt(pageSize));
		bca.setCustomerName(null);
		bca.setBindDivision(null);
		bca.setCustomerType(null);
		pageModel.setObj(bca);
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			logger.info("=====================================传输数据:" + json);
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRASEARCH_URL);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);

				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					logger.info("返回数据:" + resultInfo);
					pageModel = JSONObject.parseObject(resultInfo, PageModel.class);
					map.put("page", pageModel);
				} else {
					logger.info(resultCode + "-------------------" + reason);
					map.put("mas", "查询失败");
				}
			} catch (Exception e) {
				logger.info(e);
				map.put("mas", "查询失败");
			}
		}
		return new ModelAndView("sheet/departAndCustom").addAllObjects(map);
	}

	/**
	 * 添加客户
	 * 
	 * @param bct
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addCust.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addCustomer(@RequestBody BindCusTomerAndDivisionModel bct,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||CognateCus Leading");
		Map<String, Object> map = new HashMap<String, Object>();
		String json = JSONObject.toJSONString(bct);
		logger.info("=====================================传输数据:" + json);
		if (null != json) {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRAADD_URL);
	
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

					map.put("mas", "success");
				} else {
					map.put("mas", "error");
				}
			} catch (Exception e) {
				logger.error("错误信息:" + e);
				map.put("mas", "error");
			}
		}
		return map;
	}

	@RequestMapping(value = "/searchCode.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchCustomerCode(String codes, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||CognateCus Leading");
		Map<String, Object> map = new HashMap<String, Object>();
		String[] codeList = codes.split(",");
		String json = JSONObject.toJSONString(codeList);
		logger.info("=====================================传输数据:" + json);
		if (null != json) {
			String entity = tu.RequestPost(response, json, "http://172.16.67.65:20864");
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					map.put("mas", "success");
				} else {
					map.put("mas", reason + "无对应客户，请重新输入");
				}
			} catch (Exception e) {
				logger.error("错误信息:" + e);
			}
		}
		return map;
	}

	@RequestMapping(value = "/addDivision.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addDivision(@RequestBody BindCusTomerAndDivisionModel bct,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||CognateCus Leading");
		Map<String, Object> map = new HashMap<String, Object>();
		String json = JSONObject.toJSONString(bct);
		logger.info("=====================================传输数据:" + json);
		if (null != json) {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRAADD_URL);
	
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String data = httpresult.getString("resultInfo");
					logger.info("resultInfo--------------------->" + data);
					if (!data.equals("{}")) {
						DivisionReason divisionReason = JSONObject.parseObject(data, DivisionReason.class);
						logger.info("focusMultiCustomer-------------------->" + divisionReason.getFocusMultiCustomer());
						map.put("divisionReason", divisionReason);
						map.put("mas", "other");
					} else {
						map.put("mas", "success");
					}
				} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
					String data = httpresult.getString("resultInfo");
					DivisionReason divisionReason = JSONObject.parseObject(data, DivisionReason.class);
					logger.info("customerNotExist-------------------->" + divisionReason.getCustomerNotExist());
					logger.info("hasOtherExistRef-------------------->" + divisionReason.getHasOtherExistRef());
					map.put("mas", "fail");
					map.put("divisionReason", divisionReason);
				} else {
					map.put("mas", "error");
				}
			} catch (Exception e) {
				logger.error("错误信息:" + e);
				map.put("mas", "error");
			}
		}
		return map;
	}

	@RequestMapping(value = "/editDivision.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> editDivision(@RequestBody EditDivison editdiv, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||editDivision");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		or.setData(editdiv.getList());
		or.setDepartment(editdiv.getName());
		String json = JSONObject.toJSONString(or);
		logger.info("=====================================传输数据:" + json);
		if (null != json) {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRAEDIT_URL);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String data = httpresult.getString("resultInfo");
					if (StringUtils.isNotEmpty(data)) {
						DivisionReason divisionReason = JSONObject.parseObject(data, DivisionReason.class);
						logger.info("customerNotExist-------------------->" + divisionReason.getCustomerNotExist());
						logger.info("hasOtherExistRef-------------------->" + divisionReason.getHasOtherExistRef());
						logger.info("focusMultiCustomer-------------------->" + divisionReason.getFocusMultiCustomer());
						map.put("divisionReason", divisionReason);
					}
					map.put("mas", "success");
				} else {
					map.put("mas", "error");
					map.put("info", reason);
				}
			} catch (Exception e) {
				logger.error("错误信息:" + e);
				map.put("mas", "error");
			}
		}
		return map;
	}

	@RequestMapping(value = "/delDivision.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> delDivision(String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||CognateCus Leading");
		Map<String, Object> map = new HashMap<String, Object>();
		String jsonMessage = null;
		if (StringUtils.isEmpty(id)) {
			jsonMessage = "{\"id\":\"" + id + "\"}";
		}
		String json = JSONObject.toJSONString(jsonMessage);
		logger.info("=====================================传输数据:" + json);
		if (null != json) {
			String entity = tu.RequestPost(response, json, "http://172.16.67.65:20864");
			
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

		return map;
	}

	/**
	 * 根据name查询事业部
	 * 
	 * @param bindDivision
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findDivision.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView findDivision(String bindDivision, HttpServletRequest request, HttpServletResponse response) {
		logger.info("|||||||||||||||||||||||||||||||||||||||findDivision");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			bindDivision = URLDecoder.decode(bindDivision, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		OrderRequest or = new OrderRequest();
		if (StringUtils.isNotEmpty(bindDivision)) {
			BindCusTomerAndDivisionModel bca = new BindCusTomerAndDivisionModel();
			PageModel<BindCusTomerAndDivisionModel> pageModel = new PageModel<BindCusTomerAndDivisionModel>();
			bca.setBindDivision(bindDivision);
			pageModel.setObj(bca);
			pageModel.setPageNo(1);
			pageModel.setPageSize(300);
			or.setData(pageModel);
			String json = JSONObject.toJSONString(or);
			logger.info("=====================================传输数据:" + json);
			try {
				String entity = tu.RequestPost(response, json, LHX_URL + Global.BRASEARCH_URL);
				
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultinfo = httpresult.getString("resultInfo");// 返回结果
					logger.info("resultinfo-------------------->" + resultinfo);
					pageModel = JSONObject.parseObject(resultinfo, PageModel.class);
					pageModel.setObj(bindDivision);
					map.put("page", pageModel);
					return new ModelAndView("sheet/buiness").addAllObjects(map);
				}
			} catch (Exception e) {
				logger.error("错误信息:" + e);
			}
		}
		return new ModelAndView("error");
	}

	/**
	 * 验证客户是否存在
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/validatCust.do", method = RequestMethod.POST)
	public @ResponseBody Map validatCustomer(@RequestBody BindCusTomerAndDivisionModel bct, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||findDivision");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		or.setData(bct);
		String json = JSONObject.toJSONString(or);
		logger.info("=====================================传输数据:" + json);
		String entity = tu.RequestPost(response, json, LHX_URL + Global.BRASEADIV_URL);
	
		PageModel pm = new PageModel();
		try {
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultinfo = httpresult.getString("resultInfo");// 返回结果
				logger.info("resultinfo-------------------------->" + resultinfo);
				pm = JSONObject.parseObject(resultinfo, PageModel.class);
				if (pm.getObj() == null) {
					map.put("mas", "success");
				} else {
					// DivisionReason divisionReason = (DivisionReason)
					// pm.getObj();
					map.put("mas", "other");
				}
				map.put("pm", pm);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
				String resultinfo = httpresult.getString("resultInfo");// 返回结果
				logger.info("resultinfo-------------------------->" + resultinfo);
				pm = JSONObject.parseObject(resultinfo, PageModel.class);
				map.put("mas", "fail");
				map.put("pm", pm);
			} else {
				map.put("mas", "error");
			}
		} catch (Exception e) {
			logger.error("错误信息:" + e);
			map.put("mas", "error");
		}
		return map;
	}

	/**
	 * 下载模板，保存成excel
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/model.do", method = RequestMethod.POST)
	public String downLoad(HttpServletRequest request, HttpServletResponse response, String type) {
		logger.info("|||||||||||||||||||||||||||||||||||||||downLoad");
		try {
			tu.downXls(request, response, type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
