package com.ycgwl.kylin.web.report.controller;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.core.ResponseUtil;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.CarBasicFormForOut;
import ycapp.dbinterface.bean.OperationGroupReportSearchForOut;
import ycapp.dbinterface.bean.OperationStatisForOut;

/**
 * 分公司毛利率的详情统计_controller
 * @author litao
 *
 */
@Controller
@RequestMapping("/marginDetails")
public class MarginDetailsController extends BaseController {

	private static Logger logger = Logger.getLogger(MarginDetailsController.class);
	static ToolUtil tu = new ToolUtil();
	/**
	 *展示所有公司的名称
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/findAllCompany.do", method = { RequestMethod.POST })
	public @ResponseBody String findAllCompany(HttpServletRequest request, HttpServletResponse response) {
		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);

		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_FINDCOMPANY);
			logger.info("entity---------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				JSONObject jsonResult = JSONObject.parseObject(
						ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				System.out.println("返回数据----------------------------->" + jsonResult);

				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo);

			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {

				return ResponseUtil.toJsonObject(Global.PARAM_CODE, Global.QUERY_FAIL);

			} else {

				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
		}

	}

	/**
	 * 收入，成本，毛利，毛利率的月度走势图（年月日）
	 * @param request
	 * @param response
	 * @param groupName
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/monthlyChartByDay.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String monthlyChartByDay(HttpServletRequest request, HttpServletResponse response,
			String groupName, String endTime ) {

		OrderRequest orderRequest = new OrderRequest();
		OperationStatisForOut operationStatisForOut = new OperationStatisForOut();

		operationStatisForOut.setGroupName(groupName);
		operationStatisForOut.setEndTime(endTime);
		orderRequest.setData(operationStatisForOut );

		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_BYDAY);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
				return ResponseUtil.toJsonObject(Global.PARAM_CODE, reason);
			} else {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);

		}

	}
   /** 
    * 分公司毛利率详情统计（年月日）
    * @param request
    * @param response
    * @param groupName
    * @param beginTime
    * @param endTime
    * @return
    */
	@RequestMapping(value = "/monthlyChartDetailByDay.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String monthlyChartDetailByDay(HttpServletRequest request, HttpServletResponse response,
			String groupName, String beginTime, String endTime,Integer pageNo, Integer pageSize) {

		
		OperationStatisForOut operationStatisForOut = new OperationStatisForOut();
		
		PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();

		if (pageNo == null){
			pageNo = 1;
		}
			
		if (pageSize == null){
			pageSize = 10;
		}
		
		

		operationStatisForOut.setGroupName(groupName);
		operationStatisForOut.setBeginTime(beginTime);
		operationStatisForOut.setEndTime(endTime);
		pageModel.setObj(operationStatisForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_DETAILBYDAY);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
				return ResponseUtil.toJsonObject(Global.PARAM_CODE, reason);
			} else {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);

		}

	}
	
	
	
	/**
	 * 年月日数据导出
	 * @param request
	 * @param response
	 * @param PageNo
	 * @param PageSize
	 * @param carCompany
	 * @param carType
	 */
	@RequestMapping(value = "/monthlyChartDetailByDayExcelImpl.do", method ={ RequestMethod.GET,RequestMethod.POST})
	public void monthlyChartDetailByDayExcelImpl(HttpServletRequest request, HttpServletResponse response, String groupName, String beginTime,
			String endTime,Integer pageNo, Integer pageSize) {
		try {
			groupName=java.net.URLDecoder.decode(groupName,"utf-8");
			
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		DecimalFormat df = new DecimalFormat("##0.00");
		logger.info("welcome to into monthlyChartDetailByMonthExcelImpl method!!!!!!");
        
		PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();
		OperationStatisForOut operationStatisForOut = new OperationStatisForOut();
		
		if (pageNo == null){
			pageNo = 1;
		}
		
		if (pageSize == null){
			pageSize = 100000000;
		}
				
		operationStatisForOut.setGroupName(groupName);
		operationStatisForOut.setBeginTime(beginTime);
		operationStatisForOut.setEndTime(endTime);
		pageModel.setObj(operationStatisForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<OperationStatisForOut> operationStatisForList = new ArrayList<OperationStatisForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_DETAILBYDAY);
   			logger.info("entity---------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
			   
				String datav1 = jsonobjv1.getString("list");

				operationStatisForList = JSONArray.parseArray(datav1, OperationStatisForOut.class);

				if (operationStatisForList.size() > 0) {
					int i = 0;   
					for (OperationStatisForOut osf : operationStatisForList) {

						String osFor[] = { i + 1 + "" ,osf.getDate(),df.format(osf.getIncome()),df.format(osf.getCost()),df.format(osf.getGrossProfit()),df.format(osf.getGrossProfitRate())};
						
						list.add(osFor);

						i++;
						
					}

				}
					
					// 设置excel信息
					String showColumnName[] = { "序列", "日期", "合计收入", "合计成本", "合计毛利", "合计毛利率"};// 列名
					String sheetName = groupName+"分公司查询时间段内详情";
					Integer showColumnWidth[] = { 8, 15,15,15,15,15 };// 列宽
					String fileName =groupName+"分公司的查询时间毛利详情表" ;

					String total=groupName+"分公司的毛利详情表";
                    String implParam=beginTime+"到"+endTime;
					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
					excelForm.setImplParam(implParam);
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
     * 收入，成本，毛利，毛利率的月度走势图（年月）
     * @param request
     * @param response
     * @param groupName
     * @param beginTime
     * @param endTime
     * @return
     */
	@RequestMapping(value = "/monthlyChartByMonth.do", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = { "application/json;charset=UTF-8" })
	public @ResponseBody String monthlyChartByMonth(HttpServletRequest request, HttpServletResponse response,
			String groupName,  String endTime) {

		OrderRequest orderRequest = new OrderRequest();
		OperationStatisForOut operationStatisForOut = new OperationStatisForOut();

		operationStatisForOut.setGroupName(groupName);
		operationStatisForOut.setEndTime(endTime);
		orderRequest.setData(operationStatisForOut);

		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_BYMONTH);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
				return ResponseUtil.toJsonObject(Global.PARAM_CODE, reason);
			} else {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);

		}

	}
	
	/**
	 * 分公司毛利率详情统计（年月）
	 * @param request
	 * @param response
	 * @param groupName
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/monthlyChartDetailByMonth.do", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = { "application/json;charset=UTF-8" })
	public @ResponseBody String monthlyChartDetailByMonth(HttpServletRequest request, HttpServletResponse response,
			String groupName, String beginTime, String endTime,Integer pageNo, Integer pageSize) {

		PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();
		
		OperationStatisForOut operationStatisForOut = new OperationStatisForOut();
		
		if (pageNo == null){
			pageNo = 1;
		}
			
		if (pageSize == null){
			pageSize = 10;
		}
		
		operationStatisForOut.setGroupName(groupName);
		operationStatisForOut.setBeginTime(beginTime);
		operationStatisForOut.setEndTime(endTime);
		pageModel.setObj(operationStatisForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
     	String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_DETAILBYMONTH);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
				return ResponseUtil.toJsonObject(Global.PARAM_CODE, reason);
			} else {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);

		}

	}
	
	
	/**
	 * 年月数据导出
	 * @param request
	 * @param response
	 * @param PageNo
	 * @param PageSize
	 * @param carCompany
	 * @param carType
	 */
	@RequestMapping(value = "/monthlyChartDetailByMonthExcelImpl.do", method ={ RequestMethod.GET,RequestMethod.POST})
	public void monthlyChartDetailByMonthExcelImpl(HttpServletRequest request, HttpServletResponse response, String groupName, String beginTime,
			String endTime,Integer pageNo, Integer pageSize) {
		try {
			groupName=java.net.URLDecoder.decode(groupName,"utf-8");
			
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		DecimalFormat df = new DecimalFormat("##0.00");
		logger.info("welcome to into monthlyChartDetailByMonthExcelImpl method!!!!!!");
        
		PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();
		OperationStatisForOut operationStatisForOut = new OperationStatisForOut();
		
		if (pageNo == null){
			pageNo = 1;
		}
		
		if (pageSize == null){
			pageSize = 100000000;
		}
				
		operationStatisForOut.setGroupName(groupName);
		operationStatisForOut.setBeginTime(beginTime);
		operationStatisForOut.setEndTime(endTime);
		pageModel.setObj(operationStatisForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<OperationStatisForOut> operationStatisForList = new ArrayList<OperationStatisForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_DETAILBYMONTH);
   			logger.info("entity---------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
			   
				String datav1 = jsonobjv1.getString("list");

				operationStatisForList = JSONArray.parseArray(datav1, OperationStatisForOut.class);

				if (operationStatisForList.size() > 0) {
					int i = 0;   
					for (OperationStatisForOut osf : operationStatisForList) {

						String osFor[] = { i + 1 + "" ,osf.getDate(),df.format(osf.getIncome()),df.format(osf.getCost()),df.format(osf.getGrossProfit()),df.format(osf.getGrossProfitRate())};
						
						list.add(osFor);

						i++;
						
					}

				}
					
					// 设置excel信息
					String showColumnName[] = { "序列", "日期", "合计收入", "合计成本", "合计毛利", "合计毛利率"};// 列名
					String sheetName = groupName+"分公司查询时间段内详情";
					Integer showColumnWidth[] = { 8, 15,15,15,15,15 };// 列宽
					String fileName =groupName+"分公司的查询时间毛利详情表" ;

					String total=groupName+"分公司的毛利详情表";
                    String implParam=beginTime+"到"+endTime;
					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
					excelForm.setImplParam(implParam);
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
	 * 指标
	 * @param request
	 * @param response
	 * @param groupName
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/showIndicator.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String showIndicator(HttpServletRequest request, HttpServletResponse response,
			String groupName,String endTime ) {

		OrderRequest orderRequest = new OrderRequest();
		OperationGroupReportSearchForOut searchForOut= new OperationGroupReportSearchForOut();

		searchForOut.setCompanyName(groupName);
		searchForOut.setBeginTime(DateUtils.getLastMonth(endTime));
		searchForOut.setEndTime(endTime);
		
		orderRequest.setData(searchForOut );

		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_INDICATOR);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
				return ResponseUtil.toJsonObject(Global.PARAM_CODE, reason);
			} else {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);

		}

	}
	
	
	/** 
	    * 点击进行排序
	    * @param request
	    * @param response
	    * @param groupName
	    * @param beginTime
	    * @param endTime
	    * @return
	    */
		@RequestMapping(value = "/orderBy.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
				"application/json;charset=UTF-8" })
		public @ResponseBody String orderBy(HttpServletRequest request, HttpServletResponse response,
				String groupName, String orderParame, String beginTime, String endTime,Integer pageNo, Integer pageSize) {

			
			OperationStatisForOut operationStatisForOut = new OperationStatisForOut();
			
			PageModel<OperationStatisForOut> pageModel = new PageModel<OperationStatisForOut>();

			if (pageNo == null){
				pageNo = 1;
			}
				
			if (pageSize == null){
				pageSize = 10;
			}
			
			

			operationStatisForOut.setGroupName(groupName);
			operationStatisForOut.setBeginTime(beginTime);
			operationStatisForOut.setEndTime(endTime);
			operationStatisForOut.setOrderParame(orderParame);
			pageModel.setObj(operationStatisForOut);
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);

			OrderRequest orderRequest = new OrderRequest();
			orderRequest.setData(pageModel);
			String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
			try {

				String entity = tu.RequestPost(response, json, LHX_URL + Global.MARGIN_DETAILBYDAY);
				logger.info("entity---------------------------->" + entity);

				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					logger.info("resultInfo----------------------------->" + resultInfo);
					System.out.println("返回数据----------------------------->"
							+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
					return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
				} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
					return ResponseUtil.toJsonObject(Global.PARAM_CODE, reason);
				} else {
					return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
				}
			} catch (Exception e) {
				e.printStackTrace();
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);

			}

		}
		
	
	
}
