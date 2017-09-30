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
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.OperationClaimReportForOut;

/**
 * 
 * @Description: 理赔表（新）控制层
 * @author <a href="mailto:93253@ycgwl.com">yeyunsong</a>
 * @date 2017年7月6日 上午9:07:49
 * @version V1.5
 *
 */
@Controller
@RequestMapping("/operationClaimReport")
public class OperationClaimReportController extends BaseController {

	private static Logger logger = Logger.getLogger(OperationClaimReportController.class);
	static ToolUtil tu = new ToolUtil();

	/**
	 * 理赔表数据查询.
	 */
	@RequestMapping(value = "/findList.do", method = { RequestMethod.POST })
	public @ResponseBody String findList(HttpServletRequest request, HttpServletResponse response, String beginTime,
			String endTime, String customerName, String companyName, Integer pageNo, Integer pageSize)
					throws Exception {
		logger.info("welcome to into findList method!!!!!!");
		OperationClaimReportForOut param = new OperationClaimReportForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			endTime = DateUtils.yesterday();
			beginTime = DateUtils.monthTerday();
		}
		/***** 设置默认时间 ******/
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		if (StringUtils.isEmpty(customerName)){
			customerName = null;
		}		
		if (StringUtils.isEmpty(companyName)){
			companyName = null;
		}
			
		param.setCustomerName(customerName);
		param.setCompanyName(companyName);
		PageModel<OperationClaimReportForOut> pageModel = new PageModel<OperationClaimReportForOut>();
		if (pageNo == null){
			pageNo = 1;
		}	
		if (pageSize == null){
			pageSize = 10;
		}
			
		pageModel.setObj(param);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);
		String entity = tu.RequestPost(response, json, LHX_URL + Global.OP_REPORT);
		logger.info("entity---------------------------->" + entity);
		
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");// 返回数据
			return ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo);

		} else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, Global.QUERY_FAIL);
		} else {
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
		}
	}

	/***
	 * 返单统计（excel导出）
	 */
	@RequestMapping(value = "/oprationClaim.do", method = { RequestMethod.GET })
	public void oprationClaim(HttpServletRequest request, HttpServletResponse response, String beginTime,
			String endTime, String customerName, String companyName, Integer pageNo, Integer pageSize)
					throws Exception {
		// 工具类（保留小数后面两位）
		DecimalFormat df = new DecimalFormat("##0.00");
		logger.info("welcome to into findList method!!!!!!");
		OperationClaimReportForOut param = new OperationClaimReportForOut();

		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			endTime = DateUtils.yesterday();
			beginTime = DateUtils.monthTerday();
		}

		companyName = (URLDecoder.decode(companyName, "UTF-8"));
		customerName = (URLDecoder.decode(customerName, "UTF-8"));
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);

		// 公司为空，客户为空
		if (StringUtils.isEmpty(companyName) && StringUtils.isEmpty(customerName)) {
			customerName = null;
			companyName = null;
			param.setCustomerName(customerName);
			param.setCompanyName(companyName);
			PageModel<OperationClaimReportForOut> pageModel = new PageModel<OperationClaimReportForOut>();

			if (pageSize == null){
				pageSize = 1000000000;
			}
			pageModel.setObj(param);
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);

			OrderRequest or = new OrderRequest();
			or.setData(pageModel);
			String json = JsonTool.beanTojsonString(or);

			List<OperationClaimReportForOut> opForList = new ArrayList<OperationClaimReportForOut>();

			List<String[]> list = new ArrayList<String[]>();

			String entity = tu.RequestPost(response, json, LHX_URL + Global.OP_REPORT);

			logger.info("entity---------------------------->" + entity);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("operationClaimReportResult");

				JSONObject jsonobjv2 = JSONObject.parseObject(datav1);
				String datav2 = jsonobjv2.getString("pageModel");

				JSONObject jsonobjv3 = JSONObject.parseObject(datav2);
				String datav3 = jsonobjv3.getString("list");

				opForList = JSONArray.parseArray(datav3, OperationClaimReportForOut.class);

				if (opForList.size() > 0) {
					int i = 0;
					for (OperationClaimReportForOut of : opForList) {

						// 异常占比
						double f0 = ((double) of.getAbnormalSum() / (double) of.getTotalSum()) * 100;
						String exception = df.format(f0);

						// 赔付额
						double f = of.getPayAmount() / 10000;
						String payAmount1 = df.format(f);

						// 赔付占比
						double f1 = of.getPayAmount() / of.getBusinIncome() * 100;
						String payBusin1 = df.format(f1);

						// 供应商承担
						double f2 = of.getCarrierPay() / of.getPayAmount() * 100;
						String carrierPay1 = df.format(f2);

						// 保险公司
						double f3 = of.getInsurancePay() / of.getPayAmount() * 100;
						String InsurancePay1 = df.format(f3);

						// 自留风险
						double f4 = of.getCompanyPay() / of.getPayAmount() * 100;
						String CompanyPay1 = df.format(f4);

						String opFor[] = { i + 1 + "", of.getCustomerName(), of.getCompanyName(), payAmount1,
								Integer.toString(of.getPaymentSum()), payBusin1 + "%", exception + "%",
								carrierPay1 + "%", InsurancePay1 + "%", CompanyPay1 + "%", of.getGuestType() };
						list.add(opFor);

						i++;
					}

				}
				// 设置excel信息
				String showColumnName[] = { "序号", "客户公司名称", "远程公司", "赔付额（万元）", "赔付票数", "赔付占比", "异常理赔占比", "供应商承担",
						"保险公司承担", "自留风险", "客户行业", };// 列名
				String sheetName = "集团下所有分公司的所有有过理赔的客户";
				Integer showColumnWidth[] = { 8, 55, 15, 15, 15, 15, 15, 15, 15, 15, 15 };// 列宽
				String fileName = "集团下所有分公司的所有有过理赔的客户";

				String total = "集团下所有客户";
				String implParam = beginTime + "  至  " + endTime;

				ExcelForm excelForm = new ExcelForm();
				excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
				excelForm.setList(list);// 导出的内容
				excelForm.setTotal(total);// 标题
				excelForm.setImplParam(implParam);// 第二行标题
				excelForm.setSheetName(sheetName);
				excelForm.setShowColumnName(showColumnName);
				excelForm.setShowColumnWidth(showColumnWidth);
				ExcelReportUtils.exportExcel(excelForm, response);
			}
			// ===========================================================================================================>>>>>>>>>>>>>>

			// 公司不为空 客户不为空
		} else if (StringUtils.isNotEmpty(companyName) && StringUtils.isNotEmpty(customerName)) {
			param.setCustomerName(customerName);
			param.setCompanyName(companyName);
			PageModel<OperationClaimReportForOut> pageModel = new PageModel<OperationClaimReportForOut>();
			if (pageNo == null){
				pageNo = 1;
			}		
			if (pageSize == null){
				pageSize = 1000000000;
			}
				
			pageModel.setObj(param);
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);

			OrderRequest or = new OrderRequest();
			or.setData(pageModel);
			String json1 = JsonTool.beanTojsonString(or);

			String entity1 = tu.RequestPost(response, json1, LHX_URL + Global.OP_REPORT);

			logger.info("entity---------------------------->" + entity1);
		
			JSONObject httpresult1 = JSONObject.parseObject(entity1);
			String resultCode1 = httpresult1.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode1)) {

				String resultInfo = httpresult1.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("operationClaimReportResult");

				JSONObject jsonobjv2 = JSONObject.parseObject(datav1);
				String datav2 = jsonobjv2.getString("pageModel");

				JSONObject jsonobjv3 = JSONObject.parseObject(datav2);
				String datav3 = jsonobjv3.getString("list");
				List<OperationClaimReportForOut> opForList = new ArrayList<OperationClaimReportForOut>();
				List<String[]> list = new ArrayList<String[]>();
				opForList = JSONArray.parseArray(datav3, OperationClaimReportForOut.class);

				if (opForList.size() > 0) {
					int i = 0;
					for (OperationClaimReportForOut of : opForList) {

						// 异常占比
						double f0 = ((double) of.getAbnormalSum() / (double) of.getTotalSum()) * 100;
						String exception = df.format(f0);

						// 赔付额
						double f = of.getPayAmount() / 10000;
						String payAmount1 = df.format(f);

						// 赔付占比
						double f1 = of.getPayAmount() / of.getBusinIncome() * 100;
						String payBusin1 = df.format(f1);

						// 供应商承担
						double f2 = of.getCarrierPay() / of.getPayAmount() * 100;
						String carrierPay1 = df.format(f2);

						// 保险公司
						double f3 = of.getInsurancePay() / of.getPayAmount() * 100;
						String InsurancePay1 = df.format(f3);

						// 自留风险
						double f4 = of.getCompanyPay() / of.getPayAmount() * 100;
						String CompanyPay1 = df.format(f4);

						String opFor[] = { i + 1 + "",payAmount1, Integer.toString(of.getPaymentSum()), payBusin1 + "%",
								exception + "%", carrierPay1 + "%", InsurancePay1 + "%", CompanyPay1 + "%" };
						list.add(opFor);

						i++;

					}

				}

				// String totalSumContent="理赔统计报表";

				String showColumnName[] = { "序号" , "赔付额（万元）", "赔付票数", "赔付占比", "异常理赔占比", "需供应商承担", "需保险公司承担", "自留风险" };// 列名
				String sheetName = "某公司某客户";
				// String
				// sheetName=beginTime+"To"+endTime+"下"+companyName+"下"+customerName;
				Integer showColumnWidth[] = { 8,15, 15, 15, 15, 15, 15, 15 };// 列宽
				String fileName = "某公司某客户";
				// String fileName =
				// beginTime+"To"+endTime+"下"+companyName+"下"+customerName;
				String total = companyName + "下" + customerName;
				String implParam = beginTime + "  至  " + endTime;

				ExcelForm excelForm = new ExcelForm();

				excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
				excelForm.setList(list);// 导出的内容
				excelForm.setSheetName(sheetName);
				excelForm.setShowColumnName(showColumnName);
				excelForm.setShowColumnWidth(showColumnWidth);
				excelForm.setTotal(total);
				excelForm.setImplParam(implParam);
				ExcelReportUtils.exportExcel(excelForm, response);

			}
			// 公司为空，客户不为空
		} else if (StringUtils.isEmpty(companyName) && StringUtils.isNotEmpty(customerName)) {
			companyName = null;
			param.setCustomerName(customerName);
			PageModel<OperationClaimReportForOut> pageModel = new PageModel<OperationClaimReportForOut>();
			if (pageSize == null){
				pageSize = 1000000000;
			}
		
			pageModel.setObj(param);
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);
			OrderRequest or = new OrderRequest();
			or.setData(pageModel);
			String json1 = JsonTool.beanTojsonString(or);
			String entity = tu.RequestPost(response, json1, LHX_URL + Global.OP_REPORT);

			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult1 = JSONObject.parseObject(entity);
			String resultCode1 = httpresult1.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode1)) {

				String resultInfo = httpresult1.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("operationClaimReportResult");

				JSONObject jsonobjv2 = JSONObject.parseObject(datav1);
				String datav2 = jsonobjv2.getString("pageModel");

				JSONObject jsonobjv3 = JSONObject.parseObject(datav2);
				String datav3 = jsonobjv3.getString("list");

				List<OperationClaimReportForOut> opForList = new ArrayList<OperationClaimReportForOut>();
				List<String[]> list = new ArrayList<String[]>();

				opForList = JSONArray.parseArray(datav3, OperationClaimReportForOut.class);

				if (opForList.size() > 0) {
					int i = 0;
					for (OperationClaimReportForOut of : opForList) {

						// 异常占比
						double f0 = ((double) of.getAbnormalSum() / (double) of.getTotalSum()) * 100;
						String exception = df.format(f0);

						// 赔付额
						double f = of.getPayAmount() / 10000;
						String payAmount1 = df.format(f);

						// 赔付占比
						double f1 = of.getPayAmount() / of.getBusinIncome() * 100;
						String payBusin1 = df.format(f1);

						// 供应商承担
						double f2 = of.getCarrierPay() / of.getPayAmount() * 100;
						String carrierPay1 = df.format(f2);

						// 保险公司
						double f3 = of.getInsurancePay() / of.getPayAmount() * 100;
						String InsurancePay1 = df.format(f3);

						// 自留风险
						double f4 = of.getCompanyPay() / of.getPayAmount() * 100;
						String CompanyPay1 = df.format(f4);
						String opFor[] = {i + 1 + "", of.getCompanyName(), payAmount1, Integer.toString(of.getPaymentSum()),
								payBusin1 + "%", exception + "%", carrierPay1 + "%", InsurancePay1 + "%",
								CompanyPay1 + "%" };
						list.add(opFor);

						i++;

					}
				}
				// 设置excel信息
				String showColumnName[] = { "序号" ,"远成公司", "赔付额（万元）", "赔付票数", "赔付占比", "异常理赔占比", "需供应商承担", "需保险公司承担",
						"自留风险" };// 列名
				String sheetName = "某客户理赔情况";
				Integer showColumnWidth[] = { 8 , 20, 15, 15, 15, 15, 15, 15, 15 };// 列宽
				String fileName = "某客户理赔情况";
				String implParam = beginTime + "  至  " + endTime;
				String total = "集团下" + customerName;
				;
				ExcelForm excelForm = new ExcelForm();
				excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
				excelForm.setList(list);// 导出的内容
				excelForm.setTotal(total);
				excelForm.setImplParam(implParam);
				excelForm.setSheetName(sheetName);
				excelForm.setShowColumnName(showColumnName);
				excelForm.setShowColumnWidth(showColumnWidth);
				ExcelReportUtils.exportExcel(excelForm, response);

			}
			// 公司不为空，客户为空
		} else if (StringUtils.isNotEmpty(companyName) && StringUtils.isEmpty(customerName)) {
			customerName = null;
			param.setCompanyName(companyName);
			System.out.println("123456789");
			PageModel<OperationClaimReportForOut> pageModel = new PageModel<OperationClaimReportForOut>();

			if (pageSize == null){
				pageSize = 1000000000;
			}
			pageModel.setObj(param);
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);
			OrderRequest or = new OrderRequest();
			or.setData(pageModel);
			String json1 = JsonTool.beanTojsonString(or);
			String entity1 = tu.RequestPost(response, json1, LHX_URL + Global.OP_REPORT);

			logger.info("entity---------------------------->" + entity1);
			
			JSONObject httpresult1 = JSONObject.parseObject(entity1);
			String resultCode1 = httpresult1.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode1)) {

				String resultInfo = httpresult1.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("operationClaimReportResult");

				JSONObject jsonobjv2 = JSONObject.parseObject(datav1);
				String datav2 = jsonobjv2.getString("pageModel");

				JSONObject jsonobjv3 = JSONObject.parseObject(datav2);
				String datav3 = jsonobjv3.getString("list");

				List<OperationClaimReportForOut> opForList = new ArrayList<OperationClaimReportForOut>();
				List<String[]> list = new ArrayList<String[]>();

				opForList = JSONArray.parseArray(datav3, OperationClaimReportForOut.class);

				if (opForList.size() > 0) {
					int i = 0;
					for (OperationClaimReportForOut of : opForList) {

						// 异常占比
						double f0 = ((double) of.getAbnormalSum() / (double) of.getTotalSum()) * 100;
						String exception = df.format(f0);

						// 赔付额
						double f = of.getPayAmount() / 10000;
						String payAmount1 = df.format(f);

						// 赔付占比
						double f1 = of.getPayAmount() / of.getBusinIncome() * 100;
						String payBusin1 = df.format(f1);

						// 供应商承担
						double f2 = of.getCarrierPay() / of.getPayAmount() * 100;
						String carrierPay1 = df.format(f2);

						// 保险公司
						double f3 = of.getInsurancePay() / of.getPayAmount() * 100;
						String InsurancePay1 = df.format(f3);

						// 自留风险
						double f4 = of.getCompanyPay() / of.getPayAmount() * 100;
						String CompanyPay1 = df.format(f4);

						String opFor[] = { i + 1 + "",of.getCustomerName(), payAmount1, Integer.toString(of.getPaymentSum()),
								payBusin1 + "%", exception + "%", carrierPay1 + "%", InsurancePay1 + "%",
								CompanyPay1 + "%", of.getGuestType() };
						list.add(opFor);

						i++;

					}

				}
				// 设置excel信息
				String showColumnName[] = { "序号" , "客户公司名称", "赔付额（万元）", "赔付票数", "赔付占比", "异常理赔占比", "需供应商承担", "需保险公司承担",
						"自留风险", "客户行业" };// 列名
				String sheetName = "某分公司下的所有客户理赔情况";
				Integer showColumnWidth[] = { 8 , 55, 15, 15, 15, 15, 15, 15, 15, 15 };// 列宽
				String fileName = "某分公司下的所有客户理赔情况";
				String implParam = beginTime + "  至  " + endTime;
				String total = companyName + "下所有客户";
				ExcelForm excelForm = new ExcelForm();
				excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
				excelForm.setList(list);// 导出的内容
				excelForm.setTotal(total);
				excelForm.setImplParam(implParam);
				excelForm.setSheetName(sheetName);
				excelForm.setShowColumnName(showColumnName);
				excelForm.setShowColumnWidth(showColumnWidth);
				ExcelReportUtils.exportExcel(excelForm, response);

			}

		}
	}

	/**
	 * 某个时间内产生的理赔的公司
	 * 
	 * @param request
	 * @param response
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/companyList.do", method = { RequestMethod.POST })
	public @ResponseBody String findAll_ClaimCompany(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime) {
		logger.info("-----------------------查询所有产生理赔的分公司------------------------------------------");
		OperationClaimReportForOut ofo = new OperationClaimReportForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			endTime = DateUtils.yesterday();
			beginTime = DateUtils.monthTerday();
		}
		ofo.setBeginTime(beginTime);
		ofo.setEndTime(endTime);
		OrderRequest or = new OrderRequest();
		or.setData(ofo);
		String json = JsonTool.beanTojsonString(or);
		String entity;
		try {

			entity = tu.RequestPost(response, json, LHX_URL + Global.OP_SERCOMPANY);
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
	 * 头部的模糊查询
	 */

	@RequestMapping(value = "/customerList.do", method = { RequestMethod.POST })
	public @ResponseBody String find(HttpServletRequest request, HttpServletResponse response, String beginTime,
			String endTime, String customerName, String companyName) {
		logger.info("-----------------------头部的模糊查詢------------------------------------------");
		OperationClaimReportForOut ofo = new OperationClaimReportForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			endTime = DateUtils.yesterday();
			beginTime = DateUtils.monthTerday();
		}
		ofo.setBeginTime(beginTime);
		ofo.setEndTime(endTime);
		if (StringUtils.isEmpty(companyName)){
			companyName = null;
		}
			
		ofo.setCompanyName(companyName);
		ofo.setCustomerName(customerName);
		OrderRequest or = new OrderRequest();
		or.setData(ofo);
		String json = JsonTool.beanTojsonString(or);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OP_SERCUSTOMER);
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
}
