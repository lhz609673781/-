package com.ycgwl.kylin.web.report.controller;

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
import ycapp.dbinterface.bean.AcceptClaimsReportForOut;

/**
 * 
 * 
 * @author 29556 2.2 受理理赔的控制层
 *
 *
 */
@Controller
@RequestMapping("/acceptClaimsReport")
public class AcceptClaimsReportController extends BaseController {
	private static Logger logger = Logger.getLogger(AcceptClaimsReportController.class);
	static ToolUtil tu = new ToolUtil();

	/**
	 * 汇总信息
	 */
	@RequestMapping(value = "/gatherAccept.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String gatherAccept(HttpServletRequest request, HttpServletResponse response, String beginTime,
			String endTime, Integer searchType, Integer coordinate) {
		logger.info("-------------------------汇总信息--------------------------");
		AcceptClaimsReportForOut acceptForOut = new AcceptClaimsReportForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || null == coordinate) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (null == searchType)
			searchType = 0;

		acceptForOut.setBeginTime(beginTime);
		acceptForOut.setEndTime(endTime);
		acceptForOut.setSearchType(searchType);
		acceptForOut.setCoordinate(coordinate);
		OrderRequest or = new OrderRequest();
		or.setData(acceptForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.AC_SERALLACCEPT);// Request
			logger.info("entity------------------------>" + entity);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {// 将状态码转换成int类型

				String resultInfo = httpresult.getString("resultInfo");//
				logger.info("resultInfo------------------------>" + resultInfo);
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

	/***
	 * 根据客户行业分组查询.
	 */
	@RequestMapping(value = "/guestTypeGroupBy.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String guestTypeGroupBy(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, Integer searchType) {

		logger.info("-----------------------根据客户行业分组查询------------------------------------------");
		AcceptClaimsReportForOut acceptForOut = new AcceptClaimsReportForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (null == searchType)
			searchType = 0;
		acceptForOut.setBeginTime(beginTime);
		acceptForOut.setEndTime(endTime);
		acceptForOut.setSearchType(searchType);
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(acceptForOut);
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		String entity;

		try {

			entity = tu.RequestPost(response, json, LHX_URL + Global.AC_SERGUESTTYPE);
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
	 * 详细信息查询(表格下面) int coordinate//页面传过来的坐标
	 */

	@RequestMapping(value = "/searchClaims.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String searchClaims(HttpServletRequest request, HttpServletResponse response, Integer PageNo,
			Integer PageSize, String beginTime, String endTime, Integer searchType, Integer coordinate) {
		logger.info("------------详细信息查询(表格下面)-----------------------");
		AcceptClaimsReportForOut acceptForOut = new AcceptClaimsReportForOut();
		PageModel<AcceptClaimsReportForOut> pageModel = new PageModel<AcceptClaimsReportForOut>();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || null == coordinate) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (null == searchType){
			searchType = 0;
		}
			
		if (PageNo == null){
			PageNo = 1;
		}
			
		if (PageSize == null){
			PageSize = 10;
		}
			
		acceptForOut.setBeginTime(beginTime);
		acceptForOut.setEndTime(endTime);
		acceptForOut.setSearchType(searchType);
		acceptForOut.setCoordinate(coordinate);
		pageModel.setObj(acceptForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.AC_SERDETAILACCEPT);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
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
	 * 导出报表(客户理赔)
	 * 
	 * @param beginTime
	 * @param endTime
	 * @param customerName
	 * @param companyName
	 * @param pageNo
	 * @param pageSize
	 * 
	 */

	@RequestMapping(value = "/searchClaimsCustomer.do", method = RequestMethod.GET)
	public void searchClaimsCustomer(HttpServletRequest request, HttpServletResponse response, Integer PageNo,
			Integer PageSize, String beginTime, String endTime, Integer searchType, Integer coordinate) {
		// 工具类（保留小数后面两位）
		DecimalFormat df = new DecimalFormat("##0.00");
		logger.info("welcome to into findList method!!!!!!");
		AcceptClaimsReportForOut acceptForOut = new AcceptClaimsReportForOut();
		PageModel<AcceptClaimsReportForOut> pageModel = new PageModel<AcceptClaimsReportForOut>();
		// 查询坐标coordinate0：公司坐标 * 1：客户坐标
		if (null == searchType){
			searchType = 0;
		}

		if (PageSize == null){
			PageSize = 1000000000;
		}
		acceptForOut.setBeginTime(beginTime);
		acceptForOut.setEndTime(endTime);
		acceptForOut.setSearchType(searchType);
		acceptForOut.setCoordinate(coordinate);
		pageModel.setObj(acceptForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<AcceptClaimsReportForOut> acceptForList = new ArrayList<AcceptClaimsReportForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.AC_SERDETAILACCEPT);
			logger.info("entity---------------------------->" + entity);
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				acceptForList = JSONArray.parseArray(datav1, AcceptClaimsReportForOut.class);

				if (acceptForList.size() > 0) {
					int i = 0;
					for (AcceptClaimsReportForOut acf : acceptForList) {

						String acFor[] = { i + 1 + "", acf.getCustomerName(), acf.getCompanyName(),
								acf.getGuestType(), df.format(acf.getPayAmount()),
								df.format((acf.getFirstMonthLastSeason() / 10000)) + " / "
										+ df.format((acf.getSecondMonthLastSeason()) / 10000) + " /"
										+ df.format((acf.getThirdMonthLastSeason() / 10000)),
								df.format((acf.getAverageLastSeason() / 10000)),
								df.format(acf.getContemporaneousPayment() * 100) + "%",
								df.format(acf.getRingPayment() * 100) + "%",
								df.format((acf.getCarrierPay() / acf.getPayAmount() * 100)) + "%",
								df.format((acf.getInsurancePay() / acf.getPayAmount() * 100)) + "%",
								df.format((acf.getCompanyPay() / acf.getPayAmount() * 100)) + "%" };
						list.add(acFor);

						i++;

					}

				}
				if (beginTime.length() == 7 && endTime.length() == 7 && coordinate == 1) {
					// 设置excel信息
					String showColumnName[] = { "序号", "客户名称", "公司名称", "客户行业", "当期赔付(元)", "前推第1/2/3月(万元)",
							"前三个月平均赔付值(万元)	", "同期赔付", "环比赔付", "需供应商承担", "需保险公司承担", "自留风险" };// 列名
					String sheetName = "按具体的年月进行查询";
					Integer showColumnWidth[] = { 8, 55, 15, 15, 15, 19, 22, 15, 15, 15, 15, 15 };// 列宽
					String fileName = "客户理赔查询";

					String implParam = null;
					if (searchType == 0)
						implParam = beginTime + "  至  " + endTime + " 按受理时间查询";
					else
						implParam = beginTime + "  至  " + endTime + "     按发货时间查询";
					String total = "客户理赔查询(按具体的年月进行查询)";

					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
					excelForm.setImplParam(implParam);
					excelForm.setList(list);// 导出的内容
					excelForm.setSheetName(sheetName);
					excelForm.setShowColumnName(showColumnName);
					excelForm.setShowColumnWidth(showColumnWidth);
					ExcelReportUtils.exportExcel(excelForm, response);

				} else if (beginTime.length() != 7 && endTime.length() != 7 && coordinate == 1) {

					// 设置excel信息
					String showColumnName[] = { "序号", "客户名称", "公司名称", "客户行业", "当期赔付(元)", "前推第1/2/3月(万元)",
							"前三个月平均赔付值(万元)	", "同期赔付", "环比赔付", "需供应商承担", "需保险公司承担", "自留风险" };// 列名
					String sheetName = "客户理赔查询(按具体的年月日进行查询)";
					Integer showColumnWidth[] = { 8, 55, 15, 15, 15, 19, 22, 15, 15, 15, 15, 15 };// 列宽
					String fileName = "客户理赔查询";

					String implParam = null;
					if (searchType == 0)
						implParam = beginTime + "  至  " + endTime + " 按受理时间查询";
					else
						implParam = beginTime + "  至  " + endTime + "     按发货时间查询";
					String total = "客户理赔查询(按具体的年月日进行查询)";

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

	/**
	 * 导出报表（公司理赔）
	 * 
	 * 
	 */

	@RequestMapping(value = "/searchClaimsCompany.do", method = RequestMethod.GET)
	public void searchByCompany(HttpServletRequest request, HttpServletResponse response, Integer PageNo,
			Integer PageSize, String beginTime, String endTime, Integer searchType, Integer coordinate) {
		// 工具类（保留小数后面两位）
		DecimalFormat df = new DecimalFormat("##0.00");
		logger.info("welcome to into findList method!!!!!!");
		AcceptClaimsReportForOut acceptForOut = new AcceptClaimsReportForOut();
		PageModel<AcceptClaimsReportForOut> pageModel = new PageModel<AcceptClaimsReportForOut>();
		// 查询坐标coordinate0：公司坐标 * 1：客户坐标

		if (null == searchType){
			searchType = 0;
		}
		
		if (PageSize == null){
			PageSize = 1000000000;
		}
		acceptForOut.setBeginTime(beginTime);
		acceptForOut.setEndTime(endTime);
		acceptForOut.setSearchType(searchType);
		acceptForOut.setCoordinate(coordinate);
		pageModel.setObj(acceptForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<AcceptClaimsReportForOut> acceptForList = new ArrayList<AcceptClaimsReportForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.AC_SERDETAILACCEPT);
			logger.info("entity---------------------------->" + entity);
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				acceptForList = JSONArray.parseArray(datav1, AcceptClaimsReportForOut.class);

				if (acceptForList.size() > 0) {
					int i = 0;
					for (AcceptClaimsReportForOut acf : acceptForList) {

						String acFor[] = { i + 1 + "", acf.getCompanyName(), df.format(acf.getPayAmount()),
								df.format((acf.getFirstMonthLastSeason() / 10000)) + " / "
										+ df.format((acf.getSecondMonthLastSeason()) / 10000) + " / "
										+ df.format((acf.getThirdMonthLastSeason() / 10000)),
								df.format((acf.getAverageLastSeason() / 10000)),
								df.format(acf.getContemporaneousPayment() * 100),
								df.format(acf.getRingPayment() * 100) + "%",
								df.format((acf.getCarrierPay() / acf.getPayAmount() * 100)) + "%",
								df.format((acf.getInsurancePay() / acf.getPayAmount() * 100)) + "%",
								df.format((acf.getCompanyPay() / acf.getPayAmount() * 100)) + "%" };
						list.add(acFor);

						i++;

					}

				}
				if (beginTime.length() == 7 && endTime.length() == 7 && coordinate == 0) {
					// 设置excel信息
					String showColumnName[] = { "序号", "远成公司", "当期赔付(元)", "前推第1/2/3月(万元)", "前三个月平均赔付值(万元)	",
							"同期赔付", "环比赔付", "需供应商承担", "需保险公司承担", "自留风险" };// 列名
					String sheetName = "按具体的年月进行查询";
					Integer showColumnWidth[] = { 8, 20, 15, 15, 15, 25, 18, 15, 15, 15 };// 列宽
					String fileName = "公司理赔对比";

					String implParam = null;
					if (searchType == 0)
						implParam = beginTime + "  至  " + endTime + " 按受理时间查询";
					else
						implParam = beginTime + "  至  " + endTime + "     按发货时间查询";
					String total = "公司理赔对比(按具体的年月进行查询)";

					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
					excelForm.setImplParam(implParam);
					excelForm.setList(list);// 导出的内容
					excelForm.setSheetName(sheetName);
					excelForm.setShowColumnName(showColumnName);
					excelForm.setShowColumnWidth(showColumnWidth);
					ExcelReportUtils.exportExcel(excelForm, response);

				} else if (beginTime.length() != 7 && endTime.length() != 7 && coordinate == 0) {

					// 设置excel信息
					String showColumnName[] = {"序号", "远成公司", "当期赔付(元)", "前推第1/2/3月(万元)", "前三个月平均赔付值(万元)	", "同期赔付",
							"环比赔付", "需供应商承担", "需保险公司承担", "自留风险" };// 列名
					String sheetName = "客户理赔查询(按具体的年月日进行查询)";
					Integer showColumnWidth[] = {8, 20, 15, 15, 15, 25, 18, 15, 15, 15 };// 列宽
					String fileName = "公司理赔对比";
					String implParam = null;
					if (searchType == 0)
						implParam = beginTime + "  至  " + endTime + " 按受理时间查询";
					else
						implParam = beginTime + "  至  " + endTime + "     按发货时间查询";
					String total = "公司理赔对比(按具体的年月日进行查询)";

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
