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

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.FinancialPaymentBillForOut;
import ycapp.dbinterface.bean.OperationCarrierIncomeForOut;

/**
 * 财务报表查询控制层
 * 
 * @author yeyunsong 2017-05-15
 *
 */
@Controller
@RequestMapping("/financial")
public class FinancialController extends BaseController {
	private static Logger logger = Logger.getLogger(FinancialController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	DecimalFormat df = new DecimalFormat("0.00");

	/***
	 * 财务付款单查询（ajax请求）
	 */
	@RequestMapping(value = "/searchFinancial.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchFinancial(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, int pageSize, int pageNo) {
		System.out.println("进入财务付款单查询Controller,aJax");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		FinancialPaymentBillForOut searchFp = new FinancialPaymentBillForOut();
		searchFp.setBeginTime(beginTime);// 开始时间
		searchFp.setEndTime(endTime);// 结束时间
		PageModel<FinancialPaymentBillForOut> page = new PageModel<FinancialPaymentBillForOut>();
		page.setObj(searchFp);
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		or.setData(page);
		or.setRole(Global.STATUS1 + "");
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.SEARFINACIAL_URL);
			System.out.println("entity-------------------------->" + entity);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
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
	 * 财务付款单查询（菜单请求）
	 */
	@RequestMapping(value = "/findFinancial.do", method = RequestMethod.GET)
	public ModelAndView ndFinancial(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("进入财务付款单查询Controller,菜单查询");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		FinancialPaymentBillForOut searchFp = new FinancialPaymentBillForOut();
		searchFp.setBeginTime(DateUtils.yesterday());
		searchFp.setEndTime(DateUtils.yesterday());
		PageModel<FinancialPaymentBillForOut> page = new PageModel<FinancialPaymentBillForOut>();
		page.setObj(searchFp);
		page.setPageNo(1);
		page.setPageSize(20);
		or.setData(page);
		or.setRole(Global.STATUS1 + "");
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.SEARFINACIAL_URL);
			System.out.println("entity-------------------------->" + entity);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				page = JSONObject.parseObject(resultInfo, PageModel.class);
				map.put("page", page);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("sheet/payment").addAllObjects(map);
	}

	/***
	 * 财务付款单查询（excel导出）
	 */
	@RequestMapping(value = "/exportFinancial.do", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> exportFinancial(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, int pageSize, int pageNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		FinancialPaymentBillForOut searchFp = new FinancialPaymentBillForOut();
		searchFp.setBeginTime(beginTime);// 开始时间
		searchFp.setEndTime(endTime);// 结束时间
		PageModel<FinancialPaymentBillForOut> page = new PageModel<FinancialPaymentBillForOut>();
		page.setObj(searchFp);
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		or.setData(page);
		or.setRole(Global.STATUS0 + "");
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		List<FinancialPaymentBillForOut> pfList = new ArrayList<FinancialPaymentBillForOut>();
		List<String[]> list = new ArrayList<String[]>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.SEARFINACIAL_URL);
			System.out.println("entity-------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				page = JSONObject.parseObject(resultInfo, PageModel.class);
				JSONObject resultJson = (JSONObject) JSONObject.parse(resultInfo);
				String listJson = resultJson.getString("list");
				pfList = JSONArray.parseArray(listJson, FinancialPaymentBillForOut.class);
				if (pfList.size() > 0) {
					int u = 0;
					for (FinancialPaymentBillForOut fp : pfList) {
						String array[] = { fp.getGroupName(), fp.getDescription(),
								"" + df.format(fp.getActualPayMoney()), fp.getSubmitTime() };
						list.add(array);
						u++;
					}
				}
				// 设置excel信息
				String showColumnName[] = { "录入公司", "摘要", "实付金额（元）", "时间" };// 列名
				String sheetName = "付款单查询";
				Integer showColumnWidth[] = { 20, 80, 20, 45 };// 列宽
				String fileName = "付款单查询";

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
		return map;
	}

	/***
	 * 载体营业收入查询（ajax请求）
	 */
	@RequestMapping(value = "/searchCarrierIncome.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchCarrierIncome(HttpServletRequest request,
			HttpServletResponse response, String beginTime, String endTime, String companyName) {
		System.out.println("进入载体营业收入查询Controller,aJax");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		OperationCarrierIncomeForOut searchOci = new OperationCarrierIncomeForOut();
		searchOci.setBeginTime(beginTime);// 开始时间
		searchOci.setEndTime(endTime);// 结束时间
		if (StringUtils.isEmpty(companyName)) {
			searchOci.setCompanyName(null);// 全部分公司
		} else {
			searchOci.setCompanyName(companyName);
		}
		or.setData(searchOci);
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		List<OperationCarrierIncomeForOut> lsOci = new ArrayList<OperationCarrierIncomeForOut>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_CARRIER_TI_SERV);
			System.out.println("entity-------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				lsOci = JSONArray.parseArray(resultInfo, OperationCarrierIncomeForOut.class);
				map.put("lsOci", lsOci);
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/***
	 * 载体营业收入查询（菜单请求）
	 */
	@RequestMapping(value = "/findCarrierIncome.do", method = RequestMethod.GET)
	public ModelAndView findCarrierIncome(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("进入载体营业收入查询Controller,菜单查询");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		Calendar c = Calendar.getInstance();
		OperationCarrierIncomeForOut searchOci = new OperationCarrierIncomeForOut();
		int day = c.get(Calendar.DATE);
		if (day != 1) {
			searchOci.setBeginTime(DateUtils.firstDateOfCurrMonth());
			searchOci.setEndTime(DateUtils.yesterday());
		} else {
			searchOci.setBeginTime(DateUtils.firstDateOfTerdayMonth());
			searchOci.setEndTime(DateUtils.yesterday());
		}
		searchOci.setCompanyName(null);// 全部分公司
		or.setData(searchOci);
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		List<OperationCarrierIncomeForOut> lsOci = new ArrayList<OperationCarrierIncomeForOut>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_CARRIER_TI_SERV);
			System.out.println("entity-------------------------->" + entity);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				lsOci = JSONArray.parseArray(resultInfo, OperationCarrierIncomeForOut.class);
				map.put("lsOci", lsOci);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("sheet/carrierRevenue").addAllObjects(map);
	}

	/***
	 * 载体营业收入查询（excel导出）
	 */
	@RequestMapping(value = "/exportCarrierIncome.do", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> exportCarrierIncome(HttpServletRequest request,
			HttpServletResponse response, String beginTime, String endTime, String companyName) {
		try {
			companyName = (URLDecoder.decode(companyName, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		OperationCarrierIncomeForOut searchOci = new OperationCarrierIncomeForOut();
		searchOci.setBeginTime(beginTime);// 开始时间
		searchOci.setEndTime(endTime);// 结束时间
		if (StringUtils.isEmpty(companyName)) {
			searchOci.setCompanyName(null);// 全部分公司
		} else {
			searchOci.setCompanyName(companyName);
		}
		or.setData(searchOci);
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		List<OperationCarrierIncomeForOut> lsOci = new ArrayList<OperationCarrierIncomeForOut>();
		List<String[]> list = new ArrayList<String[]>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_CARRIER_TI_SERV);
			System.out.println("entity-------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				lsOci = JSONArray.parseArray(resultInfo, OperationCarrierIncomeForOut.class);
				if (lsOci.size() > 0) {
					int u = 0;
					for (OperationCarrierIncomeForOut oci : lsOci) {
						String array[] = { oci.getCompanyName(), df.format(oci.getXingbaoIncome()) + "",
								"" + df.format(oci.getXingyouIncome()), df.format(oci.getWudingIncome()) + "",
								df.format(oci.getXinganxianIncome()) + "",
								df.format(oci.getJizhuangxiangIncome()) + "",
								"" + df.format(oci.getTotalIncome()) };
						list.add(array);
						u++;
					}
				}
				// 设置excel信息
				String showColumnName[] = { "分公司", "行包收入", "行邮收入", "五定收入", "新干线收入", "集装箱收入", "综合收入" };// 列名
				String sheetName = "载体营业收入查询";
				Integer showColumnWidth[] = { 20, 20, 20, 20, 20, 20, 20 };// 列宽
				String fileName = "载体营业收入查询";

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
		return map;
	}
}
