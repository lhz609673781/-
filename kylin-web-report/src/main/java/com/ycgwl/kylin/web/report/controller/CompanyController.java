package com.ycgwl.kylin.web.report.controller;

import java.net.ConnectException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.dbinterface.PageModel;
import ycapp.dbinterface.bean.BackUserForOut;
import ycapp.dbinterface.bean.CompanyForOut;

@Controller
@RequestMapping("/company")
public class CompanyController extends BaseController {
	private static Logger logger = Logger.getLogger(CompanyController.class);
	// 工具类
	static ToolUtil tu = new ToolUtil();

	@SuppressWarnings({ "unchecked", "null" })
	@RequestMapping(value = "/search.do", method = RequestMethod.GET)
	public ModelAndView search(String name, String contacts, String phone, long status, int pageNo, int pageSize,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||searchCompany");
		Map<String, Object> map = new HashMap<String, Object>();
		CompanyForOut company = new CompanyForOut();
		PageModel<CompanyForOut> page = new PageModel<CompanyForOut>();
		company = tu.getCompany(name, contacts, phone, status);
		page.setPageSize(pageSize);
		page.setPageNo(pageNo);
		if (company == null) {
			page.setObj("");
		} else {
			page.setObj(company);
		}
		OrderRequest or = new OrderRequest();
		or = tu.getOrderRequest(request, response, page);
		if (or != null) {
			try {
				String json = JsonTool.beanTojsonString(or);
				logger.info("=====================================传输数据:" + json);
				if (null != json) {
					String entity = tu.RequestPost(response, json, LHX_URL + Global.FINDCOMPUNYBYPARA);
					
					JSONObject httpresult = JSONObject.parseObject(entity);
					logger.info("=====================================返回结果:" + httpresult.getString("resultInfo"));
					String resultCode = httpresult.getString("resultCode");// 状态码
					logger.info("状态码:" + resultCode);
					String reason = httpresult.getString("reason");// 返回信息
					logger.info("返回信息:" + reason);
					if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
						try {
							JSONObject data = (JSONObject) httpresult.get("resultInfo");
							page = JSONObject.parseObject(data.toString(), PageModel.class);
							JSONArray companyArray = data.getJSONArray("list");
							if (companyArray != null || "".equals(companyArray.toString())
									|| companyArray.size() == 0) {
								List<CompanyForOut> companyList = JSON.parseArray(companyArray.toJSONString(),
										CompanyForOut.class);
								page.setList(companyList);
								map.put("page", page);
							} else {
								map.put("mas", "没有查到记录");
							}
						} catch (Exception e) {
							logger.error("错误信息:" + e);
							map.put("mas", "连接失败");
						}
					} else {
						logger.info(resultCode + "-------------------" + reason);
						map.put("mas", reason);
					}
				}		
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("mas", "连接失败");
			}
			return new ModelAndView("companyView/CompanyListPage").addAllObjects(map);
		} else {
			return new ModelAndView("redirect:/login.jsp");
		}
	}

	/**
	 * 加载公司
	 * 
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "null" })
	@RequestMapping(value = "/all.do", method = RequestMethod.GET)
	public String getCompany(int pageNo, int pageSize, Map<String, Object> map, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||getCompany");
		PageModel<CompanyForOut> page = new PageModel<CompanyForOut>();
		page.setPageSize(pageSize);
		page.setPageNo(pageNo);
		page.setObj("");
		OrderRequest or = tu.getOrderRequest(request, response, page);
		if (or != null) {
			// String url =
			// "http://172.16.246.53:20880/dubbo-company/company/ALL";
			try {
				String json = JsonTool.beanTojsonString(or);
				logger.info("传输数据:" + json);
				logger.info("url:" + LHX_URL + Global.FINDCOMPUNYBYPARA);
				if (null != json) {
					String entity = tu.RequestPost(response, json, LHX_URL + Global.FINDCOMPUNYBYPARA);
					logger.info("entity----------------------->:" + entity);
					
					JSONObject httpresult = JSONObject.parseObject(entity);
					String resultCode = httpresult.getString("resultCode");// 状态码
					logger.info("状态码:" + resultCode);
					String reason = httpresult.getString("reason");// 返回信息
					logger.info("返回信息:" + reason);
					System.out.println(reason);
					if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
						String resultInfo = httpresult.getString("resultInfo");// 返回数据
						logger.info("返回数据:" + resultInfo);
						try {
							JSONObject data = (JSONObject) httpresult.get("resultInfo");
							page = JSONObject.parseObject(data.toString(), PageModel.class);
							JSONArray companyArray = data.getJSONArray("list");
							if (companyArray != null || "".equals(companyArray.toString())
									|| companyArray.size() == 0) {
								List<CompanyForOut> companyList = JSON.parseArray(companyArray.toJSONString(),
										CompanyForOut.class);
								page.setList(companyList);
								map.put("page", page);
							} else {
								map.put("mas", "没有查到记录");
							}
						} catch (Exception e) {
							logger.error("错误信息:" + e);
							map.put("mas", "连接失败");
						}
						return "companyView/CompanyList";
					} else {
						logger.info(resultCode + "-------------------" + reason);
						map.put("mas", reason);
					}	
				}
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("mas", "连接失败");
			}
			return "companyView/CompanyList";
		} else {
			return "redirect:/login.jsp";
		}
	}

	/**
	 * 承运商详情
	 * 
	 * @param id
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/detial.do")
	public String detial(String id, Map<String, Object> map, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||detial");
		CompanyForOut company = new CompanyForOut();
		JSONObject obj = new JSONObject();
		obj.put("id", id);
		OrderRequest or = tu.getOrderRequest(request, response, obj);
		if (or != null) {
			try {
				String json = JsonTool.beanTojsonString(obj);
				logger.info("传输数据:" + json);
				String entity = tu.RequestPost(response, json, LHX_URL + Global.FINDCOMPANYBYID);
			
				JSONObject httpresult = JSONObject.parseObject(entity);
				logger.info("=====================================返回结果:" + httpresult.getString("resultInfo"));
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					try {
						JSONObject data = (JSONObject) httpresult.get("resultInfo");
						company = JSONObject.parseObject(data.toString(), CompanyForOut.class);
						if (company != null || "".equals(company)) {
							map.put("company", company);
						} else {
							map.put("company", null);
						}
						return "companyView/Company";
					} catch (Exception e) {
						logger.error("错误信息:" + e);
						return "redirect:/company/all.do?status=-1&&pageNo=1";
					}
				} else {
					return "redirect:/company/all.do?status=-1&&pageNo=1";
				}
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				return "redirect:/company/all.do?status=-1&&pageNo=1";
			}
		} else {
			return "redirect:/login.jsp";
		}
	}

	/**
	 * 修改密码
	 * 
	 * @param company
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/changePass.do", method = RequestMethod.GET)
	public @ResponseBody String changePass(CompanyForOut company, Map<String, Object> map, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||getCompany");
		OrderRequest or = tu.getOrderRequest(request, response, company);
		if (or != null) {
			// String url =
			// "http://172.16.246.53:20880/dubbo-company/company/ALL";
			try {
				String json = JsonTool.beanTojsonString(company);
				logger.info("传输数据:" + json);
				if (null != json) {
					String entity = tu.RequestPost(response, json, LHX_URL + Global.GETCOMPANY_URL);
					
					JSONObject httpresult = JSONObject.parseObject(entity);
					String resultCode = httpresult.getString("resultCode");// 状态码
					logger.info("状态码:" + resultCode);
					String reason = httpresult.getString("reason");// 返回信息
					logger.info("返回信息:" + reason);
					System.out.println(reason);
					if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
						request.getSession().setAttribute("mas", "修改成功");
						// return "redirect:/order/editOrder.do?id=" +
						// company.getId();
					} else {
						logger.info(resultCode + "-------------------" + reason);
						map.put("mas", "公司修改失败");
					}
				}
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("mas", "公司加载失败");
			}
			return JsonTool.beanTojsonString(map);
		} else {
			return "redirect:/login.jsp";
		}
	}

	/**
	 * 修改承运商
	 * 
	 * @param company
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edit(CompanyForOut company, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||editCompany");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = tu.getOrderRequest(request, response, company);
		if (or != null) {
			// String url =
			// "http://172.16.246.53:20880/dubbo-company/company/ALL";
			try {
				String json = JsonTool.beanTojsonString(or);
				logger.info("传输数据:" + json);
				if (null != json) {
					String entity = tu.RequestPost(response, json, LHX_URL + Global.EDITCOMPANY);
				
					JSONObject httpresult = JSONObject.parseObject(entity);
					String resultCode = httpresult.getString("resultCode");// 状态码
					logger.info("状态码:" + resultCode);
					String reason = httpresult.getString("reason");// 返回信息
					logger.info("返回信息:" + reason);
					System.out.println(reason);
					if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
						map.put("mas", "success");
					} else {
						map.put("mas", "error");
					}
				}			
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("mas", "error");
			}
		} else {
			map.put("mas", "login");
		}
		return map;
	}

	/**
	 * 新增承运商
	 * 
	 * @param company
	 * @param map
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addCompany.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addCompany(CompanyForOut company, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||addCompany");
		Map<String, Object> map = new HashMap<String, Object>();
		OrderRequest or = new OrderRequest();
		or = tu.getOrderRequest(request, response, company);
		if (or != null) {
			BackUserForOut user = (BackUserForOut) or.getLoginuser();
			if (user.getUsertype() == 2) {
				try {
					String json = JsonTool.beanTojsonString(or);
					logger.info("=====================================传输数据:" + json);
					if (null != json) {
						String entity = tu.RequestPost(response, json, LHX_URL + Global.ADDCOMPANY);
						
						JSONObject httpresult = JSONObject.parseObject(entity);
						logger.info("=====================================返回结果:" + httpresult.getString("resultInfo"));
						String resultCode = httpresult.getString("resultCode");// 状态码
						logger.info("状态码:" + resultCode);
						String reason = httpresult.getString("reason");// 返回信息
						logger.info("返回信息:" + reason);
						if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
							map.put("mas", "success");
						} else {
							map.put("mas", "error");
						}
					}
				} catch (ConnectException e) {
					logger.error("错误信息:" + e);
					map.put("mas", "error");
				}
			}
		} else {
			map.put("mas", "login");
		}
		return map;
	}

	/**
	 * 停用
	 * 
	 * @param id
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/disableCompany.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> disableCompany(String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||disableCompany");
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
		obj.put("id", id);
		OrderRequest or = tu.getOrderRequest(request, response, obj);
		if (or != null) {
			// String url =
			// "http://172.16.246.53:20880/dubbo-company/company/ALL";
			try {
				String json = JsonTool.beanTojsonString(obj);
				logger.info("传输数据:" + json);
				if (null != json) {
					String entity = tu.RequestPost(response, json, LHX_URL + Global.DISABLECOMPANY);
					
					JSONObject httpresult = JSONObject.parseObject(entity);
					String resultCode = httpresult.getString("resultCode");// 状态码
					logger.info("状态码:" + resultCode);
					String reason = httpresult.getString("reason");// 返回信息
					logger.info("返回信息:" + reason);
					if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
						map.put("mas", "success");
					} else {
						map.put("mas", "error");
					}	
				}
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("mas", "error");
			}
		} else {
			map.put("mas", "login");
		}
		return map;
	}

	/**
	 * 启用
	 * 
	 * @param id
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ableCompany.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> ableCompany(String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("|||||||||||||||||||||||||||||||||||||||ableCompany");
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
		obj.put("id", id);
		OrderRequest or = tu.getOrderRequest(request, response, obj);
		if (or != null) {
			// String url =
			// "http://172.16.246.53:20880/dubbo-company/company/ALL";
			try {
				String json = JsonTool.beanTojsonString(obj);
				logger.info("传输数据:" + json);
				if (null != json) {
					String entity = tu.RequestPost(response, json, LHX_URL + Global.ABLECOMPANY);
					
					JSONObject httpresult = JSONObject.parseObject(entity);
					String resultCode = httpresult.getString("resultCode");// 状态码
					logger.info("状态码:" + resultCode);
					String reason = httpresult.getString("reason");// 返回信息
					logger.info("返回信息:" + reason);
					if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
						map.put("mas", "success");
					} else {
						map.put("mas", "error");
					}
				}	
			} catch (ConnectException e1) {
				logger.error("错误信息:" + e1);
				map.put("mas", "error");
			}
		} else {
			map.put("mas", "login");
		}
		return map;
	}
}
