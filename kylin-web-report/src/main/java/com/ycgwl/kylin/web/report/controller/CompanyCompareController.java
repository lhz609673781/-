package com.ycgwl.kylin.web.report.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.CompanyResult;
import ycapp.Model.DateModel;
import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.OperationStatisCustomerForOut;
import ycapp.dbinterface.bean.OperationStatisForOut;

/**
 * 分公司同比，环比，重点项目监控控制层
 * 
 * @author yeyunsong
 *
 */
@Controller
@RequestMapping("/companyCompare")
public class CompanyCompareController extends BaseController {
	private static Logger logger = Logger.getLogger(CompanyCompareController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	DecimalFormat df = new DecimalFormat("0.00");

	/***
	 * 分公司同比（ajax请求）
	 */
	@RequestMapping(value = "/searchIdentical.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchIdentical(HttpServletRequest request, HttpServletResponse response,
			OperationStatisForOut searchos) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		or.setData(searchos);
		String json = JsonTool.beanTojsonString(or);
		logger.debug("json-------------------------->" + json);
		List<OperationStatisForOut> osList = new ArrayList<OperationStatisForOut>();
		CompanyResult companyAround = new CompanyResult();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_IDENTICALSEAR);
			logger.debug("entity-------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				companyAround = JSONObject.parseObject(resultInfo, CompanyResult.class);
				osList = companyAround.getList();
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
				map.put("data", osList);
			} else {
				map.put("mas", Global.AJAX_STATUS_FAIL);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/***
	 * 分公司同比（菜单请求）
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/findIdentical.do", method = RequestMethod.GET)
	public ModelAndView findIdentical(HttpServletRequest request, HttpServletResponse response) {
		logger.info("进入分公司同比（菜单请求）");
		Calendar c = Calendar.getInstance();
		OrderRequest or = new OrderRequest();
		OperationStatisForOut searchos = new OperationStatisForOut();
		if (c.get(Calendar.DATE) != 1) {
			searchos.setBeginTime(tu.firstDateOfCurrMonth());// 开始时间（当前月的1号）
			searchos.setEndTime(DateUtils.yesterday());// 结束时间（当前日期的前一天）
		} else {
			searchos.setBeginTime(DateUtils.firstDateOfTerdayMonth());
			searchos.setEndTime(DateUtils.yesterday());
		}
		searchos.setPlatform(OperationStatisForOut.CUSTOMER_TYPE_NOT_PLATFORM);
		or.setData(searchos);
		String json = JsonTool.beanTojsonString(or);
		logger.debug("json-------------------------->" + json);
		List<OperationStatisForOut> osList = new ArrayList<OperationStatisForOut>();
		CompanyResult companyAround = new CompanyResult();
		List<String> listName = new ArrayList<String>();// 页面分公司下拉框
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_IDENTICALSEAR);
			logger.debug("entity-------------------------->" + entity);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				companyAround = JSONObject.parseObject(resultInfo, CompanyResult.class);
				osList = companyAround.getList();
				listName = companyAround.getListName();
				request.setAttribute("osList", osList);
				request.setAttribute("listName", listName);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("sheet/companyIdentical");
	}

	/***
	 * 分公司环比（Ajax请求）
	 */
	@RequestMapping(value = "/searchAround.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchAround(HttpServletRequest request, HttpServletResponse response,
			OperationStatisForOut searchos) {
		OrderRequest or = new OrderRequest();
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("进入分公司环比（Ajax请求），传输数据--------------------->" + searchos);
		or.setData(searchos);
		String json = JsonTool.beanTojsonString(or);
		logger.debug("json-------------------------->" + json);
		List<OperationStatisForOut> osList = new ArrayList<OperationStatisForOut>();
		CompanyResult companyAround = new CompanyResult();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_AROUNDSEAR);
			logger.debug("entity-------------------------->" + entity);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("返回结果:" + resultInfo);
				companyAround = JSONObject.parseObject(resultInfo, CompanyResult.class);
				osList = companyAround.getList();
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
				map.put("data", osList);
			} else {
				map.put("mas", Global.AJAX_STATUS_FAIL);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/***
	 * 分公司环比（菜单请求）
	 */
	@RequestMapping(value = "/findAround.do", method = RequestMethod.GET)
	public ModelAndView findAround(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		Calendar c = Calendar.getInstance();
		OperationStatisForOut searchos = new OperationStatisForOut();
		c.add(Calendar.DATE, -1);// 当前日期的前一天
		searchos.setDayParam(c.get(Calendar.DATE));
		searchos.setWeekParam(DateModel.getWeek(c.get(Calendar.DATE)));
		searchos.setMonthParam(c.get(Calendar.MONTH) + 1);
		searchos.setQuarterParam(DateModel.getJidu(c.get(Calendar.MONTH) + 1));
		searchos.setYearParam(c.get(Calendar.YEAR));
		searchos.setPlatform(OperationStatisForOut.CUSTOMER_TYPE_NOT_PLATFORM);
		map.put("year", c.get(Calendar.YEAR));
		map.put("month", c.get(Calendar.MONTH) + 1);
		map.put("day", c.get(Calendar.DATE));
		or.setData(searchos);
		String json = JsonTool.beanTojsonString(or);
		logger.debug("json-------------------------->" + json);
		List<OperationStatisForOut> osList = new ArrayList<OperationStatisForOut>();// 接收环比数据
		CompanyResult companyAround = new CompanyResult();
		List<String> listName = new ArrayList<String>();// 页面分公司下拉框
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_AROUNDSEAR);
			logger.debug("entity-------------------------->" + entity);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("返回结果:" + resultInfo);
				companyAround = JSONObject.parseObject(resultInfo, CompanyResult.class);
				osList = companyAround.getList();
				listName = companyAround.getListName();
				map.put("osList", osList);
				map.put("listName", listName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("sheet/companyAround").addAllObjects(map);
	}

	/***
	 * 重点项目监控（菜单请求）
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/findMonitorMajor.do", method = RequestMethod.GET)
	public ModelAndView findMonitorMajor(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		Calendar c = Calendar.getInstance();
		OperationStatisCustomerForOut searchos = new OperationStatisCustomerForOut();
		if (c.get(Calendar.DATE) != 1) {
			searchos.setBeginTime(tu.firstDateOfCurrMonth());// 开始时间（当前月的1号）
			c.add(Calendar.DATE, -1);
			searchos.setEndTime(sdf.format(c.getTime()));// 结束时间（当前日期的前一天）
		} else {
			searchos.setBeginTime(DateUtils.firstDateOfTerdayMonth());
			searchos.setEndTime(DateUtils.yesterday());
		}
		searchos.setPlatformType(searchos.CUSTOMER_TYPE_NOT_PLATFORM);// 平台类型
		searchos.setGrossProfitRate(null);
		searchos.setIncomeSum(null);
		PageModel<OperationStatisCustomerForOut> page = new PageModel<OperationStatisCustomerForOut>();
		page.setObj(searchos);
		page.setPageNo(1);
		page.setPageSize(10);
		or.setData(page);
		String json = JsonTool.beanTojsonString(or);
		logger.debug("json-------------------------->" + json);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_MONITOREAR);
			logger.debug("entity-------------------------->" + entity);
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("返回结果:" + resultInfo);
				page = JSONObject.parseObject(resultInfo, PageModel.class);
				map.put("page", page);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("sheet/monitorMajor").addAllObjects(map);
	}

	/***
	 * 重点项目监控（Ajax请求）
	 */
	@RequestMapping(value = "/searchMonitorMajor.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchMonitorMajor(String beginTime, String endTime, String platformType,
			String incomeSum, String grossProfitRate, int pageSize, int pageNo, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		PageModel<OperationStatisCustomerForOut> page = new PageModel<OperationStatisCustomerForOut>();
		OperationStatisCustomerForOut osc = new OperationStatisCustomerForOut();
		osc.setBeginTime(beginTime);
		osc.setEndTime(endTime);
		osc.setPlatformType(platformType);// 平台类型
		if (StringUtils.isNotEmpty(incomeSum)) {
			osc.setIncomeSum(Double.parseDouble(incomeSum));// 收入
		} else {
			osc.setIncomeSum(null);
		}
		if (StringUtils.isNotEmpty(grossProfitRate)) {
			osc.setGrossProfitRate(Double.parseDouble(grossProfitRate));// 毛利率
		} else {
			osc.setGrossProfitRate(null);
		}
		page.setObj(osc);
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		OrderRequest or = new OrderRequest();
		or.setData(page);
		String json = JsonTool.beanTojsonString(or);
		logger.info("json-------------------------->" + json);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_MONITOREAR);
			logger.debug("entity-------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("返回结果:" + resultInfo);
				page = JSONObject.parseObject(resultInfo, PageModel.class);
				map.put("page", page);
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/***
	 * 分公司环比导出（excel）
	 */
	@RequestMapping(value = "/aroundExport.do", method = RequestMethod.GET)
	public void aroundExport(HttpServletRequest request, HttpServletResponse response, OperationStatisForOut searchos) {
		try {
			searchos.setGroupName(URLDecoder.decode(searchos.getGroupName(), "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		OrderRequest or = new OrderRequest();
		logger.info("进入分公司环比导出，传输数据--------------------->" + searchos);
		or.setData(searchos);
		String json = JsonTool.beanTojsonString(or);
		logger.debug("json-------------------------->" + json);
		List<OperationStatisForOut> osList = new ArrayList<OperationStatisForOut>();
		CompanyResult companyAround = new CompanyResult();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_AROUNDSEAR);
			logger.debug("entity-------------------------->" + entity);
			List<String[]> list = new ArrayList<String[]>();
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				companyAround = JSONObject.parseObject(resultInfo, CompanyResult.class);
				osList = companyAround.getList();
				if (osList.size() > 0) {
					for (int i = 0; i < osList.size(); i++) {
						OperationStatisForOut op = osList.get(i);
						String array[] = { op.getDate(), "" + df.format(op.getIncome()),
								"" + df.format(op.getCost()), "" + df.format(op.getGrossProfit()),
								df.format(op.getGrossProfitRate() * 100) + "%",
								op.getRiseIndex().equals("/") ? op.getRiseIndex()
										: df.format(Double.parseDouble(op.getRiseIndex()) * 100) + "%" };
						list.add(array);
					}
				}
				// 设置excel信息
				String showColumnName[] = { "发运日期", "实体收入合计（元）", "实体成本合计（元）", "实体毛利合计（元）", "毛利率", "环比增长率" };// 列名
				String sheetName = "分公司环比表";
				Integer showColumnWidth[] = { 20, 15, 15, 15, 15, 15 };// 列宽
				String fileName = "分公司环比表";

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

	/***
	 * 分公司同比导出（excel）
	 */
	@RequestMapping(value = "/identicalExport.do", method = RequestMethod.GET)
	public void identicalExport(HttpServletRequest request, HttpServletResponse response,
			OperationStatisForOut searchos) {
		try {
			searchos.setGroupName(URLDecoder.decode(searchos.getGroupName(), "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		OrderRequest or = new OrderRequest();
		or.setData(searchos);
		String json = JsonTool.beanTojsonString(or);
		logger.debug("json-------------------------->" + json);
		List<OperationStatisForOut> osList = new ArrayList<OperationStatisForOut>();
		CompanyResult companyAround = new CompanyResult();
		List<String[]> list = new ArrayList<String[]>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_IDENTICALSEAR);
			logger.debug("entity-------------------------->" + entity);
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				companyAround = JSONObject.parseObject(resultInfo, CompanyResult.class);
				osList = companyAround.getList();
				if (osList.size() > 0) {
					for (int i = 0; i < osList.size(); i++) {
						OperationStatisForOut op = osList.get(i);
						String array[] = { op.getBeginTime(), op.getEndTime(), "" + df.format(op.getIncome()),
								"" + df.format(op.getCost()), "" + df.format(op.getGrossProfit()),
								df.format(op.getGrossProfitRate() * 100) + "%",
								op.getRiseIndex().equals("/") ? op.getRiseIndex()
										: df.format(Double.parseDouble(op.getRiseIndex()) * 100) + "%" };
						list.add(array);
					}
				}
				// 设置excel信息
				String showColumnName[] = { "开始时间", "结束时间", "实体收入合计（元）", "实体成本合计（元）", "实体毛利合计（元）", "毛利率", "同比增长率" };// 列名
				String sheetName = "分公司同比表";
				Integer showColumnWidth[] = { 20, 20, 15, 15, 15, 15, 15 };// 列宽
				String fileName = "分公司同比表";

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

	/***
	 * 重点项目监控（excel）
	 */
	@RequestMapping(value = "/monitorExport.do", method = RequestMethod.GET)
	public void monitorExport(String beginTime, String endTime, String platformType, String incomeSum,
			String grossProfitRate, int pageSize, int pageNo, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		PageModel<OperationStatisCustomerForOut> page = new PageModel<OperationStatisCustomerForOut>();
		OperationStatisCustomerForOut osc = new OperationStatisCustomerForOut();
		osc.setBeginTime(beginTime);
		osc.setEndTime(endTime);
		osc.setPlatformType(platformType);// 平台类型
		if (StringUtils.isNotEmpty(incomeSum)) {
			osc.setIncomeSum(Double.parseDouble(incomeSum));// 收入
		} else {
			osc.setIncomeSum(null);
		}
		if (StringUtils.isNotEmpty(grossProfitRate)) {
			osc.setGrossProfitRate(Double.parseDouble(grossProfitRate));// 毛利率
		} else {
			osc.setGrossProfitRate(null);
		}
		page.setObj(osc);
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		OrderRequest or = new OrderRequest();
		or.setData(page);
		String json = JsonTool.beanTojsonString(or);
		logger.info("json-------------------------->" + json);
		List<OperationStatisCustomerForOut> osList = new ArrayList<OperationStatisCustomerForOut>();
		List<String[]> list = new ArrayList<String[]>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CC_MONITOREAR);
			logger.debug("entity-------------------------->" + entity);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("返回结果:" + resultInfo);
				page = JSONObject.parseObject(resultInfo, PageModel.class);
				map.put("page", page);
				JSONObject resultJson = (JSONObject) JSONObject.parse(resultInfo);
				String listJson = resultJson.getString("list");
				osList = JSONArray.parseArray(listJson, OperationStatisCustomerForOut.class);

				if (osList.size() > 0) {
					int u = 0;
					for (OperationStatisCustomerForOut op : osList) {
						String array[] = { op.getGroupName(), op.getCustomerCode(), "" + op.getCustomerName(),
								"" + df.format(op.getIncomeSum()), "" + df.format(op.getCostSum()),
								"" + df.format(op.getGrossProfit()),
								df.format((op.getGrossProfitRate()) == null ? 0.0000
										: (op.getGrossProfitRate()) * 100) + "%" };
						list.add(array);
						u++;
					}
				}
				String type = platformType.equals(osc.CUSTOMER_TYPE_PLATFORM) ? "平台"
						: platformType.equals(osc.CUSTOMER_TYPE_NOT_PLATFORM) ? "实体" : "合计";
				// 设置excel信息
				String showColumnName[] = { "分公司名称", "客户编号", "客户名称", type + "收入（元）", type + "成本（元）", type + "毛利（元）",
						type + "毛利率" };// 列名
				String sheetName = "重点项目监控表";
				Integer showColumnWidth[] = { 20, 15, 25, 15, 15, 15, 15 };// 列宽
				String fileName = "重点项目监控表";

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
}
