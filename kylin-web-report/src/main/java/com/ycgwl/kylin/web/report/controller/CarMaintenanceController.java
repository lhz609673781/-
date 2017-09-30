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

import com.alibaba.fastjson.JSON;
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
import ycapp.dbinterface.bean.CarMaintenanceAllRecordForOut;
import ycapp.dbinterface.bean.CarNumberForOut;
import ycapp.dbinterface.bean.CarMaintenanceRecordForOut;
import ycapp.dbinterface.bean.CarMaintenanceSummaryForOut;
import ycapp.dbinterface.bean.OperationGroupReportSearchForOut;

/**
 * 
  * @Description: 车辆维修Controller
  * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
  * @date 2017年8月21日 上午10:53:07
  * @version 2.0
  *
 */
@Controller
@RequestMapping("/carMaintenance")
public class CarMaintenanceController extends BaseController {
	private static Logger logger = Logger.getLogger(CarMaintenanceController.class);
	static ToolUtil tu = new ToolUtil();

	/**
	 * 汇总信息 主页面
	 */
	@RequestMapping(value = "/carSummaryInfo.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carSummaryInfo(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String companyName) {
		logger.info("-------------------------汇总信息--------------------------");
		CarMaintenanceSummaryForOut summaryForOut = new CarMaintenanceSummaryForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || StringUtils.isEmpty(companyName)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}

		summaryForOut.setSearchType(0);
		summaryForOut.setCompanyName(companyName);
		summaryForOut.setBeginTime(DateUtils.getYearMonth(beginTime));
		summaryForOut.setEndTime(DateUtils.getYearMonth(endTime));

		OrderRequest or = new OrderRequest();
		or.setData(summaryForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_SUMMARY);// Request
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
		CarMaintenanceSummaryForOut summaryForOut = new CarMaintenanceSummaryForOut();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		
		summaryForOut.setSearchType(1);
		summaryForOut.setCarNumber(carNumber);
		summaryForOut.setBeginTime(DateUtils.getYearMonth(beginTime));
		summaryForOut.setEndTime(DateUtils.getYearMonth(endTime));

		OrderRequest or = new OrderRequest();
		or.setData(summaryForOut);
		String json = JsonTool.beanTojsonString(or);
		try {

			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_SUMMARY);// Request
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
	 * @Description: 车辆维修记录分页
	 * @param request
	 * @param response
	 * @param pageNo
	 * @param pageSize
	 * @param beginTime
	 * @param endTime
	 * @return
	 * @exception 
	 * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:34:24
	 * @version 需求对应版本号
	 */
	@RequestMapping(value = "/carRecordAll.do", method = RequestMethod.POST , produces = {
	"application/json;charset=UTF-8" })
	public @ResponseBody String carRecordAll(HttpServletRequest request, HttpServletResponse response, Integer pageNo,
			Integer pageSize, String beginTime, String endTime, String companyName) {
		logger.info("------------详细信息查询(表格下面)-----------------------");
		CarMaintenanceSummaryForOut summaryForOut = new CarMaintenanceSummaryForOut();
		PageModel<CarMaintenanceAllRecordForOut> pageModel = new PageModel<CarMaintenanceAllRecordForOut>();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime) || StringUtils.isEmpty(companyName)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (pageNo == null){
			pageNo = 1;
		}
			
		if (pageSize == null){
			pageSize = 10;
		}
			
		summaryForOut.setBeginTime(DateUtils.getYearMonth(beginTime));
		summaryForOut.setEndTime(DateUtils.getYearMonth(endTime));
		summaryForOut.setCompanyName(companyName);
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_ALL_RECORD);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 取出状态码
			String reason = httpresult.getString("reason");// 返回信息
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				pageModel = JSON.parseObject(resultInfo, PageModel.class);
				logger.info("resultInfo----------------------------->" + resultInfo);
				System.out.println("返回数据----------------------------->"
						+ ResponseUtil.toJsonObject(Global.RIGHT_CODE, Global.QUERY_SUCCESS, pageModel));
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
	 * @Description: 车辆维修列表下载报表
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

	@RequestMapping(value = "/carRecordDownloadAll.do", method = RequestMethod.GET)
	public void carRecordDownloadByCarId(HttpServletRequest request, HttpServletResponse response,Integer pageNo,Integer pageSize, String beginTime, String endTime, String companyName) {

		
		if (StringUtils.isEmpty(beginTime) 
				|| StringUtils.isEmpty(endTime)
				|| StringUtils.isEmpty(companyName)) {
			logger.error("请检查查询条件");
		}
		
		
		CarMaintenanceSummaryForOut summaryForOut = new CarMaintenanceSummaryForOut();
		PageModel<CarMaintenanceAllRecordForOut> pageModel = new PageModel<>();

		if (pageNo == null){
			pageNo = 1;
		}
			
		if (pageSize == null){
			pageSize = 100000000;
		}
		
		if(companyName != null) {
			try {
				companyName = new String(companyName.getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} 
		}
		
		summaryForOut.setBeginTime(DateUtils.getYearMonth(beginTime));
		summaryForOut.setEndTime(DateUtils.getYearMonth(endTime));
		summaryForOut.setCompanyName(companyName);
		summaryForOut.setIsDownload(true);
		
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<CarMaintenanceAllRecordForOut> recordForOutList = new ArrayList<>();

		List<String[]> list = new ArrayList<>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_ALL_RECORD);
			logger.info("entity---------------------------->" + entity);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				recordForOutList = JSONArray.parseArray(datav1, CarMaintenanceAllRecordForOut.class);

				if (recordForOutList.size() > 0) {
					int i = 0;
					
					for (CarMaintenanceAllRecordForOut acf : recordForOutList) {

						String boardDate = null;
						if (acf.getBoardDate() == null) {
							boardDate = "";
						}else {
							boardDate = DateUtils.getDateString(acf.getBoardDate());
						}
						
						 String acFor[] = { i + 1 + "",
						 acf.getCarNumber(), 
						 acf.getCarBrand(),
						 acf.getComparType(),
						 acf.getEnginePower(),
						 acf.getEngineHpower(),
						 boardDate,
						 acf.getCarUse(),
						 acf.getMaitainNum()+"",
						 acf.getMaitainHour()+"",
						 acf.getMaitainSum()+""
						 };
						 list.add(acFor);

						i++;

					}

				}

				// 设置excel信息
				String showColumnName[] = { "序列", "车牌号", "车辆品牌", "车型", "发动机功率单位/KW", "发动机马力", "上牌日期", "车辆用途",
						"维修次数", "维修时常", "维修金额" };// 列名
				String sheetName = "车辆维修成本控制(维修记录)";
				Integer showColumnWidth[] = { 8, 25, 25, 15, 15, 15, 25, 25, 10, 10, 15 };// 列宽
				String fileName = "车辆维修成本控制";

				String implParam = beginTime + "  至  " + endTime;
				String total = "车辆维修成本控制(维修记录)";

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
	 * @Description: 根据车辆Id查询维修记录 分页
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
		CarMaintenanceSummaryForOut summaryForOut = new CarMaintenanceSummaryForOut();
		PageModel<CarMaintenanceRecordForOut> pageModel = new PageModel<CarMaintenanceRecordForOut>();
		if (StringUtils.isEmpty(beginTime) || StringUtils.isEmpty(endTime)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		if (pageNo == null){
			pageNo = 1;
		}
			
		if (pageSize == null){
			pageSize = 10;
		}
			
		summaryForOut.setCarNumber(carNumber);
		summaryForOut.setBeginTime(DateUtils.getYearMonth(beginTime));
		summaryForOut.setEndTime(DateUtils.getYearMonth(endTime));
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageModel);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_RECORD);
		
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
	Integer pageSize, String beginTime, String endTime, String companyName,String searchKey) {
		PageModel<CarNumberForOut> pageSearchModel = new PageModel<>();
		CarMaintenanceSummaryForOut search = new CarMaintenanceSummaryForOut();
		if (StringUtils.isEmpty(beginTime) 
				|| StringUtils.isEmpty(endTime)
				|| StringUtils.isEmpty(companyName)
				|| StringUtils.isEmpty(searchKey)) {
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, "请检查查询条件");
		}
		
		if (pageNo == null){	
			pageNo = 1;
		}
		if (pageSize == null){
			pageSize = 100;
		}
		
		
		search.setCompanyName(companyName);
		search.setSearchKey(searchKey);
		search.setBeginTime(DateUtils.getYearMonth(beginTime));
		search.setEndTime(DateUtils.getYearMonth(endTime));
		
		pageSearchModel.setObj(search);
		pageSearchModel.setPageNo(pageNo);
		pageSearchModel.setPageSize(pageSize);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(pageSearchModel);
		String json = JsonTool.beanTojsonString(orderRequest);
		
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_RECORD_CAR_PAGE);
	
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
	 * 根据Id 查询某车维修记录报表下载
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
		
		CarMaintenanceSummaryForOut summaryForOut = new CarMaintenanceSummaryForOut();
		PageModel<CarMaintenanceRecordForOut> pageModel = new PageModel<CarMaintenanceRecordForOut>();

		if (pageNo == null){
			pageNo = 1;
		}
			
		if (pageSize == null){
			pageSize = 100000000;
		}
		
		if(carNumber != null) {
			try {
				carNumber = new String(carNumber.getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} 
		}
			
		summaryForOut.setBeginTime(DateUtils.getYearMonth(beginTime));
		summaryForOut.setEndTime(DateUtils.getYearMonth(endTime));
		summaryForOut.setCarNumber(carNumber);
		summaryForOut.setIsDownload(true);
		
		pageModel.setObj(summaryForOut);
		pageModel.setPageNo(pageNo);
		pageModel.setPageSize(pageSize);

		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		String json = JsonTool.beanTojsonString(or);

		List<CarMaintenanceRecordForOut> recordForOutList = new ArrayList<CarMaintenanceRecordForOut>();

		List<String[]> list = new ArrayList<String[]>();

		String entity;
		try {
			entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_RECORD);
			logger.info("entity---------------------------->" + entity);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码

			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				System.out.println("返回结果:" + resultInfo);

				JSONObject jsonobjv1 = JSONObject.parseObject(resultInfo);
				String datav1 = jsonobjv1.getString("list");

				recordForOutList = JSONArray.parseArray(datav1, CarMaintenanceRecordForOut.class);

				if (recordForOutList.size() > 0) {
					int i = 0;
					for (CarMaintenanceRecordForOut acf : recordForOutList) {
						
						String repairDate = null;
						if (acf.getRepairDate() == null) {
							repairDate = "";
						}else {
							repairDate = DateUtils.getDateString(acf.getRepairDate());
						}
						
						 String acFor[] = { i + 1 + "",
								 repairDate,
								 acf.getRepairMileage(),
								 acf.getRepairShopName(),
								 acf.getRepairShopNature(),
								 acf.getRepairProject(),
								 acf.getTelephone(),
								 acf.getRepairFee()+"",
								 acf.getReportNumber(),
								 acf.getTotalFee()+"",
								 acf.getRamark()};
						 list.add(acFor);

						i++;

					}

				}

				// 设置excel信息
				String showColumnName[] = { "序列", "维修日期", "维修里数", "维修厂名称", "维修性质", "联系电话", "配件费用", "工时", "工时费用",
						"报告号", "总费用", "备注" };// 列名
				String sheetName = "车辆维修详情(维修记录)";
				Integer showColumnWidth[] = { 8, 15, 15, 25, 15, 15, 25, 25, 10, 10, 15, 15 };// 列宽
				String fileName = "车辆维修详情";

				String implParam = beginTime + "  至  " + endTime;
				String total = "车辆维修详情(维修记录)";

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
	 * @Description: 根据车辆维修记录Id查询维修项记录
	 * @param request
	 * @param response
	 * @param recordId
	 * @return CarMaintenanceItemForOut List
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:38:02
	 * @version 2.0
	 */
	@RequestMapping(value = "/carRecordItemByRecordId.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carRecordItemByRecordId(HttpServletRequest request, HttpServletResponse response,
			String carNumber,String repairDate,String repairProject) {
		logger.info("-----------根据车辆维修记录Id查询维修项记录 -----------------------");
		CarMaintenanceSummaryForOut recordForOut = new CarMaintenanceSummaryForOut();
		recordForOut.setCarNumber(carNumber);
		recordForOut.setRepairDate(repairDate);
		recordForOut.setRepairProject(repairProject);
		
		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(recordForOut);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_RECORD_ITEM);
			
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
	 * @Description: 根据车辆维修记录Id查询维修时长记录
	 * @param request
	 * @param response
	 * @param recordId
	 * @return CarMaintenanceTimeForOut List
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月21日 下午4:38:02
	 * @version 2.0
	 */
	@RequestMapping(value = "/carRecordTimeByRecordId.do", method = RequestMethod.POST, produces = {
			"application/json;charset=UTF-8" })
	public @ResponseBody String carRecordTimeByRecordId(HttpServletRequest request, HttpServletResponse response,
			String carNumber,String repairDate,String repairProject) {
		logger.info("-----------根据车辆维修记录Id查询维修项记录 -----------------------");
		CarMaintenanceSummaryForOut recordForOut = new CarMaintenanceSummaryForOut();
		recordForOut.setCarNumber(carNumber);
		recordForOut.setRepairDate(repairDate);
		recordForOut.setRepairProject(repairProject);

		OrderRequest orderRequest = new OrderRequest();
		orderRequest.setData(recordForOut);
		String json = JsonTool.beanTojsonString(orderRequest);

		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CAR_MAINTENANCE_RECORD_ITEM);
		
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
