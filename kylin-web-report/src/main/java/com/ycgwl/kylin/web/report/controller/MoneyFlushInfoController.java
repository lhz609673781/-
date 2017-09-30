/**   
 * 项目名称：account-web 
 * Copyright © 2017-2020 版权所有：远成集团   
*/
package com.ycgwl.kylin.web.report.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.bean.OperationInfoQuantizationForOut;
import ycapp.dbinterface.bean.OperationMoneyFlushInfoForOut;

/**
 * @Description: 运营部-财凭冲红统计表
 * @author <a href="mailto:109668@ycgwl.com">lihuixia</a>
 * @date 2017年5月18日 下午12:48:20
 * @version V1.4
 *
 */
@Controller
@RequestMapping("/operationMoneyFlushInfo")
public class MoneyFlushInfoController extends BaseController {

	/**
	 * 运营部-财凭冲红统计表导出.
	 */
	@RequestMapping(value = "/exportMoneyFlushInfo.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody void exportOperationInfoQuantization(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String platform) throws Exception {
		OperationMoneyFlushInfoForOut param = new OperationMoneyFlushInfoForOut();
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		OrderRequest or = new OrderRequest();
		or.setData(param);
		List<String[]> list = new ArrayList<String[]>();
		Map<String, Object> map = new HashMap<String, Object>();
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_MONEY_FLUSH_SERV);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				List<OperationMoneyFlushInfoForOut> resultList = JSON.parseArray(resultInfo,
						OperationMoneyFlushInfoForOut.class);
				for (int i = 0; i < resultList.size(); i++) {
					OperationMoneyFlushInfoForOut op = resultList.get(i);
					String array[] = { op.getCompanyName() + "分公司", String.valueOf(op.getCountSum()),
							String.valueOf(op.getFlushInThirtyMinuteSum()),
							String.valueOf(op.getFlushInThirtyMinuteRate()) + "%",
							String.valueOf(op.getFlushOutThirtyMinuteSum()),
							String.valueOf(op.getFlushOutThirtyMinuteRate()) + "%",
							String.valueOf(op.getTotalRate()) + "%", String.valueOf(op.getAwardDetail()) };
					list.add(array);
				}
			}		
		}

		// 设置excel信息
		String showColumnName[] = { "分公司", "办单票数", "票数（30分钟内）", "占比（30分钟内）", "票数（30分钟外）", "占比", "综合占比", "奖惩明细" };// 列名
		String sheetName = "财凭冲红统计表";
		Integer showColumnWidth[] = { 20, 20, 20, 20, 20, 20, 20, 20 };// 列宽
		String fileName = "财凭冲红统计表";
		// String totalSum = "第一行统计内容";
		ExcelForm excelForm = new ExcelForm();
		excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
		excelForm.setList(list);// 导出的内容
		// excelForm.setTotalSumContent(totalSum);
		excelForm.setSheetName(sheetName);
		excelForm.setShowColumnName(showColumnName);
		excelForm.setShowColumnWidth(showColumnWidth);
		ExcelReportUtils.exportExcel(excelForm, response);
	}

	/**
	 * 运营部-财凭冲红统计表(ajax).
	 */
	@RequestMapping(value = "/moneyFlushInfoAjax.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Map<String, Object> grossProfitStatisAjax(String beginTime, String endTime, String pageNo,
			String pageSize, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> statisMap = new HashMap<String, Object>();
		OperationInfoQuantizationForOut param = new OperationInfoQuantizationForOut();
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		OrderRequest or = new OrderRequest();
		or.setData(param);
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_MONEY_FLUSH_SERV);
			System.out.println("***************controller******************" + entity);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					List<OperationMoneyFlushInfoForOut> resultList = JSON.parseArray(resultInfo,
							OperationMoneyFlushInfoForOut.class);
					statisMap.put("list", resultList);
					statisMap.put("mas", "success");
				} else {
					statisMap.put("mas", "error");
				}
			} catch (Exception e) {
				statisMap.put("mas", "error");
			}
		}
		return statisMap;
	}

	/**
	 * 运营部-财凭冲红统计表（默认加载）.
	 */
	@RequestMapping(value = "/moneyFlushInfo.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView grossProfitStatis(String beginTime, String endTime, String platform, String pageNo,
			String pageSize, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> statisMap = new HashMap<String, Object>();
		OperationInfoQuantizationForOut param = new OperationInfoQuantizationForOut();
		Calendar c = Calendar.getInstance();
		int day = c.get(Calendar.DATE);
		if (day != 1) {
			param.setBeginTime(DateUtils.toFirstDayOfMonth(beginTime));
			param.setEndTime(DateUtils.toYesterDayOfMonth(endTime));
		} else {
			param.setBeginTime(DateUtils.firstDateOfTerdayMonth());
			param.setEndTime(DateUtils.yesterday());
		}
		statisMap.put("beginTime", param.getBeginTime());
		statisMap.put("endTime", param.getEndTime());
		OrderRequest or = new OrderRequest();
		or.setData(param);
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_MONEY_FLUSH_SERV);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					List<OperationMoneyFlushInfoForOut> resultList = JSON.parseArray(resultInfo,
							OperationMoneyFlushInfoForOut.class);
					statisMap.put("list", resultList);
					statisMap.put("mas", "success");
				} else {
					statisMap.put("mas", "error");
				}
			} catch (Exception e) {
				statisMap.put("mas", "error");
			}
		}
		return new ModelAndView("sheet/moneyFlushInfo").addAllObjects(statisMap);
	}
}
