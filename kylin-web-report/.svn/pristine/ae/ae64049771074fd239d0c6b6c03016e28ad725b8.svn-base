package com.ycgwl.kylin.web.report.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.CalcUtils;
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.CompanyMonthGrossProfit;
import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.OperationStatisForOut;

/**
 * v1.3运营统计表-毛利率2张表controller.
 * 
 * @auther lihuixia
 */
@Controller
@RequestMapping("/operationStatis")
public class GrossProfitController extends BaseController {

	static ToolUtil tu = new ToolUtil();

	/**
	 * 毛利率统计表导出.
	 */
	@RequestMapping(value = "/exportGrossProfitStatis.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody void exportGrossProfitStatis(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String platform) throws Exception {
		OperationStatisForOut param = new OperationStatisForOut();
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		param.setPlatform(platform);
		PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();
		pageModel.setObj(param);
		pageModel.setPageNo(1);
		pageModel.setPageSize(1000000000);
		String platStr = null;
		if (OperationStatisForOut.CUSTOMER_TYPE_NOT_PLATFORM.equals(platform)) {
			platStr = "实体";
		} else if (OperationStatisForOut.CUSTOMER_TYPE_PLATFORM.equals(platform)) {
			platStr = "平台";
		} else {
			platStr = "合计";
		}
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		List<String[]> list = new ArrayList<String[]>();
		Map<String, Object> map = new HashMap<String, Object>();
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.GROSSPROFIT_STATIS_URL);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				JSONObject jsonObject = JSONObject.parseObject(resultInfo);
				String listStr = jsonObject.getString("list");
				List<OperationStatisForOut> resultList = JSON.parseArray(listStr, OperationStatisForOut.class);
				for (int i = 0; i < resultList.size(); i++) {
					OperationStatisForOut op = resultList.get(i);
					String array[] = { op.getGroupName() + "分公司", CalcUtils.calcScientficNum(op.getIncome()),
							CalcUtils.calcScientficNum(op.getCost()),
							CalcUtils.calcScientficNum(op.getGrossProfit()),
							CalcUtils.formatNumber(op.getGrossProfitRate() * 100, 2) + "%" };
					list.add(array);
				}
			}
		}

		// 设置excel信息
		String showColumnName[] = { "分公司名称", platStr + "收入（元）", platStr + "成本（元）", platStr + "毛利（元）",
				platStr + "毛利率" };// 列名
		String sheetName = "分公司毛利率统计表";
		Integer showColumnWidth[] = { 20, 15, 20, 30, 15, 15 };// 列宽
		String fileName = "分公司毛利率统计表";
		// String totalSum = "第一行统计内容";
		ExcelForm excelForm = new ExcelForm();
		excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
		excelForm.setList(list);// 导出的内容
		// excelForm.setTotalSumContent(totalSum);
		excelForm.setSheetName(sheetName);
		excelForm.setShowColumnName(showColumnName);
		excelForm.setShowColumnWidth(showColumnWidth);
		ExcelReportUtils.exportExcel(excelForm, response);
	}

	/**
	 * 毛利统计表(ajax).
	 */
	@RequestMapping(value = "/grossProfitStatisAjax.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Map<String, Object> grossProfitStatisAjax(String beginTime, String endTime, String platform,
			String pageNo, String pageSize, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> statisMap = new HashMap<String, Object>();
		OperationStatisForOut param = new OperationStatisForOut();
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		param.setPlatform(platform);
		PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();
		pageModel.setObj(param);
		pageModel.setPageNo(1);
		pageModel.setPageSize(1000000);
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.GROSSPROFIT_STATIS_URL);
			System.out.println("***************controller******************" + entity);
			
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					PageModel<OperationStatisForOut> resultPageModel = JSONObject.parseObject(resultInfo,
							PageModel.class);
					statisMap.put("statisPage", resultPageModel);
					statisMap.put("mas", "success");
				} else {
					statisMap.put("mas", "error");
				}
			} catch (Exception e) {
				statisMap.put("mas", "error");
			}
		}
		return statisMap;
	}

	/**
	 * 毛利统计表.
	 */
	@RequestMapping(value = "/grossProfitStatis.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView grossProfitStatis(String beginTime, String endTime, String platform, String pageNo,
			String pageSize, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> statisMap = new HashMap<String, Object>();
		OperationStatisForOut param = new OperationStatisForOut();
		Calendar c = Calendar.getInstance();
		int day = c.get(Calendar.DATE);
		if (day != 1) {
			param.setBeginTime(DateUtils.toFirstDayOfMonth(beginTime));
			param.setEndTime(DateUtils.toYesterDayOfMonth(endTime));
		} else {
			param.setBeginTime(DateUtils.firstDateOfTerdayMonth());
			param.setEndTime(DateUtils.yesterday());
		}
		statisMap.put("beginTime", param.getBeginTime());
		statisMap.put("endTime", param.getEndTime());
		param.setPlatform(platform);
		PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();
		pageModel.setObj(param);
		pageModel.setPageNo(1);
		pageModel.setPageSize(100000);
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.GROSSPROFIT_STATIS_URL);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					PageModel<OperationStatisForOut> resultPageModel = JSONObject.parseObject(resultInfo,
							PageModel.class);
					statisMap.put("statisPage", resultPageModel);
					statisMap.put("mas", "success");
				} else {
					statisMap.put("mas", "error");
				}
			} catch (Exception e) {
				statisMap.put("mas", "error");
			}
		}
		return new ModelAndView("sheet/grossProfitStatis").addAllObjects(statisMap);
	}

	/**
	 * 毛利对比表.
	 */
	@RequestMapping(value = "/grossProfitCompareAjax.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Map<String, Object> grossProfitCompareAjax(String year, String month, String platform,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		OperationStatisForOut forOut = new OperationStatisForOut();
		if (StringUtils.isBlank(year) && StringUtils.isBlank(month)) {
			month = new SimpleDateFormat("MM").format(new Date());
			year = new SimpleDateFormat("yyyy").format(new Date());
		}
		forOut.setDate(year + "-" + month);
		forOut.setYearParam(Integer.valueOf(year));
		forOut.setMonthParam(Integer.valueOf(month));
		forOut.setPlatform(platform);
		OrderRequest or = new OrderRequest();
		or.setData(forOut);
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = tu.RequestPost(response, json, LHX_URL + Global.GROSSPROFIT_COMPARE_URL);
			
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					List<CompanyMonthGrossProfit> monthRateList = JSONObject.parseArray(resultInfo,
							CompanyMonthGrossProfit.class);
					map.put("list", monthRateList);
					map.put("mas", "success");
				} else {
					map.put("mas", "error");
				}
			} catch (Exception e) {
				map.put("mas", "error");
			}
		}	
		return map;
	}

	/**
	 * 毛利对比表.
	 */
	@RequestMapping(value = "/grossProfitCompare.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView grossProfitCompare(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		OperationStatisForOut forOut = new OperationStatisForOut();
		int year;
		int month;
		Calendar c = Calendar.getInstance();
		int day = c.get(Calendar.DATE);
		if (day != 1) {
			month = c.get(Calendar.MONTH) + 1;
			year = c.get(Calendar.YEAR);
		} else {
			month = c.get(Calendar.MONTH);
			year = c.get(Calendar.YEAR);
		}
		map.put("month", month);
		map.put("year", year);
		forOut.setDate(year + "-" + (month < 10 ? "0" + month : month + ""));
		forOut.setYearParam(Integer.valueOf(year));
		forOut.setMonthParam(Integer.valueOf(month));
		forOut.setPlatform(null);
		OrderRequest or = new OrderRequest();
		or.setData(forOut);
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = tu.RequestPost(response, json, LHX_URL + Global.GROSSPROFIT_COMPARE_URL);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					List<CompanyMonthGrossProfit> monthRateList = JSONObject.parseArray(resultInfo,
							CompanyMonthGrossProfit.class);
					map.put("list", monthRateList);
					map.put("mas", "success");
				} else {
					map.put("mas", "error");
				}
			} catch (Exception e) {
				map.put("mas", "error");
			}		
		}
		return new ModelAndView("sheet/grossProfitCompare").addAllObjects(map);
	}

	/**
	 * 毛利对比表导出.
	 */
	@RequestMapping(value = "/exportGrossProfitCompare.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody void exportGrossProfitCompare(String year, String month, String platform,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		OperationStatisForOut forOut = new OperationStatisForOut();
		if (StringUtils.isBlank(year) && StringUtils.isBlank(month)) {
			month = new SimpleDateFormat("MM").format(new Date());
			year = new SimpleDateFormat("yyyy").format(new Date());
		}
		forOut.setDate(year + "-" + month);
		forOut.setYearParam(Integer.valueOf(year));
		forOut.setMonthParam(Integer.valueOf(month));
		forOut.setPlatform(platform);
		OrderRequest or = new OrderRequest();
		or.setData(forOut);
		int daysOfCurrMonth = DateUtils.getDayCountOfMonth(Integer.valueOf(year), Integer.valueOf(month));
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = tu.RequestPost(response, json, LHX_URL + Global.GROSSPROFIT_COMPARE_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				List<CompanyMonthGrossProfit> monthRateList = JSONObject.parseArray(resultInfo,
						CompanyMonthGrossProfit.class);
				List<String[]> list = new ArrayList<String[]>();
				for (int i = 0; i < monthRateList.size(); i++) {
					CompanyMonthGrossProfit profit = monthRateList.get(i);
					List<Double> rateList = profit.getGrossProfitRateList();
					String rowsContent[] = new String[32];
					rowsContent[0] = profit.getGroupName() + "分公司";
					for (int j = 1; j <= daysOfCurrMonth; j++) {
						rowsContent[j] = CalcUtils.formatNumber(rateList.get(j - 1) * 100, 2) + "%";
					}
					list.add(rowsContent);
				}

				// 设置excel信息
				String showColumnName[] = new String[daysOfCurrMonth + 1];// 列名
				showColumnName[0] = "分公司名称";
				for (int i = 1; i <= showColumnName.length - 1; i++) {
					showColumnName[i] = (month.length() > 1 ? month : ("0" + month)) + "-" + (i > 9 ? "" + i : "0" + i);// 月-日
																														// mm-dd
				}
				String sheetName = "分公司毛利率对比表";
				Integer showColumnWidth[] = { 15, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
						10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 };// 列宽
				String fileName = "分公司毛利率对比表";
				ExcelForm excelForm = new ExcelForm();
				excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
				excelForm.setList(list);// 导出的内容
				excelForm.setSheetName(sheetName);
				excelForm.setShowColumnName(showColumnName);
				excelForm.setShowColumnWidth(showColumnWidth);
				ExcelReportUtils.exportExcel(excelForm, response);
			}
		}
	}
}
