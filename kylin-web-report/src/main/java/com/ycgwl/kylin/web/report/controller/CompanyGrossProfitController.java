package com.ycgwl.kylin.web.report.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.core.ResponseUtil;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.dbinterface.bean.OperationGroupReportSearchForOut;

/**
 * 分公司毛利统计表（财务）控制层
 * <p>
 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月8日
 */
@Controller
@RequestMapping("/companyGrossProfit")
public class CompanyGrossProfitController extends BaseController{

	private static Logger logger = Logger.getLogger(CompanyGrossProfitController.class);
	static ToolUtil tu = new ToolUtil();
	 
	/**
	 * 根据起止时间获取分公司收入占比前十名
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月12日
	 * @param request
	 * @param response
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/companyIncomeProportion.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
		"application/json;charset=UTF-8" })
	public @ResponseBody String companyIncomeProportion(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime) {
		
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
			String entity = tu.RequestPost(response, json, LHX_URL + Global.COMPANY_INCOME_PROPORTION);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason.equals("暂无分公司收入占比排名数据")) {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, reason);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason != "暂无分公司收入占比排名数据") {
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
	 * 各分公司收入、成本、毛利率及收入指标
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月8日
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/companyProportion.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
		"application/json;charset=UTF-8" })
	public @ResponseBody String companyProportion(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime) {

		OperationGroupReportSearchForOut search = new OperationGroupReportSearchForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}		
		
		//DateUtils.getLastYear(beginTime);
		
		search.setBeginTime(beginTime);
		search.setEndTime(endTime);
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(search);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.COMPANY_PROPORTION);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason.equals("暂无各分公司财务情况数据")) {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, reason);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason != "暂无各分公司财务情况数据") {
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
	 * 根据起止时间获取分公司平均成本、平均收入、平均毛利、总毛利
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月12日
	 * @param request
	 * @param response
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/companyProportionAveraging.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
		"application/json;charset=UTF-8" })
	public @ResponseBody String companyProportionAveraging(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime) {
		
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
			String entity = tu.RequestPost(response, json, LHX_URL + Global.COMPANY_PROPORTION_AVERAGING);
			
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
} 
