package com.ycgwl.kylin.web.report.controller;

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
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.bean.KeyValue;
import ycapp.dbinterface.bean.OperationReturnBillMonthForOut;

/**
 * 
 * @Description: 返单统计控制层
 * @author <a href="mailto:93253@ycgwl.com">yeyunsong</a>
 * @date 2017年5月24日 上午10:31:16
 * @version v1.4
 *
 */
@Controller
@RequestMapping("/operationReturn")
public class ReturnBillController extends BaseController {
	private static Logger logger = Logger.getLogger(ReturnBillController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();

	/***
	 * 返单统计查询（ajax请求）
	 */
	@RequestMapping(value = "/searchOperationReturn.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchOperationReturn(HttpServletRequest request,
			HttpServletResponse response, OperationReturnBillMonthForOut orForOut) {
		System.out.println("Welcome in searchOperationReturn---->post");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		or.setData(orForOut);
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		List<OperationReturnBillMonthForOut> orList = new ArrayList<OperationReturnBillMonthForOut>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_RETURN_BILL_SERV);
			System.out.println("entity-------------------------->" + entity);

			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				orList = JSONArray.parseArray(resultInfo, OperationReturnBillMonthForOut.class);
				map.put("data", orList);
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/***
	 * 返单统计查询（菜单请求）
	 */
	@RequestMapping(value = "/findOperationReturn.do", method = RequestMethod.GET)
	public ModelAndView findOperationReturn(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Welcome in findOperationReturn---->get");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		OperationReturnBillMonthForOut searchor = new OperationReturnBillMonthForOut();
		Calendar c = Calendar.getInstance();
		searchor.setBeginMonth(Global.STATUS1);// 1月
		searchor.setBeginYear(c.get(Calendar.YEAR));// 当前年
		searchor.setEndMonth(c.get(Calendar.MONTH) + 1);// 当前月
		searchor.setEndYear(c.get(Calendar.YEAR));// 当前年
		map.put("year", c.get(Calendar.YEAR));
		map.put("month", c.get(Calendar.MONTH) + 1);
		or.setData(searchor);
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		List<OperationReturnBillMonthForOut> orList = new ArrayList<OperationReturnBillMonthForOut>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_RETURN_BILL_SERV);
			System.out.println("entity-------------------------->" + entity);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				orList = JSONArray.parseArray(resultInfo, OperationReturnBillMonthForOut.class);
				map.put("orList", orList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("sheet/returnasingle").addAllObjects(map);
	}

	/***
	 * 返单统计（excel导出）
	 */
	@RequestMapping(value = "/exportOperationReturn.do", method = RequestMethod.GET)
	public void exportOperationReturn(HttpServletRequest request, HttpServletResponse response,
			OperationReturnBillMonthForOut orForOut) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		or.setData(orForOut);
		String json = JsonTool.beanTojsonString(or);
		System.out.println("json-------------------------->" + json);
		List<OperationReturnBillMonthForOut> orList = new ArrayList<OperationReturnBillMonthForOut>();
		List<String[]> list = new ArrayList<String[]>();
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.OPERATION_RETURN_BILL_SERV);
			System.out.println("entity-------------------------->" + entity);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			System.out.println("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			System.out.println("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				System.out.println("返回结果:" + resultInfo);
				orList = JSONArray.parseArray(resultInfo, OperationReturnBillMonthForOut.class);
				String showColumnName[] = new String[15];// 列名
				if (orList.size() > 0) {
					int u = 0;
					for (OperationReturnBillMonthForOut orb : orList) {
						String array[] = new String[15];
						array[0] = orb.getCompanyName();
						int i = 1;
						for (KeyValue monthList : orb.getList()) {
							array[i] = monthList.getObjValue() + "";
							i++;
						}
						array[i] = "" + orb.getTotalSum();
						list.add(array);
						u++;
					}
					// 设置excel信息
					showColumnName[0] = "分公司";
					List<KeyValue> keyValueList = orList.get(0).getList();
					int i = 1;
					for (KeyValue keyValue : keyValueList) {
						showColumnName[i] = keyValue.getKeyName();
						i++;
					}
					showColumnName[i] = "合计";
				}
				String sheetName = "返单统计";
				Integer showColumnWidth[] = new Integer[] { 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
						15 };// 列宽
				String fileName = "返单统计";
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
	}

}