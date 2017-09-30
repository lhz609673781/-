package com.ycgwl.kylin.web.report.controller;

import java.util.HashMap;
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

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.BackUserForOut;
import ycapp.dbinterface.bean.CustomerForOut;

/**
 * 客户Controller
 * 
 * @author yys
 *
 */
@Controller
@RequestMapping("/customer")
public class CustomerContorller extends BaseController {

	private static Logger logger = Logger.getLogger(CustomerContorller.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();
	Map<String, Object> map = new HashMap<String, Object>();

	/**
	 * 
	 * 客户注册
	 * 
	 * @return
	 */

	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> registerCustomer(CustomerForOut customer, HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("~~~~~~~~~·进入register~~~~~~~~~~~~~即将创建客户账号");
		if (null == customer) {
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
		OrderRequest or = new OrderRequest();
		or.setData(customer);
		BackUserForOut backUserForOut = (BackUserForOut) request.getSession().getAttribute("user");
		if (null == backUserForOut) {
			map.put("mas", Global.UNLOGIN);
			return map;
		}
		or.setLoginuser(backUserForOut);
		String json = JsonTool.beanTojsonString(or);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CREATECUSTOMER_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String reason = httpresult.getString("reason");// 返回信息
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
				return map;
			}
			map.put("mas", Global.AJAX_STATUS_ERROR);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("mas", Global.AJAX_STATUS_ERROR);
		}
		return map;
	}

	/**
	 * 根据id查找客户（修改客户账号）
	 * 
	 * @return
	 */
	@RequestMapping(value = "/loadByIdEdit.do", method = RequestMethod.GET)
	public String loadCustomerByIdEdit(Map<String, Object> map, String id, String type, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("~~~~~~~~~~~·进入loadById~~~~~~~~~即将根据id查询客户账号，传输数据：" + id);
		if (null == id) {
			return "error";
		}
		OrderRequest or = new OrderRequest();
		or.setData(id);
		BackUserForOut backUserForOut = (BackUserForOut) request.getSession().getAttribute("user");
		if (null == backUserForOut) {
			request.setAttribute("loginmas", Global.UNLOGIN);
			return "login";
		}
		or.setLoginuser(backUserForOut);
		String json = JsonTool.beanTojsonString(or);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CUSTOMERBYID_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("返回数据:" + resultInfo);
				CustomerForOut customerForOut = null;
				customerForOut = JSONObject.parseObject(resultInfo, CustomerForOut.class);
				map.put("customerForOut", customerForOut);
			} else {
				logger.info(resultCode + "-------------------" + reason);
				return "error";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "customer/EditorCustomer";
	}

	/**
	 * 根据id查找客户（查询客户详情）
	 * 
	 * @return
	 */
	@RequestMapping(value = "/findByIdDetails.do", method = RequestMethod.GET)
	public String findCustomerByIdDetails(Map<String, Object> map, String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("~~~~~~~~~~~·进入findById~~~~~~~~~即将根据id查询客户账号，传输数据：" + id);
		if (null == id) {
			return "error";
		}
		OrderRequest or = new OrderRequest();
		or.setData(id);
		BackUserForOut backUserForOut = (BackUserForOut) request.getSession().getAttribute("user");
		if (null == backUserForOut) {
			request.setAttribute("loginmas", Global.UNLOGIN);
			return "login";
		}
		or.setLoginuser(backUserForOut);
		String json = JsonTool.beanTojsonString(or);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CUSTOMERBYID_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("返回数据:" + resultInfo);
				CustomerForOut customerForOut = null;
				customerForOut = JSONObject.parseObject(resultInfo, CustomerForOut.class);
				map.put("customerForOut", customerForOut);
				return "customer/DetailsCustomer";

			} else {
				logger.info(resultCode + "-------------------" + reason);
				return "error";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	/**
	 * 启用客户账号
	 * 
	 * @return
	 */
	@RequestMapping(value = "/adopt.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> adoptCustomer(String id, HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("~~~~~~~~~~~~~~~~~进入adopt.do~~~~~~~~~~~~~即将启用客户账号");
		logger.info("启用id——————————————————————————>：" + id);
		if (null == id) {
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
		OrderRequest or = new OrderRequest();
		BackUserForOut backUserForOut = (BackUserForOut) request.getSession().getAttribute("user");
		if (null == backUserForOut) {
			map.put("mas", Global.UNLOGIN);
			return map;
		}
		or.setLoginuser(backUserForOut);
		or.setData(id);
		String json = JsonTool.beanTojsonString(or);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.ADOPT_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String reason = httpresult.getString("reason");// 返回信息
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
				return map;
			} else {
				map.put("mas", Global.AJAX_STATUS_ERROR);
				return map;
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
	}

	/**
	 * 修改客户账号
	 * 
	 * @return
	 */
	@RequestMapping(value = "/revise.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reviseCustomer(CustomerForOut customer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("~~~~~~~~~~~~~~~~~进入revise.do~~~~~~~~~~~~~即将修改客户账号");
		if (null == customer) {
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
		OrderRequest or = new OrderRequest();
		BackUserForOut backUserForOut = (BackUserForOut) request.getSession().getAttribute("user");
		if (null == backUserForOut) {
			map.put("mas", Global.UNLOGIN);
			return map;
		}
		or.setLoginuser(backUserForOut);
		or.setData(customer);
		String json = JsonTool.beanTojsonString(or);
		try {
			String entity = tu.RequestPost(response, json, LHX_URL + Global.MODIFYCUSTOMER_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String reason = httpresult.getString("reason");// 返回信息
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				map.put("mas", Global.AJAX_STATUS_SUCCESS);
				return map;
			} else {
				map.put("mas", Global.AJAX_STATUS_ERROR);
				return map;
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return map;
		}
	}

	/**
	 * 停用客户账户
	 * 
	 * @return
	 */
	// @RequestMapping(value = "/cease.do", method = RequestMethod.POST)
	// public @ResponseBody String ceaseCustomer(Map<String, Object> map,
	// CustomerForOut customer,
	// HttpServletRequest request, HttpServletResponse response) throws
	// Exception {
	// logger.info("进入revise");
	// if (null == customer) {
	// map.put("mas", Global.FAIL_MSG);
	// return "customer/CustomerList";
	// }
	// OrderRequest or = new OrderRequest();
	// or.setData(customer);
	// String json = JsonTool.beanTojsonString(or);
	// try {
	// String entity = tu.RequestPost(response, json, FWQ_URL +
	// Global.SEARCHORDER_URL);
	// JSONObject httpresult = JSONObject.parseObject(entity);
	// String reason = httpresult.getString("reason");// 返回信息
	// request.setAttribute("mas", reason);
	// } catch (Exception e) {
	// e.printStackTrace();
	// return Global.FAIL_MSG;
	// }
	// return Global.SUCCESS_MSG;
	// }

	/**
	 * 查询客户（GET请求）
	 * 
	 * @return
	 */
	@RequestMapping(value = "/look.do", method = RequestMethod.GET)
	public ModelAndView lookCustomer(String pageNo, String pageSize, HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("~~~~~~~~~~~~~~~~~进入look.do~~~~~~~~即将查询");
		try {
			OrderRequest or = new OrderRequest();
			BackUserForOut backUserForOut = (BackUserForOut) request.getSession().getAttribute("user");
			if (null == backUserForOut) {
				map.put("loginmas", Global.UNLOGIN);
				return new ModelAndView("login").addAllObjects(map);
			}
			PageModel<CustomerForOut> pagemodel = new PageModel<CustomerForOut>();
			if (StringUtils.isEmpty(pageNo) || StringUtils.isEmpty(pageSize)) {
				return new ModelAndView("error");
			}
			pagemodel.setPageNo(Integer.parseInt(pageNo));
			pagemodel.setPageSize(Integer.parseInt(pageSize));
			pagemodel.setObj(null);
			or.setLoginuser(backUserForOut);
			or.setData(pagemodel);
			String json = JsonTool.beanTojsonString(or);
			logger.info("传输数据:" + json);
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CUSTOMER_RETRIEVE);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("返回数据:" + resultInfo);
				try {
					pagemodel = JSONObject.parseObject(resultInfo, PageModel.class);
					map.put("page", pagemodel);
				} catch (Exception e) {
					logger.error("错误信息:" + e);
					map.put("mas", "客户加载失败");
					return new ModelAndView("customer/CustomerList").addAllObjects(map);
				}
			} else {
				logger.info(resultCode + "-------------------" + reason);
				map.put("mas", "客户加载失败");
				return new ModelAndView("customer/CustomerList").addAllObjects(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("error");
		}
		return new ModelAndView("customer/CustomerList").addAllObjects(map);
	}

	/**
	 * 异步查询客户
	 * 
	 * @return
	 */
	@RequestMapping(value = "/searchCustomer.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView searchCustomer(String name, String phone, String status, String pageNo, String pageSize,
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("~~~~~~~~~~~~~~~~~进入look.do~~~~~~~~即将查询");
		PageModel<CustomerForOut> pagemodel = new PageModel<CustomerForOut>();
		try {
			OrderRequest or = new OrderRequest();
			BackUserForOut backUserForOut = (BackUserForOut) request.getSession().getAttribute("user");
			if (null == backUserForOut) {
				map.put("loginmas", Global.UNLOGIN);
				return new ModelAndView("login").addAllObjects(map);
			}
			CustomerForOut customerForOut = new CustomerForOut();
			customerForOut.setName(name);
			customerForOut.setPhone(phone);
			customerForOut.setStatus(Integer.parseInt(status));
			pagemodel.setObj(customerForOut);
			pagemodel.setPageNo(Integer.parseInt(pageNo));
			pagemodel.setPageSize(Integer.parseInt(pageSize));
			or.setLoginuser(backUserForOut);
			or.setData(pagemodel);
			String json = JsonTool.beanTojsonString(or);
			logger.info("传输数据:" + json);
			String entity = tu.RequestPost(response, json, LHX_URL + Global.CUSTOMER_RETRIEVE);
		
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			logger.info("状态码:" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info("返回信息:" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");// 返回数据
				logger.info("返回数据:" + resultInfo);
				pagemodel = JSONObject.parseObject(resultInfo, PageModel.class);
				map.put("page", pagemodel);
				return new ModelAndView("customer/CustomerListPage").addAllObjects(map);
			} else {
				logger.info(resultCode + "-------------------" + reason);
				map.put("mas", Global.AJAX_STATUS_ERROR);
				return new ModelAndView("customer/CustomerListPage").addAllObjects(map);
			}			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("mas", Global.AJAX_STATUS_ERROR);
			return new ModelAndView("customer/CustomerListPage").addAllObjects(map);
		}

	}

}
