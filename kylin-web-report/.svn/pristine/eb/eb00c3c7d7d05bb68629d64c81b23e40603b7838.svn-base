package com.ycgwl.kylin.web.report.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.CarBasicAttacheForOut;
import ycapp.dbinterface.bean.CrmForOut;

/**
 *客户管理的的控制层
 * @author litao
 *
 */
@Controller
@RequestMapping("/crmTest")
public class CrmTestController extends BaseController{
	private static Logger logger = Logger.getLogger(CrmTestController.class);
	static ToolUtil tu = new ToolUtil();
	
    //显示所有所属公司
	@RequestMapping(value = "/findAllCompany.do", method = { RequestMethod.POST })
     public @ResponseBody String findAllCompany(HttpServletRequest request, HttpServletResponse response){
		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);
        
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CRM_ALLCOMPANY);
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
	
	
	//展示公司的客户类型
	@RequestMapping(value="/findAllCustomer.do",method={RequestMethod.POST})
	public String findAllCustomer(HttpServletRequest request, HttpServletResponse response,String belongCompany){
		
		OrderRequest orderRequest = new OrderRequest();
		CrmForOut crmForOut= new CrmForOut();
		
		crmForOut.setBelongCompany(belongCompany);
		orderRequest.setData(crmForOut);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CRM_ALLCUSTOMER);
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
	
	
	
	//行业占比
	
	@RequestMapping(value="/findIndustryShare.do",method={RequestMethod.POST})
	public String findIndustryShare(HttpServletRequest request, HttpServletResponse response,String belongCompany,String coustomerType){
		
		OrderRequest orderRequest = new OrderRequest();
		CrmForOut crmForOut= new CrmForOut();
		
		crmForOut.setBelongCompany(belongCompany);
		crmForOut.setCustomer_type(coustomerType);
		orderRequest.setData(crmForOut);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CRM_INDUSTRYSHARE);
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
	
	
	
	//当前客户的各行业数量
	@RequestMapping(value="/numberOfIndustries.do",method={RequestMethod.POST})
	public String numberOfIndustries(HttpServletRequest request, HttpServletResponse response,String belongCompany,String coustomerType){
		
		OrderRequest orderRequest = new OrderRequest();
		CrmForOut crmForOut= new CrmForOut();
		
		crmForOut.setBelongCompany(belongCompany);
		crmForOut.setCustomer_type(coustomerType);
		orderRequest.setData(crmForOut);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CRM_INDUSTRYVOLUME);
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
	
	//客户的分布位置
	@RequestMapping(value="/customerLocation.do",method={RequestMethod.POST})
	public String customerLocation(HttpServletRequest request, HttpServletResponse response,String belongCompany, String coustomerType){
		
		OrderRequest orderRequest = new OrderRequest();
		CrmForOut crmForOut= new CrmForOut();
		crmForOut.setCustomer_type(coustomerType);
		crmForOut.setBelongCompany(belongCompany);
		orderRequest.setData(crmForOut);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CRM_GEOGRAPHICALPOSITION);
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
	
    
	//展示详情
	@RequestMapping(value = "/crmDetail.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String crmDetail(HttpServletRequest request, HttpServletResponse response,
			String belongCompany,String coustomerType, Integer PageNo, Integer PageSize) {
		CrmForOut crmForOut = new CrmForOut();
		PageModel<CrmForOut> pageModel = new PageModel<CrmForOut>();
		if (PageNo == null) {
			PageNo = 1;
		}

		if (PageSize == null) {
			PageSize = 10;
		}

		crmForOut.setBelongCompany(belongCompany);
		crmForOut.setCustomer_type(coustomerType);
		pageModel.setObj(crmForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CRM_DETAILS);

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

}
