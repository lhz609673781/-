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
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.CarAnnualWarningForOut;




/**
 * 车辆年检预警的控制层
 * @author litao
 *
 */
@Controller
@RequestMapping("/carAnnualWarning")
public class CarAnnualWarningController extends BaseController {
	private static Logger logger = Logger.getLogger(CarAnnualWarningController.class);
	static ToolUtil tu = new ToolUtil();
	
	/**
	 *本月需要处理的预警汇总 
	 */
	@RequestMapping(value = "/carWarnning.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
	"application/json;charset=UTF-8" })
    public @ResponseBody String carWarnning(HttpServletRequest request, HttpServletResponse response,
	String carCompany) {
		
		OrderRequest orderRequest = new OrderRequest();
		CarAnnualWarningForOut carWarningForOut = new CarAnnualWarningForOut();
//		
//		if (StringUtils.isEmpty(carCompany)) {
//			carBasicForOut.setCarCompany(null);
//		} else { 
//			carBasicForOut.setCarCompany(carCompany);
//		}
		
		orderRequest.setData(carWarningForOut);
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARWARNING_MONTH);
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
	 * 预计六个月的费用
	 * 
	 */
	@RequestMapping(value = "/groupByTime.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
	"application/json;charset=UTF-8" })
    public @ResponseBody String groupByTime(HttpServletRequest request, HttpServletResponse response,
	String carCompany) {
		OrderRequest orderRequest = new OrderRequest();
		CarAnnualWarningForOut carWarningForOut = new CarAnnualWarningForOut();
//		
//		if (StringUtils.isEmpty(carCompany)) {
//			carBasicForOut.setCarCompany(null);
//		} else {
//			carBasicForOut.setCarCompany(carCompany);
//		}
		
		orderRequest.setData(carWarningForOut);
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARWARNING_ESTIMATEDCOST);
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
      * 预警的详细信息
      */
	@RequestMapping(value = "/carWarnningDetail.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
	"application/json;charset=UTF-8" })
    public @ResponseBody String carWarnningDetail(HttpServletRequest request, HttpServletResponse response, String carCompany,
	Integer PageNo, Integer PageSize) {
		CarAnnualWarningForOut carWarningForOut = new CarAnnualWarningForOut();
		PageModel<CarAnnualWarningForOut> pageModel = new PageModel<CarAnnualWarningForOut>();
		if (PageNo == null) {
			PageNo = 1;
		}

		if (PageSize == null) {
			PageSize = 10;
		}

		//carWarningForOut.setCarCompany(carCompany);
		
		pageModel.setObj(carWarningForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARWARNING_CARWARNINGDETAIL);

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


