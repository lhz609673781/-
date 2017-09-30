package com.ycgwl.kylin.web.report.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import ycapp.dbinterface.bean.DriverForOut;
import ycapp.dbinterface.bean.OrderForOut;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

@Controller
@RequestMapping("/driver")
public class DriverController extends BaseController {

	private static Logger logger = Logger.getLogger(DriverController.class);

	static ToolUtil tu = new ToolUtil();

	/**
	 * 司机详细信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public ModelAndView list(DriverForOut driverForOut,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		OrderRequest or = new OrderRequest();
		or.setData(driverForOut);
		String json = JSONObject.toJSONString(or);
		System.out.println(json);
		if (null != json) {
			String entity = tu.RequestPost(response, json,"http://172.16.246.53:20888/dubbo-driver/certificate/findAll");
			if (entity == null) {
				mv.addObject("driverList", null);
			} else {
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("=====================================返回结果:"
						+ resultInfo);

				String resultCode = httpresult.getString("resultCode");// 状态码

				logger.info("状态码:" + resultCode);

				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (200 == Integer.parseInt(resultCode)) {
					try {
						List<DriverForOut> list = JSONArray.parseArray(
								resultInfo, DriverForOut.class);
						mv.addObject("driverList", list);
					} catch (Exception e) {
						logger.error("错误信息:" + e);
					}
				} else {
					logger.info(resultCode + "-------------------" + reason);
				}
			}
		}
		mv.setViewName("view/driverManagement");
		return mv;
	}

}
