package com.ycgwl.kylin.web.report.controller;

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
import ycapp.dbinterface.bean.OperationGroupReportSearchForOut;
import ycapp.dbinterface.bean.OperationReturnForOut;

/**
 * 集团运营报表控制层
 * <p>
 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年8月23日
 */
@Controller
@RequestMapping("/operationGroupReport")
public class OperationGroupReportController extends BaseController {

	private static Logger logger = Logger.getLogger(OperationGroupReportController.class);
	static ToolUtil tu = new ToolUtil();

	/**
	 * 集团运营列表
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年8月30日
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/operationGroupReportPage.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String operationGroupListPage(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
	Integer pageSize, String beginTime, String endTime) {
//		beginTime = "2017-05-25";
//		endTime = "2017-08-25";
		PageModel<OperationGroupReportSearchForOut> pageSearchModel = new PageModel<OperationGroupReportSearchForOut>();
		OperationGroupReportSearchForOut search = new OperationGroupReportSearchForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (pageNo == null){	
			pageNo = 1;
		}
		if (pageSize == null){
			pageSize = 10;
		}
		
		search.setBeginTime(beginTime);
		search.setEndTime(endTime);
		pageSearchModel.setObj(search);
		pageSearchModel.setPageNo(pageNo);
		pageSearchModel.setPageSize(pageSize);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageSearchModel);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_GROUP_LIST);
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason.equals("暂无集团运营情况数据")) {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, reason);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason != "暂无集团运营情况数据") {
				return ResponseUtil.toJsonObject(Global.PARAM_CODE, reason);
			}else{
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseUtil.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR);
		}
	}
	
	/**
	 * 当日运营情况统计
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年8月30日
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/operationGroupTotal.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String operationGroupTotal(HttpServletRequest request, HttpServletResponse response) {
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(null);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_GROUP_TOTAL);
			
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
	 * 分公司运输重量排名前十
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年8月30日
	 * @param request
	 * @param response
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/operationGroupRanking.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String operationGroupRanking(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime) {
//		beginTime = "2015-08-22";
//		endTime = "2017-08-24";
		OperationGroupReportSearchForOut search = new OperationGroupReportSearchForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}		
		
		search.setBeginTime(beginTime);
		search.setEndTime(endTime);
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(search);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_GROUP_RANKING);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason.equals("暂分公司运输重量排名数据")) {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, reason);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason != "暂分公司运输重量排名数据") {
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
	 * 指标维度汇总
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年8月30日
	 * @param request
	 * @param response
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/operationGroupIndicatorsDimension.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String operationGroupIndicatorsDimension(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime) {
//		beginTime = "2017-01-01";
//		endTime = "2017-08-24";
		OperationGroupReportSearchForOut search = new OperationGroupReportSearchForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}		
		
		search.setBeginTime(beginTime);
		search.setEndTime(endTime);
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(search);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_GROUP_INDICATORS);
			
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
	 * 导出报表（集团运营）
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年8月30日
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 */
	@RequestMapping(value = "/exportOperationGroupList.do", method = RequestMethod.GET)
	public void exportOperationGroupList(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime) {
//		beginTime = "2017-08-01";
//		endTime = "2017-08-25";
		PageModel<OperationGroupReportSearchForOut> pageSearchModel = new PageModel<OperationGroupReportSearchForOut>();
		OperationGroupReportSearchForOut search = new OperationGroupReportSearchForOut();
		
		if (pageNo == null){	
			pageNo = 1;
		}
		if (pageSize == null){
			pageSize = 2000000000;
		}
		
		search.setBeginTime(beginTime);
		search.setEndTime(endTime);
		pageSearchModel.setObj(search);
		pageSearchModel.setPageNo(pageNo);
		pageSearchModel.setPageSize(pageSize);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageSearchModel);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		List<OperationReturnForOut> operationReturnForOutList = new ArrayList<OperationReturnForOut>();

		List<String[]> list = new ArrayList<String[]>();

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_GROUP_LIST);
			logger.info("entity---------------------------->" + entity);
			JSONObject httpResult = JSONObject.parseObject(entity);
			String resultCode = httpResult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				
				String resultInfo = httpResult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);
				JSONObject jsonObj = JSONObject.parseObject(resultInfo);
				String data = jsonObj.getString("list");
				operationReturnForOutList = JSONArray.parseArray(data, OperationReturnForOut.class);
				if (operationReturnForOutList.size() > 0) {
					int i = 0;
					for (OperationReturnForOut operationReturnForOut : operationReturnForOutList) {

						String operationReturnForOutArray[] = { i + 1 + "", operationReturnForOut.getProjectName(),
								operationReturnForOut.getCompanyName(),operationReturnForOut.getVotes().toString(),
								operationReturnForOut.getWeight().toString(),operationReturnForOut.getVolume().toString(),
								operationReturnForOut.getProjectRote(),operationReturnForOut.getPromptRote(),
								operationReturnForOut.getArriclaRote(),operationReturnForOut.getReturnRote(),operationReturnForOut.getLoadRote()};
						list.add(operationReturnForOutArray);
						i++;
					}
				}
				
				// 设置excel信息
				String showColumnName[] = {"序号", "客户名称", "公司名称", "票数", "重量(吨)", "体积(立方)",
						"项目毛利率", "提货及时率", "到货及时率", "返单合格及时率","信息录入准确率" };// 列名
				String sheetName = "集团运营查询";
				Integer showColumnWidth[] = {8, 30, 15, 15, 15, 15, 15, 15, 15, 15, 15 };// 列宽
				String fileName = "集团运营";
				String implParam = beginTime + "  至  " + endTime + "     按发货时间查询";
				String total = "集团运营";

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
	
	@RequestMapping(value = "/loadProjectNameByDeliveryTime.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {"application/json;charset=UTF-8" })
	public @ResponseBody String loadProjectNameByDeliveryTime(HttpServletRequest request, HttpServletResponse response,String projectName,
			String beginTime, String endTime) {
//		beginTime = "2017-08-01";
//		endTime = "2017-08-24";
//		projectName = "上海";
		
		projectName = projectName.replaceAll("'", "");
			
		OperationGroupReportSearchForOut search = new OperationGroupReportSearchForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || StringUtils.isEmpty(projectName)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}		
		
		search.setBeginTime(beginTime);
		search.setEndTime(endTime);
		search.setProjectName(projectName);
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(search);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_GROUP_PROJECTNAME);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason.equals("暂无项目名称数据")) {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, reason);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason != "暂无项目名称数据") {
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
