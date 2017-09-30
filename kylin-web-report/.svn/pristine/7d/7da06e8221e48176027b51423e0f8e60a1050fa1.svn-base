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

/**
 * @Description: 运营部-量化统计表.
 * @author <a href="mailto:109668@ycgwl.com">lihuixia</a>
 * @date 2017年5月18日 上午11:14:11
 * @version v1.4
 *
 */
@Controller
@RequestMapping("/operationCarrier")
public class InfoQuantizationController extends BaseController {

	/**
	 * 运营部-量化统计表导出.
	 */
	@RequestMapping(value = "/exportInfoQuantization.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody void exportOperationInfoQuantization(HttpServletRequest request, HttpServletResponse response,
			String beginTime, String endTime, String platform) throws Exception {
		OperationInfoQuantizationForOut param = new OperationInfoQuantizationForOut();
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		OrderRequest or = new OrderRequest();
		or.setData(param);
		List<String[]> list = new ArrayList<String[]>();
		Map<String, Object> map = new HashMap<String, Object>();
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_CARRIER_SERV);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				List<OperationInfoQuantizationForOut> resultList = JSON.parseArray(resultInfo,
						OperationInfoQuantizationForOut.class);
				for (int i = 0; i < resultList.size(); i++) {
					OperationInfoQuantizationForOut op = resultList.get(i);
					String array[] = { op.getCompanyName() + "分公司", String.valueOf(op.getTotalSum()),
							String.valueOf(op.getNotDeliveSum()), String.valueOf(op.getDeliveFinishRate()) + "%",
							String.valueOf(op.getNotCostSum()), String.valueOf(op.getCostFinishRate()) + "%",
							String.valueOf(op.getNotIncomeSum()), String.valueOf(op.getNotIncomeFinishRate()) + "%",
							String.valueOf(op.getGrossProfitSum()), String.valueOf(op.getGrossProfitRate()) + "%"};
					list.add(array);
				}
			}
		}

		// 设置excel信息
		String showColumnName[] = { "分公司", "托运票数", "未发运", "发运完成率", "成本未录入", "成本录入完成率", "财凭未生成", "财凭录入完成率", "毛利<-5%",
				"差异占比"};// 列名
		String sheetName = "信息量化统计表";
		Integer showColumnWidth[] = { 20, 15, 15, 15, 15, 15, 15, 15, 15, 15 };// 列宽
		String fileName = "信息量化统计表";
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
	 * 运营部-量化统计表(ajax).
	 */
	@RequestMapping(value = "/infoQuantizationAjax.do", method = { RequestMethod.POST, RequestMethod.GET })
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
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_CARRIER_SERV);
			System.out.println("***************controller******************" + entity);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					List<OperationInfoQuantizationForOut> resultList = JSON.parseArray(resultInfo,
							OperationInfoQuantizationForOut.class);
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
	 * 运营部-量化统计表（默认加载）.
	 */
	@RequestMapping(value = "/infoQuantization.do", method = { RequestMethod.POST, RequestMethod.GET })
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
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_CARRIER_SERV);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					List<OperationInfoQuantizationForOut> resultList = JSON.parseArray(resultInfo,
							OperationInfoQuantizationForOut.class);
					statisMap.put("list", resultList);
					statisMap.put("mas", "success");
				} else {
					statisMap.put("mas", "error");
				}
			} catch (Exception e) {
				statisMap.put("mas", "error");
			}
		}
		return new ModelAndView("sheet/infoQuantization").addAllObjects(statisMap);
	}
}
