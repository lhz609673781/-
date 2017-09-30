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
import ycapp.dbinterface.bean.CarUseDetailSummaryForOut;
import ycapp.dbinterface.bean.CarUseRecordForOut;
import ycapp.dbinterface.bean.CarUseSummaryForOut;

/**
 * 
 * @Description: 车辆罚款API
 * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
 * @date 2017年8月22日 下午3:45:20
 * @version 2.0
 *
 */
@Controller
@RequestMapping("/carUse")
public class CarUseController extends BaseController {
	private static Logger logger = Logger.getLogger(CarUseController.class);
	static ToolUtil tu = new ToolUtil();

	/**
	 * 汇总信息 主页面
	 */
	@RequestMapping(value = "/carSummaryInfo.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carSummaryInfo(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String carCompany) {
		logger.info("-------------------------汇总信息--------------------------");
		CarUseSummaryForOut summaryForOut = new CarUseSummaryForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || StringUtils.isEmpty(carCompany)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}

		summaryForOut.setCarCompany(carCompany);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);

		OrderRequest or = new OrderRequest();
		or.setData(summaryForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_USE_SUMMARY);// Request
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

	/**
	 * 
	 * @Description: 车辆利用率记录分页
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @return
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:34:24
	 * @version 需求对应版本号
	 */
	@RequestMapping(value = "/carRecord.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carRecord(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime, String carCompany) {
		logger.info("------------车辆罚款记录分页-----------------------");
		CarUseSummaryForOut summaryForOut = new CarUseSummaryForOut();
		PageModel<CarUseRecordForOut> pageModel = new PageModel<CarUseRecordForOut>();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (pageNo == null) {
			pageNo = 1;
		}

		if (pageSize == null) {
			pageSize = 10;
		}

		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);
		summaryForOut.setCarCompany(carCompany);

		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_USE_RECORD);

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
	 * 
	 * @Description: 车辆利用率列表下载报表
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:33:13
	 * @version 2.0
	 */
	@RequestMapping(value = "/carRecordDownload.do", method = RequestMethod.GET)
	public void carRecordDownload(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime, String carCompany) {

		CarUseSummaryForOut summaryForOut = new CarUseSummaryForOut();
		PageModel<CarUseRecordForOut> pageModel = new PageModel<CarUseRecordForOut>();

		summaryForOut.setDownload(true);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);
		summaryForOut.setCarCompany(carCompany);
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<CarUseRecordForOut> recordForOutList = new ArrayList<CarUseRecordForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_USE_RECORD);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				recordForOutList = JSONArray.parseArray(datav1, CarUseRecordForOut.class);

				if (recordForOutList.size() > 0) {
					int i = 0;
					for (CarUseRecordForOut acf : recordForOutList) {
						// TODO 暂时用交罚款来计算扣分消除和未消除
						String acFor[] = { i + 1 + "", 
								 };
						list.add(acFor);
						i++;
					}
				}

				// 设置excel信息
				String showColumnName[] = { "序列", "车牌号", "车型", "核载吨位", "装载体积", "司机姓名",
						"出车里程数","运载次数","重量","折算重量","体积","运算价格","提成金额","装卸费用","路桥费用"};// 列名
				String sheetName = "车辆罚款成本控制(罚款记录)";
				Integer showColumnWidth[] = { 8, 25, 15, 10, 10, 15, 15,10,10,15 ,15,15,15,15,15};// 列宽
				String fileName = "车辆利用率";

				String implParam = beginTime + "  至  " + endTime;
				String total = "车辆利用率";

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
	 * 详情汇总信息 子页面
	 */
	@RequestMapping(value = "/carDetailSummaryInfo.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carDetailSummaryInfo(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String carCompany) {
		logger.info("-------------------------汇总信息--------------------------");
		CarUseDetailSummaryForOut summaryForOut = new CarUseDetailSummaryForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || StringUtils.isEmpty(carCompany)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}

		summaryForOut.setCarCompany(carCompany);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);

		OrderRequest or = new OrderRequest();
		or.setData(summaryForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_USE_DETAIL_SUMMARY);// Request
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

	/**
	 * 
	 * @Description: 车辆利用率子页面记录分页
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @return
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:34:24
	 * @version 需求对应版本号
	 */
	@RequestMapping(value = "/carDetailRecord.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carDetailRecord(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime, String carCompany) {
		logger.info("------------车辆罚款记录分页-----------------------");
		CarUseDetailSummaryForOut summaryForOut = new CarUseDetailSummaryForOut();
		PageModel<CarUseRecordForOut> pageModel = new PageModel<CarUseRecordForOut>();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		
		summaryForOut.setCarCompany(carCompany);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);

		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_USE_DETAIL_RECORD);

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
	 * 
	 * @Description: 车辆利用率子页面下载报表
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:33:13
	 * @version 2.0
	 */
	@RequestMapping(value = "/carDetailRecordDownload.do", method = RequestMethod.GET)
	public void carDetailRecordDownload(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime, String carCompany) {

		CarUseDetailSummaryForOut summaryForOut = new CarUseDetailSummaryForOut();
		PageModel<CarUseRecordForOut> pageModel = new PageModel<CarUseRecordForOut>();

		summaryForOut.setDownload(true);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);
		summaryForOut.setCarCompany(carCompany);
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<CarUseRecordForOut> recordForOutList = new ArrayList<CarUseRecordForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_USE_DETAIL_RECORD);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				recordForOutList = JSONArray.parseArray(datav1, CarUseRecordForOut.class);

				if (recordForOutList.size() > 0) {
					int i = 0;
					for (CarUseRecordForOut acf : recordForOutList) {
						// TODO 暂时用交罚款来计算扣分消除和未消除
						String acFor[] = { i + 1 + "", 
								};
						list.add(acFor);
						i++;
					}
				}

				// 设置excel信息
				String showColumnName[] = { "序列", "日期", "出车里程数", "运单编号", "物品名称", "地址", "重量",
						"折算重量","体积","提成金额","装卸费用","路桥费用"};// 列名
				String sheetName = "车辆罚款成本控制(罚款记录)";
				Integer showColumnWidth[] = { 8, 15, 15, 20, 15, 25, 10,15,10,15,15,15 };// 列宽
				String fileName = "车辆罚款";

				String implParam = beginTime + "  至  " + endTime;
				String total = "车辆罚款(罚款记录)";

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
}
