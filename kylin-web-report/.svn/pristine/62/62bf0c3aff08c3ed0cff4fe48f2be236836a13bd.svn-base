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
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.CarFineRecordForOut;
import ycapp.dbinterface.bean.CarFineSubRecordForOut;
import ycapp.dbinterface.bean.CarFineSubSummaryForOut;
import ycapp.dbinterface.bean.CarFineSummaryForOut;
import ycapp.dbinterface.bean.CarMaintenanceSummaryForOut;
import ycapp.dbinterface.bean.CarNumberForOut;

/**
 * 
 * @Description: 车辆罚款API
 * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
 * @date 2017年8月22日 下午3:45:20
 * @version 2.0
 *
 */
@Controller
@RequestMapping("/carFine")
public class CarFineController extends BaseController {
	private static Logger logger = Logger.getLogger(CarFineController.class);
	static ToolUtil tu = new ToolUtil();

	/**
	 * 汇总信息 主页面
	 */
	@RequestMapping(value = "/carSummaryInfo.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carSummaryInfo(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String blameCompany) {
		logger.info("-------------------------汇总信息--------------------------");
		CarFineSummaryForOut summaryForOut = new CarFineSummaryForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || StringUtils.isEmpty(blameCompany)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}

		summaryForOut.setBlameCompany(blameCompany);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);

		OrderRequest or = new OrderRequest();
		or.setData(summaryForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_SUMMARY);// Request
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
	 * 汇总信息 单个车辆页面
	 */
	@RequestMapping(value = "/carSummarySubInfo.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carSummarySubInfo(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String carNumber) {
		logger.info("-------------------------汇总信息--------------------------");
		CarFineSubSummaryForOut summaryForOut = new CarFineSubSummaryForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}

		summaryForOut.setCarNumber(carNumber);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);

		OrderRequest or = new OrderRequest();
		or.setData(summaryForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_SUB_SUMMARY);// Request
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
	 * 汇总信息 单个车辆页面
	 */
	@RequestMapping(value = "/carSummarySubYearInfo.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carSummarySubYearInfo(HttpServletRequest request, HttpServletResponse response, String carNumber) {
		logger.info("-------------------------汇总信息--------------------------");
		CarFineSubSummaryForOut summaryForOut = new CarFineSubSummaryForOut();
		if (StringUtils.isEmpty(carNumber)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}

		summaryForOut.setCarNumber(carNumber);

		OrderRequest or = new OrderRequest();
		or.setData(summaryForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_SUB_YEAR_SUMMARY);// Request
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
	 * @Description: 车辆罚款记录分页
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
			Integer pageSize, String beginTime, String endTime, String blameCompany) {
		logger.info("------------车辆罚款记录分页-----------------------");
		CarFineSummaryForOut summaryForOut = new CarFineSummaryForOut();
		PageModel<CarFineRecordForOut> pageModel = new PageModel<CarFineRecordForOut>();
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
		summaryForOut.setBlameCompany(blameCompany);

		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_RECORD);

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
	 * @Description: 车辆罚款列表下载报表
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
	public void carRecordDownloadByCarId(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime, String blameCompany) {
		
		
		if (StringUtils.isEmpty(beginTime) 
				|| StringUtils.isEmpty(endTime)
				|| StringUtils.isEmpty(blameCompany)) {
			logger.error("请检查查询条件");
		}
		
		CarFineSummaryForOut summaryForOut = new CarFineSummaryForOut();
		PageModel<CarFineRecordForOut> pageModel = new PageModel<CarFineRecordForOut>();
		
		if(blameCompany != null) {
			try {
				blameCompany = new String(blameCompany.getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} 
		}

		summaryForOut.setDownload(true);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);
		summaryForOut.setBlameCompany(blameCompany);
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<CarFineRecordForOut> recordForOutList = new ArrayList<CarFineRecordForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_RECORD);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				recordForOutList = JSONArray.parseArray(datav1, CarFineRecordForOut.class);

				if (recordForOutList.size() > 0) {
					int i = 0;
					for (CarFineRecordForOut acf : recordForOutList) {
						// TODO 暂时用交罚款来计算扣分消除和未消除
						int alreadyMoney = (int) (acf.getAlreadyMoney() / acf.getFineMoney() * acf.getPoints());
						String acFor[] = { i + 1 + "", 
								acf.getCarNumber(), 
								acf.getCarBrand(), 
								acf.getCarModel(),
								acf.getFineCount() + "",
								acf.getFineMoney() + "/" + acf.getAlreadyMoney() + "/" + acf.getUntreatedMoney(),
								acf.getPoints() + "/" + alreadyMoney + "/" + (acf.getPoints() - alreadyMoney) };
						list.add(acFor);
						i++;
					}
				}

				// 设置excel信息
				String showColumnName[] = { "序列", "车牌号", "车辆品牌", "车型", "违法次数", "违法罚款总金额/已处理/未处理", "合计扣分/已消除/未消除" };// 列名
				String sheetName = "车辆罚款成本控制(罚款记录)";
				Integer showColumnWidth[] = { 8, 25, 25, 15, 15, 25, 25 };// 列宽
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
	
	
	/**
	 * 
	  * @Description: 车牌号模糊搜索
	  * @param request
	  * @param response
	  * @param pageNo
	  * @param pageSize
	  * @param beginTime
	  * @param endTime
	  * @param companyName
	  * @param searchKey
	  * @return
	  * @exception
	  * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	  * @date 2017年9月13日 上午10:08:21
	  * @version 2.0
	 */
	@RequestMapping(value = "/carNumberPage.do", method = { RequestMethod.GET, RequestMethod.POST }, produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String carNumberPage(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
	Integer pageSize, String beginTime, String endTime, String blameCompany,String searchKey) {
		PageModel<CarNumberForOut> pageSearchModel = new PageModel<CarNumberForOut>();
		CarFineSummaryForOut search = new CarFineSummaryForOut();
		if (StringUtils.isEmpty(beginTime) 
				|| StringUtils.isEmpty(endTime)
				|| StringUtils.isEmpty(blameCompany)
				|| StringUtils.isEmpty(searchKey)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		
		if (pageNo == null){	
			pageNo = 1;
		}
		if (pageSize == null){
			pageSize = 100;
		}
		
		search.setBeginTime(beginTime);
		search.setEndTime(endTime);
		search.setBlameCompany(blameCompany);
		search.setSearchKey(searchKey);
		
		
		pageSearchModel.setObj(search);
		pageSearchModel.setPageNo(pageNo);
		pageSearchModel.setPageSize(pageSize);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageSearchModel);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_RECORD_CAR_PAGE);
	
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, resultInfo));
				return ResponseUtil.toJsonObject(Global.RIGHT_CODE, reason, resultInfo);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason.equals("暂无车辆维修数据")) {
				return ResponseUtil.toJsonObject(Global.WRONG_CODE, reason);
			} else if (Global.PARAM_CODE == Integer.parseInt(resultCode) && reason != "暂无车辆维修数据") {
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
	 * 
	 * @Description: 根据车辆Id查询罚款记录 分页
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @param carId
	 * @return
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:38:02
	 * @version 需求对应版本号
	 */
	@RequestMapping(value = "/carRecordById.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carRecordByCarId(HttpServletRequest request, HttpServletResponse response,
			Integer pageNo, Integer pageSize, String beginTime, String endTime, String carNumber) {
		logger.info("------------详细信息查询(表格下面)-----------------------");
		CarFineSubSummaryForOut summaryForOut = new CarFineSubSummaryForOut();
		PageModel<CarFineSubRecordForOut> pageModel = new PageModel<CarFineSubRecordForOut>();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (pageNo == null)
			pageNo = 1;
		if (pageSize == null)
			pageSize = 10;
		summaryForOut.setCarNumber(carNumber);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_SUB_RECORD);

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
	 * 根据Id 查询某车罚款记录报表下载
	 * 
	 * @param beginTime
	 * @param endTime
	 * @param companyName
	 * @param pageNo
	 * @param pageSize
	 * 
	 */
	@RequestMapping(value = "/carRecordDownloadById.do", method = RequestMethod.GET)
	public void carRecordDownloadById(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime, String carNumber) {

		if (StringUtils.isEmpty(beginTime) 
				|| StringUtils.isEmpty(endTime)
				|| StringUtils.isEmpty(carNumber)) {
			logger.error("请检查查询条件");
		}
		
		if(carNumber != null) {
			try {
				carNumber = new String(carNumber.getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} 
		}
		
		CarFineSubSummaryForOut summaryForOut = new CarFineSubSummaryForOut();
		PageModel<CarFineSubRecordForOut> pageModel = new PageModel<CarFineSubRecordForOut>();

		summaryForOut.setDownload(true);
		summaryForOut.setBeginTime(beginTime);
		summaryForOut.setEndTime(endTime);
		summaryForOut.setCarNumber(carNumber);
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<CarFineSubRecordForOut> recordForOutList = new ArrayList<CarFineSubRecordForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_FINE_SUB_RECORD);
			logger.info("entity---------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				recordForOutList = JSONArray.parseArray(datav1, CarFineSubRecordForOut.class);

				if (recordForOutList.size() > 0) {
					int i = 0;
					for (CarFineSubRecordForOut acf : recordForOutList) {
						
						String ilegalDate = null;
						if (acf.getIllegalDate() == null) {
							ilegalDate = "";
						}else {
							ilegalDate = DateUtils.getDateString(acf.getIllegalDate());
						}
						
						String acFor[] = { i + 1 + "", ilegalDate, acf.getIllegalAddress(),
								acf.getIllegalCode(), acf.getIllegalActivities(), acf.getHandleFlag(),
								acf.getFineMoney() + "", acf.getRemarks(), // 是否交款
								acf.getPoints() + "", "" // 是否消除分
						};
						list.add(acFor);

						i++;

					}

				}

				// 设置excel信息
				String showColumnName[] = { "序列", "违法时间", "违法地点", "违法代码", "违法行为", "是否处理", "罚款金额", "交款状态", "扣分",
						"是否消分" };// 列名
				String sheetName = "车辆罚款详情(罚款记录)";
				Integer showColumnWidth[] = { 8, 15, 15, 25, 15, 15, 25, 25, 10, 10 };// 列宽
				String fileName = "车辆罚款详情";

				String implParam = beginTime + "  至  " + endTime;
				String total = "车辆罚款详情(罚款记录)";

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
