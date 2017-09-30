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
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.AnnualAlerts;
import ycapp.Model.BranchCondition;
import ycapp.Model.DateModel;
import ycapp.Model.MonthReport;
import ycapp.Model.ResultsSummary;

/**
 * 事业部营业数据
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/buData")
public class BuDataController extends BaseController {
	private static Logger logger = Logger.getLogger(BuDataController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();
	Map<String, Object> map = new HashMap<String, Object>();

	/*****
	 * 事业部业绩快讯
	 */
	@RequestMapping(value = "/getbuachievement.do", method = RequestMethod.GET)
	public ModelAndView getbuachievement(HttpServletRequest request, HttpServletResponse response) {
		logger.debug("--------------------------进入事业部销售业绩快讯Controller");
		OrderRequest or = new OrderRequest();
		Calendar cal = Calendar.getInstance();
		DateModel datemodel = new DateModel();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE) - 1;// 获取当月天数
		if (day == 0) {
			month = month - 1;
			day = ToolUtil.getDay(year, month);
		}
		datemodel.setYear(year);// 获取年份
		datemodel.setMonth(month);// 获取月份
		datemodel.setDay(day);// 获取日
		datemodel.setWeek(ToolUtil.getWeek(day));
		or.setData(datemodel);
		
		String json = JsonTool.beanTojsonString(or);
		logger.debug("日期：" + json);
		List<ResultsSummary> resultsSummaryls = new ArrayList<ResultsSummary>();
		List<BranchCondition> branchConditionls = new ArrayList<BranchCondition>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.DIVISIONSEAHOME_URL);
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
				return new ModelAndView("sheet/departDataQuery").addAllObjects(map);
			} else {
				logger.info(resultCode + "-------------------" + reason);
				return new ModelAndView("sheet/departDataQuery");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("sheet/departDataQuery");
		}
	}

	/*****
	 * 事业部销售业绩汇总
	 */
	@RequestMapping(value = "/searchbuachievement.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchbuachievement(HttpServletRequest request,
			HttpServletResponse response, @RequestBody DateModel dateModel) {
		logger.debug("--------------------------进入事业部销售业绩汇总Controller");

		if (dateModel.getYear() < 1) {
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
		OrderRequest or = new OrderRequest();
		or.setData(dateModel);
		String json = JsonTool.beanTojsonString(or);
		List<ResultsSummary> resultsSummaryls = new ArrayList<ResultsSummary>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.DIVISIONSEARES_URL);
			logger.debug("entity-------------------------->" + entity);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String reason = httpresult.getString("reason");// 返回信息
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.debug(resultInfo);
				resultsSummaryls = JSONArray.parseArray(resultInfo, ResultsSummary.class);
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
		List<MonthReport> monthReportList = new ArrayList<MonthReport>();
		Map<String, Object> map = new HashMap<String, Object>();
		DateModel dateModel = new DateModel();
		dateModel.setYear(year);
		dateModel.setMonth(month);
		if (week != -1) {
			dateModel.setWeek(week);
		}
		if (day != -1) {
			dateModel.setDay(day);
		}

		// DayReport dayReport1=new DayReport(1000, 988, 98.8);
		// DayReport dayReport2=new DayReport(2000, 1988, 98.0);
		// DayReport dayReport3=new DayReport(3000, 2988, 98.5);
		// DayReport dayReport4=new DayReport(4000, 3988, 98.7);
		// DayReport dayReport5=new DayReport(5000, 4988, 98.9);
		// List<DayReport> dayList=new ArrayList<DayReport>();
		// dayList.add(dayReport1);
		// dayList.add(dayReport2);
		// dayList.add(dayReport3);
		// dayList.add(dayReport4);
		// dayList.add(dayReport5);
		// WeekReport weekReport1=new WeekReport();
		// weekReport1.setWeekIndex(9000);
		// weekReport1.setHaveSales(8500);
		// weekReport1.setWeekCompletion(95.00);
		// WeekReport weekReport2=new WeekReport();
		// weekReport2.setWeekIndex(8000);
		// weekReport2.setHaveSales(0);
		// weekReport2.setWeekCompletion(0.00);
		// WeekReport weekReport3=new WeekReport();
		// weekReport3.setWeekIndex(7000);
		// weekReport3.setHaveSales(0);
		// weekReport3.setWeekCompletion(0.00);
		// WeekReport weekReport4=new WeekReport();
		// weekReport4.setWeekIndex(6000);
		// weekReport4.setHaveSales(0);
		// weekReport4.setWeekCompletion(0.00);
		// List<WeekReport> weekList=new ArrayList<WeekReport>();
		// weekList.add(weekReport1);
		// weekList.add(weekReport2);
		// weekList.add(weekReport3);
		// weekList.add(weekReport4);
		// MonthReport monthReport=new MonthReport("事业部", 2000000, 1500000,
		// 95.00, 6500000, 5500000, 90.00, weekList,dayList);
		// List<MonthReport> monthReportList1=new ArrayList<MonthReport>();
		// monthReportList1.add(monthReport);

		OrderRequest or = tu.getOrderRequest(request, response, dateModel);
		or.setDepartment("division");
		if (or != null) {
			try {
				String json = JSONObject.toJSONString(or);
				logger.info("=====================================传输数据:" + json);
				if (null != json) {
					String entity = tu.RequestPost(response, json, Global.DIVISION_REPORT);
				
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
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("message", "暂无数据");
			}
		}
		return map;
	}
}
