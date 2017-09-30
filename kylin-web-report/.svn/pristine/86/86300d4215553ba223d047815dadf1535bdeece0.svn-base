package com.ycgwl.kylin.web.report.controller;

import java.io.UnsupportedEncodingException;
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
import ycapp.dbinterface.bean.CarBasicAttacheForOut;
import ycapp.dbinterface.bean.CarBasicFormForOut;

/**
 * 车辆基本信息的控制层
 * 
 * @author 29556
 *
 */
@Controller
@RequestMapping("/CarBasicInfo")
public class CarBasicInfoController extends BaseController {
	private static Logger logger = Logger.getLogger(CarBasicInfoController.class);
	static ToolUtil tu = new ToolUtil();

	/**
	 * 查询下拉框所有的公司
	 * 
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

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARBASIC_FINDALL);
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
	 * 挂靠车辆的下来公司框
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/findAttacheCarCompany.do", method = { RequestMethod.POST })
	public @ResponseBody String findAttacheCarCompany(HttpServletRequest request, HttpServletResponse response) {

		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);

		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARATTACHE_FINDALL);
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
	 * 统计自有车辆的数量
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/showOwnCarCount.do", method = { RequestMethod.POST })
	public @ResponseBody String showOwnCarCount(HttpServletRequest request, HttpServletResponse response) {

		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);

		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.OWNCARTOTAL);
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
	 * 统计挂靠车辆的数量
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/showAttacheCarCount.do", method = { RequestMethod.POST })
	public @ResponseBody String showAttacheCarCount(HttpServletRequest request, HttpServletResponse response) {

		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);

		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.ATTACHECARTOTAL);
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
	 * 根据条件展示公司下自有和挂靠的车辆(饼图)
	 * 传入公司名称
	 * @param request
	 * @param response
	 * @param carCompany
	 * @return
	 */
	@RequestMapping(value = "/totalCarType.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String totalCarType(HttpServletRequest request, HttpServletResponse response,
			String carCompany) {

		OrderRequest orderRequest = new OrderRequest();
		CarBasicFormForOut carBasicForOut = new CarBasicFormForOut();
	
		carBasicForOut.setCarCompany(carCompany);
		orderRequest.setData(carBasicForOut);
		
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARBASIC_TOTALCARTYPE);
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
	 * 根据公司的名称分组，并进行统计车辆的数量(柱状图和自有和挂靠)
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/carGroupByComCount.do", method = { RequestMethod.POST }, produces = { "application/json;charset=UTF-8" })
	public @ResponseBody String carGroupByComCount(HttpServletRequest request, HttpServletResponse response) {

		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);

		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARBASIC_GROUPBYCOMPANY);
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
	 * 显示挂靠车辆的统计柱状图
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/GroupByAttacheCarCount.do", method = { RequestMethod.POST }, produces = { "application/json;charset=UTF-8" })
	public @ResponseBody String GroupByAttacheCarCount(HttpServletRequest request, HttpServletResponse response) {

		OrderRequest or = new OrderRequest();
		or.setData(null);
		String json = JsonTool.beanTojsonString(or);

		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.ATTACHECOUNTCAR);
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
	 * 自有车型 统计数量（有参数）
	 * @param request
	 * @param response
	 * @param carCompany
	 * @return
	 */
	@RequestMapping(value = "/ownCarModel.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String ownCarModel(HttpServletRequest request, HttpServletResponse response,
			String carCompany) {

		OrderRequest orderRequest = new OrderRequest();
		CarBasicFormForOut carBasicForOut = new CarBasicFormForOut();

		if (StringUtils.isEmpty(carCompany)) {
			carBasicForOut.setCarCompany(null);
		} else {
			carBasicForOut.setCarCompany(carCompany);
		}
		orderRequest.setData(carBasicForOut);
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.OWNCARMODEL);
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
	 * 挂靠车型统计数量（有参数）
	 * @param request
	 * @param response
	 * @param carCompany
	 * @return
	 */
	@RequestMapping(value = "/attacheCarModel.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String attacheCarModel(HttpServletRequest request, HttpServletResponse response,
			String carCompany) {

		OrderRequest orderRequest = new OrderRequest();
		CarBasicAttacheForOut attacheCarForOut = new CarBasicAttacheForOut();

		if (StringUtils.isEmpty(carCompany)) {
			attacheCarForOut.setCarCompany(null);
		} else {
			attacheCarForOut.setCarCompany(carCompany);
		}
		orderRequest.setData(attacheCarForOut);
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.ATTACHECARMODEL);
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
	 * 车辆品牌占比自有（有参数）
	 * @param request
	 * @param response
	 * @param carCompany
	 * @return
	 */
	@RequestMapping(value = "/carBrandShare.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carBrandShare(HttpServletRequest request, HttpServletResponse response,
			String carCompany) {

		OrderRequest orderRequest = new OrderRequest();
		CarBasicFormForOut carBasicForOut = new CarBasicFormForOut();

		if (StringUtils.isEmpty(carCompany)) {
			carBasicForOut.setCarCompany(null);
		} else {
			carBasicForOut.setCarCompany(carCompany);
		}
		orderRequest.setData(carBasicForOut);
		String json = JsonTool.beanTojsonString(orderRequest);// 将实体转换成json字符串
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.OWNCARBRANDSHARE);
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
	 * 挂靠车辆的详细信息
	 * @param request
	 * @param response
	 * @param carCompany
	 * @param carType
	 * @param PageNo
	 * @param PageSize
	 * @return
	 */
	@RequestMapping(value = "/attacheCardetail.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String attacheCardetail(HttpServletRequest request, HttpServletResponse response, String carCompany,
			Integer PageNo, Integer PageSize) {
		CarBasicAttacheForOut attacheCarForOut = new CarBasicAttacheForOut();
		PageModel<CarBasicAttacheForOut> pageModel = new PageModel<CarBasicAttacheForOut>();
		if (PageNo == null) {
			PageNo = 1;
		}

		if (PageSize == null) {
			PageSize = 10;
		}

		attacheCarForOut.setCarCompany(carCompany);
		
		pageModel.setObj(attacheCarForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.ATTACHEDETAILINFO);

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
	 * 车辆的基本信息的明细（自有）
	 * 
	 * @param request
	 * @param response
	 * @param carCompany
	 * @param carType
	 * @param PageNo
	 * @param PageSize
	 * @return
	 */
	@RequestMapping(value = "/Cardetail.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String Cardetail(HttpServletRequest request, HttpServletResponse response, String carCompany,
			String carType, Integer PageNo, Integer PageSize) {
		CarBasicFormForOut carBasicForOut = new CarBasicFormForOut();
		PageModel<CarBasicFormForOut> pageModel = new PageModel<CarBasicFormForOut>();
		if (PageNo == null){
			PageNo = 1;
		}
			
		if (PageSize == null){
			PageSize = 10;
		}
		
		carBasicForOut.setCarCompany(carCompany);
		carBasicForOut.setCarType(carType);
		pageModel.setObj(carBasicForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARBASIC_CARDETAIL);
		
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
	 * 车辆的基本信息的明细（自有）的数据导出
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月1日
	 * @param request
	 * @param response
	 * @param PageNo
	 * @param PageSize
	 * @param carCompany
	 * @param carType
	 */
	@RequestMapping(value = "/CardetailExcelImpl.do", method = RequestMethod.GET)
	public void CardetailExcelImpl(HttpServletRequest request, HttpServletResponse response, Integer PageNo,
			Integer PageSize, String carCompany,String carType) {
		try {
			carCompany=java.net.URLDecoder.decode(carCompany,"utf-8");
			carType=java.net.URLDecoder.decode(carType,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		logger.info("welcome to into CardetailExcelImpl method!!!!!!");
		CarBasicFormForOut carBasicForOut = new CarBasicFormForOut();
		PageModel<CarBasicFormForOut> pageModel = new PageModel<CarBasicFormForOut>();
		
		if (PageNo == null){
			PageNo = 1;
		}
		
		if (PageSize == null){
			PageSize = 100000000;
		}
				
		pageModel.setObj(carBasicForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<CarBasicFormForOut> acceptForList = new ArrayList<CarBasicFormForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.CARBASIC_CARDETAIL);
   			logger.info("entity---------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
			   
				String datav1 = jsonobjv1.getString("list");

				acceptForList = JSONArray.parseArray(datav1, CarBasicFormForOut.class);

				if (acceptForList.size() > 0) {
					int i = 0;
					for (CarBasicFormForOut cbf : acceptForList) {

						String cbFor[] = { i + 1 + "" ,cbf.getCarNumber(),cbf.getCarBrand(),cbf.getCarModel(),
						cbf.getEngineHpower(),cbf.getBoardDateStr(),cbf.getCarCompany(),cbf.getCarUse(),cbf.getCarLoad(),
						cbf.getLoadVolume(),cbf.getUseOil(),cbf.getDriverName(),
						cbf.getPhoneNumber(),cbf.getAlterContact(),cbf.getAlterPhone()};
						
						list.add(cbFor);

						i++;
						
					}

				}
				
				
				if (carCompany == null && carType == null ) {
				
					// 设置excel信息
					String showColumnName[] = { "序列", "车牌号", "车辆品牌", "车型", "发动机功率 单位/KM", "发动机马力",
							"上牌日期", "隶属公司", "车辆用途", "核载吨位", "装载体积", "使用油品" ,"司机姓名","手机","备用联系人","备用联系人手机"};// 列名
					String sheetName = "按具体的年月进行查询";
					Integer showColumnWidth[] = { 8, 55, 15, 15, 15, 19, 22, 15, 15, 15, 15, 15,15,15,15,15 };// 列宽
					String fileName = "快运公司下的所有子公司的的车辆明细";

					String total="快运公司下的所有子公司的的车辆明细";

					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
					excelForm.setList(list);// 导出的内容
					excelForm.setSheetName(sheetName);
					excelForm.setShowColumnName(showColumnName);
					excelForm.setShowColumnWidth(showColumnWidth);
					ExcelReportUtils.exportExcel(excelForm, response);
				}else if(carCompany != null && carType !=  null){
					
					// 设置excel信息
					String showColumnName[] = { "序列", "车牌号", "车辆品牌", "车型", "发动机功率 单位/KM", "发动机马力",
							"上牌日期", "隶属公司", "车辆用途", "核载吨位", "装载体积", "使用油品" ,"司机姓名","手机","备用联系人","备用联系人手机"};// 列名
					String sheetName = "按具体的年月进行查询";
					Integer showColumnWidth[] = { 8, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,15,15,15,15 };// 列宽
					String fileName =carCompany+"公司的"+carType+"类型" ;

					String total=carCompany+"公司的"+carType+"类型";
					
					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
					excelForm.setList(list);// 导出的内容
					excelForm.setSheetName(sheetName);
					excelForm.setShowColumnName(showColumnName);
					excelForm.setShowColumnWidth(showColumnWidth);
					ExcelReportUtils.exportExcel(excelForm, response);
	
				}else if(carCompany != null && carType ==  null){
					
					// 设置excel信息
					String showColumnName[] = { "序列", "车牌号", "车辆品牌", "车型", "发动机功率 单位/KM", "发动机马力",
							"上牌日期", "隶属公司", "车辆用途", "核载吨位", "装载体积", "使用油品" ,"司机姓名","手机","备用联系人","备用联系人手机"};// 列名
					String sheetName = "按具体的年月进行查询";
					Integer showColumnWidth[] = { 8, 55, 15, 15, 15, 19, 22, 15, 15, 15, 15, 15,15,15,15,15 };// 列宽
					String fileName =carCompany+"公司的所有类型的车辆";

					String total=carCompany+"公司的所有类型的车辆";
					
					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
					excelForm.setList(list);// 导出的内容
					excelForm.setSheetName(sheetName);
					excelForm.setShowColumnName(showColumnName);
					excelForm.setShowColumnWidth(showColumnWidth);
					ExcelReportUtils.exportExcel(excelForm, response);
					
				}else if(carCompany == null && carType !=  null){
					
					// 设置excel信息
					String showColumnName[] = { "序列", "车牌号", "车辆品牌", "车型", "发动机功率 单位/KM", "发动机马力",
							"上牌日期", "隶属公司", "车辆用途", "核载吨位", "装载体积", "使用油品" ,"司机姓名","手机","备用联系人","备用联系人手机"};// 列名
					String sheetName = "按具体的年月进行查询";
					Integer showColumnWidth[] = { 8, 55, 15, 15, 15, 19, 22, 15, 15, 15, 15, 15,15,15,15,15 };// 列宽
					String fileName ="快运公司下"+carType+"车辆详情";

					String total="快运公司下"+carType+"车辆详情";
					
					ExcelForm excelForm = new ExcelForm();
					excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
					excelForm.setTotal(total);
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
	 * 车辆的基本信息的明细（点击进行排序）
	 * <p>
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at 2017年9月1日
	 * @param request
	 * @param response
	 * @param carCompany
	 * @param orderBy
	 * @param orderByDate
	 * @param carType
	 * @param PageNo
	 * @param PageSize
	 * @return
	 */
	@RequestMapping(value = "/CardetailOr.do", method = { RequestMethod.POST}, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String CardetailOrder(HttpServletRequest request, HttpServletResponse response,
			String carCompany, String orderBy,String orderByDate, String carType, Integer PageNo, Integer PageSize) {
		CarBasicFormForOut carBasicForOut = new CarBasicFormForOut();
		PageModel<CarBasicFormForOut> pageModel = new PageModel<CarBasicFormForOut>();
		if (PageNo == null){
			PageNo = 1;
		}
			
		if (PageSize == null){
			PageSize = 10;
		}
		
		carBasicForOut.setOrderByDate(orderByDate);
		carBasicForOut.setOrderBy(orderBy);
		carBasicForOut.setCarCompany(carCompany);
		carBasicForOut.setCarType(carType); 
		pageModel.setObj(carBasicForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CARBASIC_CARDETAILOB);
		
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
	 * 挂靠车辆的详细情况Excel导出
	 * @param request
	 * @param response
	 * @param carCompany
	 * @param PageNo
	 * @param PageSize
	 * @return
	 */
	
	@RequestMapping(value = "/attacheCardetailExcelImpl.do", method = { RequestMethod.POST, RequestMethod.GET }, produces = {
			"application/json;charset=UTF-8" })
	public void attacheCardetailExcelImpl(HttpServletRequest request, HttpServletResponse response,
			String carCompany, Integer PageNo, Integer PageSize) {
		CarBasicAttacheForOut attacheCarForOut = new CarBasicAttacheForOut();
		PageModel<CarBasicAttacheForOut> pageModel = new PageModel<CarBasicAttacheForOut>();
		
		try {
			carCompany=java.net.URLDecoder.decode(carCompany,"utf-8");
		} catch (UnsupportedEncodingException e1) {
		
			e1.printStackTrace();
		}
		
		
		if (PageNo == null) {
			PageNo = 1;
		}

		if (PageSize == null) {
			PageSize = 10;
		}

		attacheCarForOut.setCarCompany(carCompany);

		pageModel.setObj(attacheCarForOut);
		pageModel.setPageNo(PageNo);
		pageModel.setPageSize(PageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		List<CarBasicAttacheForOut> acceptForList = new ArrayList<CarBasicAttacheForOut>();
		List<String[]> list = new ArrayList<String[]>();
		
		try{
			String entity = tu.RequestPost(response, json, LHX_URL + Global.ATTACHEDETAILINFO);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码

			String reason = httpresult.getString("reason");// 返回信息

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				   
				String datav1 = jsonobjv1.getString("list");

				acceptForList = JSONArray.parseArray(datav1, CarBasicAttacheForOut.class);

				if(acceptForList.size()>0){
				
					int i=0;
					for (CarBasicAttacheForOut carAttacheFO : acceptForList) {
						
					String carAFO []={i+1+"", carAttacheFO.getCarNumber(),carAttacheFO.getCarModel(),carAttacheFO.getBoardDate()
					,carAttacheFO.getCarType(),carAttacheFO.getCarCompany(),carAttacheFO.getAttacheDate(),carAttacheFO.getReportNumber()
					,carAttacheFO.getCarUse(),carAttacheFO.getStandMass()};	
						
						
					list.add(carAFO);
					i++;
						
					}
					if(carCompany==null){
						// 设置excel信息
						String showColumnName[] = { "序列", "车牌号", "车型", "上牌日期", "车辆类型",
							 "隶属公司", "挂靠时间", "审批报告号", "车辆用途", "核载吨位"};// 列名
						String sheetName = "所有挂靠车辆的信息";
						Integer showColumnWidth[] = { 8, 15, 15, 15,15,15,15,15,15,15 };// 列宽
						String fileName = "所有挂靠车辆的信息";

						String total="所有挂靠车辆的信息";

						ExcelForm excelForm = new ExcelForm();
						excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
						excelForm.setTotal(total);
						excelForm.setList(list);// 导出的内容
						excelForm.setSheetName(sheetName);
						excelForm.setShowColumnName(showColumnName);
						excelForm.setShowColumnWidth(showColumnWidth);
						ExcelReportUtils.exportExcel(excelForm, response);	
					}else {
						
						// 设置excel信息
						String showColumnName[] = { "序列", "车牌号", "车型", "上牌日期", "车辆类型",
							 "隶属公司", "挂靠时间", "审批报告号", "车辆用途", "核载吨位"};// 列名
						String sheetName = carCompany+"公司的挂靠车辆的详细情况";
						Integer showColumnWidth[] = { 8, 15, 15, 15,15,15,15,15,15,15 };// 列宽
						String fileName = carCompany+"公司的挂靠车辆的详细情况";

						String total=carCompany+"公司的挂靠车辆的详细情况";

						ExcelForm excelForm = new ExcelForm();
						excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
						excelForm.setTotal(total);
						excelForm.setList(list);// 导出的内容
						excelForm.setSheetName(sheetName);
						excelForm.setShowColumnName(showColumnName);
						excelForm.setShowColumnWidth(showColumnWidth);
						ExcelReportUtils.exportExcel(excelForm, response);	
						
											
					}
								

			} 
				
			}
		
	
	
	} catch (Exception e) {

		e.printStackTrace();
	
	}}
}
