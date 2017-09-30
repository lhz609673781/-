package com.ycgwl.kylin.web.report.controller;

import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.BranchOperationForOut;

/**
 * 某项目的运营controller
 * @author 29556
 *
 */

@Controller
@RequestMapping("/projectOperation")
public class ProjectOperationController extends BaseController{
	private static Logger logger = Logger.getLogger(ProjectOperationController.class);
	static ToolUtil tu = new ToolUtil();
	
	/**
	 * 某项目的当天的运营情况
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月1日
	 * @param request
	 * @param response
	 * @param projectName
	 * @return
	 */
	@RequestMapping(value = "/dayOperation_pro.do", method = { RequestMethod.POST,RequestMethod.GET }, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String dayOperation_pro(HttpServletRequest request, HttpServletResponse response,String projectName) {
	
		BranchOperationForOut branchForOut = new BranchOperationForOut();

		if (StringUtils.isEmpty(projectName)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}

		
		branchForOut.setProjectName(projectName);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(branchForOut);

		String json = JsonTool.beanTojsonString(orderRequest);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL +Global.OPERATION_BRANCH_DAY);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");

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
	 * 某项目的一年的吨位变化
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月1日
	 * @param request
	 * @param response
	 * @param projectName
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/tonnageTrend_pro.do", method = { RequestMethod.POST}, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String tonnageTrend_pro(HttpServletRequest request, HttpServletResponse response,String projectName,String beginTime,String endTime) {
	
		BranchOperationForOut branchForOut = new BranchOperationForOut();
		
		branchForOut.setProjectName(projectName);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(branchForOut);
	
		String json = JsonTool.beanTojsonString(orderRequest);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL +Global.OPERATION_BRANCH_WEIGHTCHANGE);
			logger.info("entity---------------------------->" + entity);
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");

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
	 * 某项目的查询时间内的五项指标的变化
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月1日
	 * @param request
	 * @param response
	 * @param projectName
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/indexShow_pro.do", method = { RequestMethod.POST}, produces = {
	"application/json;charset=UTF-8" })
   public @ResponseBody String indexShow_pro(HttpServletRequest request, HttpServletResponse response,String projectName,String beginTime,String endTime) {
	
		BranchOperationForOut branchForOut = new BranchOperationForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) ||StringUtils.isEmpty(projectName) ) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
	
		branchForOut.setProjectName(projectName);
		branchForOut.setBeginTime(beginTime);
		branchForOut.setEndTime(endTime);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(branchForOut);
		
		String json = JsonTool.beanTojsonString(orderRequest);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL +Global.OPERATION_BRANCH_INDEX);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");

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
	 * 某项目的 在查询时间内的详细情况
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月1日
	 * @param request
	 * @param response
	 * @param projectName
	 * @param beginTime
	 * @param endTime
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value = "/operationDetails_pro.do", method = { RequestMethod.POST}, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String operationDetails_pro(HttpServletRequest request, HttpServletResponse response,String projectName,String beginTime,String endTime,Integer pageNo, Integer pageSize) {
		
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) ||StringUtils.isEmpty(projectName) ) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		
		BranchOperationForOut branchForOut = new BranchOperationForOut();
		PageModel<BranchOperationForOut> pageModel = new PageModel<BranchOperationForOut>();
		
        if (pageNo == null){
        	pageNo = 1;
        }			
		if (pageSize == null){
			pageSize = 10;
		}
				
		branchForOut.setProjectName(projectName);
		branchForOut.setBeginTime(beginTime);
		branchForOut.setEndTime(endTime);
		
		pageModel.setObj(branchForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL +Global.OPERATION_BRANCH_DETAIL);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
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
	 * 数据导出
	 * @param request
	 * @param response
	 * @param projectName
	 * @param beginTime
	 * @param endTime
	 * @param pageNo
	 * @param pageSize
	 */
	@RequestMapping(value = "/doProjectDetailsExcele.do", method = { RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public void doProjectDetailsExcele(HttpServletRequest request, HttpServletResponse response, String projectName,
			String beginTime, String endTime, Integer pageNo, Integer pageSize) {

		DecimalFormat df = new DecimalFormat("##0.00");
		BranchOperationForOut branchForOut = new BranchOperationForOut();
		PageModel<BranchOperationForOut> pageModel = new PageModel<BranchOperationForOut>();

		 if (pageNo == null){
			 pageNo =1; 
		 }
		 if (pageSize == null){
			 pageSize =1000000; 
		 }
		
		try {
			
			projectName = (URLDecoder.decode(projectName, "UTF-8")); 
			branchForOut.setProjectName(projectName);
			branchForOut.setBeginTime(beginTime);
			branchForOut.setEndTime(endTime);
			pageModel.setObj(branchForOut);
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);

			OrderRequest orderRequest = new OrderRequest();
			orderRequest.setData(pageModel);
			String json = JsonTool.beanTojsonString(orderRequest);

			List<BranchOperationForOut> branchList = new ArrayList<BranchOperationForOut>();

			List<String[]> list = new ArrayList<String[]>();
			
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_BRANCH_DETAIL);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				branchList = JSONArray.parseArray(datav1, BranchOperationForOut.class);

				if (branchList.size() > 0) {

					int i = 0;

					for (BranchOperationForOut bof : branchList) {

						String boFor[] = { i + 1 + "", bof.getCompanyName(), Integer.toString(bof.getSumOperaNum()),
								df.format(bof.getSumWeight()), df.format(bof.getSumVolume()),
								df.format((bof.getGrossProfitMargin())*100)+"%",
								df.format((bof.getPromptDeliveryRate())*100)+"%",
								df.format((bof.getArrivalRateIntime())*100)+"%", df.format((bof.getQualifiedRateOf())*100)+"%",
								df.format((bof.getInformationEntryRate())*100)+"%"

						};
						list.add(boFor);

						i++;

					}

					String showColumnName[] = { "序列", "公司名称", "票数", "重量(吨)", "体积(立方)", "项目的毛利率指标", "提货及时率", "到货及时率",
							"返单合格率", "信息录入及时率" };// 列名
					String sheetName = projectName + "项目的运营情况";
					Integer showColumnWidth[] = { 8, 15, 15, 15, 15, 15, 15, 15, 15, 15 };// 列宽
					String fileName = projectName + "项目的运营情况";

					String total = projectName + "项目的运营情况";
					String implParam = beginTime + "  至  " + endTime;
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

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

	}
}
