package com.ycgwl.kylin.web.report.controller;

import java.net.ConnectException;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.domain.TopList;
import com.ycgwl.kylin.web.report.utils.CalcUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.AnnualAlerts;
import ycapp.Model.BranchCondition;
import ycapp.Model.DateModel;
import ycapp.Model.ExcelForm;
import ycapp.Model.MonthReport;
import ycapp.Model.ResultsSummary;
import ycapp.Model.SaleAdjustModel;
import ycapp.dbinterface.bean.BackUserForOut;

/**
 * 分公司营业数据
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/branchData")
public class BranchController extends BaseController {
	private static Logger logger = Logger.getLogger(BranchController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();
	List<ResultsSummary> list2 = new ArrayList<ResultsSummary>();
	Map<String, String> mapCity = ToolUtil.getCity();

	/***
	 * 保存调整的销售额.
	 */
	@RequestMapping(value = "/adjustSale.do", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> saveAdjustSale(HttpServletRequest request, HttpServletResponse response,
			SaleAdjustModel adjustModel) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		or.setData(adjustModel);
		String json = JsonTool.beanTojsonString(or);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.SAVE_SALE_ADJUST_URL);
			logger.debug("entity-------------------------->" + entity);
			
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
			e.printStackTrace();
			return map;
		}
		return map;
	}

	/***
	 * 分公司业绩快讯
	 */
	@RequestMapping(value = "/getfilialeachievement.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getfilialeachievement(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String str = "";
		BackUserForOut backuser = (BackUserForOut) request.getSession().getAttribute("backuser");
		if (backuser.getRoottype() == 1) {
			str = "sheet/companyDataQuery2";
		} else if (backuser.getRoottype() == 2) {
			str = "sheet/companyDataQuery";
		}
		logger.debug("--------------------------进入分公司销售业绩快讯Controller");
		OrderRequest or = new OrderRequest();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		DateModel datemodel = new DateModel();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE);
		datemodel.setYear(year);// 获取年份
		datemodel.setMonth(month);// 获取月份
		datemodel.setDay(day);// 获取日
		datemodel.setWeek(ToolUtil.getWeek(day));
		or.setData(datemodel);
		// BackUserForOut backUserForOut = (BackUserForOut)
		// request.getSession().getAttribute("user");
		// if (null == backUserForOut) {
		// map.put("loginmas", Global.UNLOGIN);
		// return new ModelAndView("login").addAllObjects(map);
		// }
		String json = JsonTool.beanTojsonString(or);
		logger.debug("日期：" + json);
		List<ResultsSummary> resultsSummaryls = new ArrayList<ResultsSummary>();
		List<BranchCondition> branchConditionls = new ArrayList<BranchCondition>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRANCHSEAHOME_URL);
			logger.debug("entity-------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String reason = httpresult.getString("reason");// 返回信息
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.debug(resultInfo);
				JSONObject httpresult1 = JSONObject.parseObject(resultInfo);
				String resultsSummaryStirng = httpresult1.getString("resultsSummary");
				resultsSummaryls = JSONArray.parseArray(resultsSummaryStirng, ResultsSummary.class);
				String branchConditionString = httpresult1.getString("branchCondition");
				branchConditionls = JSONArray.parseArray(branchConditionString, BranchCondition.class);
				String annualAlertsString = httpresult1.getString("annualAlerts");
				AnnualAlerts annualAlerts = JSONObject.parseObject(annualAlertsString, AnnualAlerts.class);
				if (resultsSummaryls.size() > 0) {
					ToolUtil.resultSummaryUtil(resultsSummaryls);
					for (int i = 0; i < resultsSummaryls.size(); i++) {
						String province = mapCity.get(resultsSummaryls.get(i).getDivisionName());
						if (null != province) {
							resultsSummaryls.get(i).setDivisionName(province);
						}
					}
					map.put("resultsSummaryls", resultsSummaryls);
				}
				if (branchConditionls.size() > 0) {
					TopList<BranchCondition> topList = ToolUtil.branchConditionUtil(branchConditionls);
					if (topList.getBralist1().size() > 0 && topList.getBralist2().size() > 0) {
						topList = ToolUtil.CityToProvince(topList);
						map.put("topList", topList);
					}
				}
				if (StringUtils.isNotEmpty(annualAlertsString)) {
					map.put("annualAlerts", annualAlerts);
				}
			} else {
				logger.info(resultCode + "-------------------" + reason);
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView(str).addAllObjects(map);
	}

	/*****
	 * 分公司销售业绩汇总
	 */
	@RequestMapping(value = "/searchfilialeachievement.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchfilialeachievement(HttpServletRequest request,
			HttpServletResponse response, @RequestBody DateModel dateModel) {
		logger.debug("--------------------------进入分公司销售业绩汇总Controller");
		Map<String, Object> map = new HashMap<String, Object>();
		if (dateModel.getYear() < 1) {
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
		OrderRequest or = new OrderRequest();
		or.setData(dateModel);
		String json = JsonTool.beanTojsonString(or);
		List<ResultsSummary> resultsSummaryls = new ArrayList<ResultsSummary>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRANCHSEARES_URL);
			logger.debug("entity-------------------------->" + entity);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String reason = httpresult.getString("reason");// 返回信息
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.debug(resultInfo);
				resultsSummaryls = JSONArray.parseArray(resultInfo, ResultsSummary.class);
				for (int i = 0; i < resultsSummaryls.size(); i++) {
					String province = mapCity.get(resultsSummaryls.get(i).getDivisionName());
					if (null != province) {
						resultsSummaryls.get(i).setDivisionName(province);
					}
				}
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
				ToolUtil.resultSummaryUtil(resultsSummaryls);
				map.put("resultsSummaryls", resultsSummaryls);
				return map;
			} else {
				logger.info(resultCode + "-------------------" + reason);
				map.put("mas", Global.AJAX_STATUS_ERROR);
				return map;
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
	}
	
	/*****
	 * 分公司销售业绩导出
	 */
	@RequestMapping(value = "/exportSerachResultsSummary.do")
	public @ResponseBody void exportSerachResultsSummary(HttpServletRequest request,
			HttpServletResponse response, @RequestBody DateModel dateModel) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (dateModel.getYear() < 1) {
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return;
		}
		OrderRequest or = new OrderRequest();
		or.setData(dateModel);
		String json = JsonTool.beanTojsonString(or);
		List<ResultsSummary> resultsSummaryls = new ArrayList<ResultsSummary>();
		List<String[]> list = new ArrayList<String[]>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.BRANCHSEARES_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String reason = httpresult.getString("reason");// 返回信息
			String resultCode = httpresult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.debug(resultInfo);
				resultsSummaryls = JSONArray.parseArray(resultInfo, ResultsSummary.class);
				for (int i = 0; i < resultsSummaryls.size(); i++) {
					String province = mapCity.get(resultsSummaryls.get(i).getDivisionName());
					if (null != province) {
						resultsSummaryls.get(i).setDivisionName(province);
					}
				}
				for (int i = 0; i < resultsSummaryls.size(); i++) {
					ResultsSummary op = resultsSummaryls.get(i);
					String array[] = { op.getDivisionName()+"分公司", 
							CalcUtils.calcScientficNum(op.getSalesIndicators()),
							CalcUtils.calcScientficNum(op.getOldSale()),
							CalcUtils.calcScientficNum(op.getShitiAdjust()+op.getPingtaiAdjust()),
							CalcUtils.calcScientficNum(op.getSales()),
							CalcUtils.calcScientficNum(op.getDifference()),
							CalcUtils.calcScientficNum(op.getSales()),
							CalcUtils.formatNumber(op.getCompletion()*100,2)+"%"};
					list.add(array);
				}
				
				// 设置excel信息
				String showColumnName[] = { "分公司名称","销售指标","原数据","调整额","销售额" ,"差额","完成率"};// 列名
				String sheetName = "分公司销售业绩汇总";
				Integer showColumnWidth[] = { 20,20, 20, 20, 20, 20, 20 };// 列宽
				String fileName = "分公司销售业绩汇总";
				ExcelForm excelForm = new ExcelForm();
				excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
				excelForm.setList(list);// 导出的内容
				excelForm.setSheetName(sheetName);
				excelForm.setShowColumnName(showColumnName);
				excelForm.setShowColumnWidth(showColumnWidth);
				ExcelReportUtils.exportExcel(excelForm, response);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 导出
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/export.do", method = RequestMethod.GET)
	public Map<String, Object> export(int year, int month, int week, int day, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||BookManage Export");
		Map<String, Object> map = new HashMap<String, Object>();
		List<MonthReport> monthReportList = new ArrayList<MonthReport>();
		DateModel dateModel = new DateModel();
		dateModel.setYear(year);
		dateModel.setMonth(month);
		if (week != -1) {
			dateModel.setWeek(week);
		}
		if (day != -1) {
			dateModel.setDay(day);
		}
		OrderRequest or = tu.getOrderRequest(request, response, dateModel);
		if (or != null) {
			try {
				String json = JSONObject.toJSONString(or);
				logger.info("=====================================传输数据:" + json);
				if (null != json) {
					String entity = tu.RequestPost(response, json, Global.BRANCH_REPORT);
					if (entity == null) {
						logger.info("----------entity is null------------------");
						request.getSession().setAttribute("mas", "暂无数据");
						map.put("message", "暂无数据");
					} else {
						try {
							JSONObject httpresult = JSONObject.parseObject(entity);
							logger.info(
									"=====================================返回结果:" + httpresult.getString("resultInfo"));
							String resultCode = httpresult.getString("resultCode");// 状态码
							logger.info("状态码:" + resultCode);
							String reason = httpresult.getString("reason");// 返回信息
							logger.info("返回信息:" + reason);
							if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
								try {
									String resultInfo = httpresult.getString("resultInfo");// 返回数据
									monthReportList = JSONArray.parseArray(resultInfo, MonthReport.class);
									tu.exportAnnualAlerts(monthReportList, dateModel, response);
								} catch (Exception e) {
									logger.error("错误信息:" + e);
									map.put("message", "暂无数据");
								}
							} else {
								logger.info(resultCode + "-------------------" + reason);
								map.put("message", reason);
							}
						} catch (Exception e) {
							logger.error("错误信息:" + e);
						}
					}
				}
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("message", "暂无数据");
			}
		}
		return map;
	}
}
