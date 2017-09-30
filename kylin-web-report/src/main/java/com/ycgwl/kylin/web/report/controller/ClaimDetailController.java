/**   
 * 项目名称：account-web 
 * Copyright © 2017-2020 版权所有：远成集团   
*/
package com.ycgwl.kylin.web.report.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import com.ycgwl.kylin.web.report.utils.CalcUtils;
import com.ycgwl.kylin.web.report.utils.DateUtils;
import com.ycgwl.kylin.web.report.utils.ExcelReportUtils;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.ExcelForm;
import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.OperationClaimDetailForOut;

/**
 * @Description: 理赔占比明细表.
 * @author <a href="mailto:109668@ycgwl.com">lihuixia</a>
 * @date 2017年5月22日 下午4:28:31
 * @version V1.4
 *
 */
@Controller
@RequestMapping("/claimDetail")
public class ClaimDetailController extends BaseController {
	static ToolUtil tu = new ToolUtil();

	/**
	 * 理赔占比明细表导出.
	 */
	@RequestMapping(value = "/exportClaimDetail.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody void exportClaimDetail(HttpServletRequest request, HttpServletResponse response,
			String groupName, String beginTime, String endTime, String customerName) throws Exception {
		try {
			groupName = URLDecoder.decode(groupName, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		OperationClaimDetailForOut param = new OperationClaimDetailForOut();
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		param.setCompanyName(groupName);
		param.setCustomerName(customerName);
		PageModel<OperationClaimDetailForOut> pageModel = new PageModel<OperationClaimDetailForOut>();
		pageModel.setObj(param);
		pageModel.setPageNo(1);
		pageModel.setPageSize(1000000000);
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		List<String[]> list = new ArrayList<String[]>();
		Map<String, Object> map = new HashMap<String, Object>();
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_ClAIM_DETAIL_SERV);
			
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				JSONObject jsonObject = JSONObject.parseObject(resultInfo);
				String listStr = jsonObject.getString("list");
				List<OperationClaimDetailForOut> resultList = JSON.parseArray(listStr,
						OperationClaimDetailForOut.class);
				
				if("1".equals(groupName) && StringUtils.isBlank(customerName)){
					for (int i = 0; i < resultList.size(); i++) {
						OperationClaimDetailForOut op = resultList.get(i);
						String array[] = { op.getCompanyName() + "分公司",CalcUtils.calcScientficNum(op.getPayAmount()),
								CalcUtils.calcScientficNum(op.getBusinIncome()), op.getClaimRate() + "%" };
						list.add(array);
					}
				}else{
					for (int i = 0; i < resultList.size(); i++) {
						OperationClaimDetailForOut op = resultList.get(i);
						String array[] = { op.getCompanyName() + "分公司", op.getCustomerName(),
								CalcUtils.calcScientficNum(op.getPayAmount()),
								CalcUtils.calcScientficNum(op.getBusinIncome()), op.getClaimRate() + "%" };
						list.add(array);
					}
				}			
			}	
		}

		// 设置excel信息
		String sheetName = "理赔占比明细表";
		String fileName = "理赔占比明细表";
		ExcelForm excelForm = new ExcelForm();
		if("1".equals(groupName) && StringUtils.isBlank(customerName)){
			String[] showColumnName = { "分公司", "赔付金额", "运输收入合计", "理赔占比" };// 列名
			Integer[] showColumnWidth = { 20, 20, 30, 15, 15 };// 列宽
			excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
			excelForm.setList(list);// 导出的内容
			excelForm.setSheetName(sheetName);
			excelForm.setShowColumnName(showColumnName);
			excelForm.setShowColumnWidth(showColumnWidth);
		}else{
			String[] showColumnName = { "分公司", "客户名称", "赔付金额", "运输收入合计", "理赔占比" };// 列名
			Integer[] showColumnWidth = { 20, 15, 20, 30, 15, 15 };// 列宽
			excelForm.setFileName(fileName);// excel文件名称（不包含后缀)
			excelForm.setList(list);// 导出的内容
			excelForm.setSheetName(sheetName);
			excelForm.setShowColumnName(showColumnName);
			excelForm.setShowColumnWidth(showColumnWidth);
		}
			
		ExcelReportUtils.exportExcel(excelForm, response);
	}

	/**
	 * 理赔占比明细表(ajax).
	 */
	@RequestMapping(value = "/claimDetailAjax.do", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Map<String, Object> claimDetailAjax(String beginTime, String endTime, String customerName,
			String groupName, String pageNo, String pageSize, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> statisMap = new HashMap<String, Object>();
		OperationClaimDetailForOut param = new OperationClaimDetailForOut();
		param.setBeginTime(beginTime);
		param.setEndTime(endTime);
		param.setCustomerName(customerName);
		param.setCompanyName(groupName);
		PageModel<OperationClaimDetailForOut> pageModel = new PageModel<OperationClaimDetailForOut>();
		pageModel.setObj(param);
		pageModel.setPageNo(Integer.valueOf(pageNo));
		pageModel.setPageSize(Integer.valueOf(pageSize));
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_ClAIM_DETAIL_SERV);
			System.out.println("***************controller******************" + entity);
			
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					PageModel<OperationClaimDetailForOut> resultPageModel = JSONObject.parseObject(resultInfo,
							PageModel.class);
					statisMap.put("page", resultPageModel);
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
	 * 理赔占比明细表.
	 */
	@RequestMapping(value = "/claimDetail.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView claimDetail(String beginTime, String endTime, String customerName, String pageNo,
			String pageSize, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> statisMap = new HashMap<String, Object>();
		OperationClaimDetailForOut param = new OperationClaimDetailForOut();
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
		param.setCustomerName(customerName);
		param.setCompanyName(null);
		PageModel<OperationClaimDetailForOut> pageModel = new PageModel<OperationClaimDetailForOut>();
		pageModel.setObj(param);
		pageModel.setPageNo(1);
		pageModel.setPageSize(20);
		OrderRequest or = new OrderRequest();
		or.setData(pageModel);
		ToolUtil curr = new ToolUtil();
		if (null != or) {
			String json = JsonTool.beanTojsonString(or);
			String entity = curr.RequestPost(response, json, LHX_URL + Global.OPERATION_ClAIM_DETAIL_SERV);
		
			try {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回数据
					PageModel<OperationClaimDetailForOut> resultPageModel = JSONObject.parseObject(resultInfo,
							PageModel.class);
					statisMap.put("statisPage", resultPageModel);
					statisMap.put("mas", "success");
				} else {
					statisMap.put("mas", "error");
				}
			} catch (Exception e) {
				statisMap.put("mas", "error");
			}		
		}
		return new ModelAndView("sheet/claimDetail").addAllObjects(statisMap);
	}
}
