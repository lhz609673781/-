package com.ycgwl.kylin.web.report.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSONObject;
import com.para.esc.sdk.oauth.OAuthService;
import com.para.esc.sdk.oauth.utils.OAuthConfigUtil;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.Model.LoginResult;
import ycapp.dbinterface.bean.BackUserForOut;

/**
 * 登录
 * 
 * @author lixiyuan
 *
 */
@Controller
@RequestMapping("/user")
public class UserLoginController extends BaseController {
	private static Logger logger = Logger.getLogger(UserLoginController.class);
	static ToolUtil tu = new ToolUtil();

	
	/****
	 * 
	  * @Description: 注销登录
	  * @return
	  * @exception
	 */
	@RequestMapping("/logout.do")
	public void logout (HttpServletRequest request, HttpServletResponse response) {
		logger.info("------------------------------------------------------------即将注销用户信息");
		request.getSession().invalidate();
		try {
			response.sendRedirect("http://passport.ycgwl.com/logout");
		} catch (IOException e) {
			logger.info("context", e);
		}
		//sso单点登录页面
//		String issuer = "ecp";
//		OAuthConfigUtil oauthConfig = new OAuthConfigUtil(issuer);
//		request.getSession().setAttribute(OAuthConfigUtil.IDP, issuer);
//		OAuthService service = new OAuthService(oauthConfig);
//		if (request.getSession().getAttribute(issuer) == null) {
//			request.getSession().setAttribute(issuer, service);
//		}
//		//sso单点登录页面
//		try {
//			response.sendRedirect(service.getAuthorizationUrl());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	}

	/**
	 * 登录失败
	 * 
	 * @return String
	 */
	@RequestMapping("/index")
	public String index() {
		return "login";
	}

	/**
	 * 登录
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/tmslogin", method = RequestMethod.POST)
	public String tmsLogin(String username, String password, HttpServletRequest request, HttpServletResponse response) {
		logger.info("tmsloginController");
		String reStr = "index"/* "login" */;
		LoginResult loginResult = new LoginResult();// 返回给controller的对象
		BackUserForOut user = new BackUserForOut();
		String url = null;
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			logger.info("用户名或密码为空");
			request.setAttribute("login", "用户名和密码不能为空");
			return reStr;
		} else {
			String json = null;
			url = BaseController.LHX_URL + Global.TMSREPORT_LOGIN;
			user.setAccount(username);
			user.setPassword(password);
			json = JsonTool.beanTojsonString(user);
			try {
				logger.info("=====================================传输数据:" + json);
				String entity = tu.RequestPost(response, json, url);
				logger.info("=====================================entity:" + entity);
			
				JSONObject httpresult = JSONObject.parseObject(entity);
				logger.info("=====================================返回结果:" + httpresult.getString("resultInfo"));
				String resultCode = httpresult.getString("resultCode");// 状态码
				logger.info("状态码:" + resultCode);
				String reason = httpresult.getString("reason");// 返回信息
				logger.info("返回信息:" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					JSONObject data = (JSONObject) httpresult.get("resultInfo");
					Object obj = request.getSession().getAttribute("backuser");
					if (null != obj) {
						request.getSession().removeAttribute("backuser");
					}
					loginResult = JSONObject.parseObject(data.toString(), LoginResult.class);
					request.getSession().setAttribute("backuser", loginResult.getBackUser());
					request.getSession().setAttribute("listName", loginResult.getListName());
					request.getSession().setMaxInactiveInterval(1800);
					reStr = "redirect:/branchData/getfilialeachievement.do";
					return reStr;
				} else {
					logger.info(resultCode + "-------------------" + reason);
					request.setAttribute("login", reason);
					return reStr;
				}
			} catch (Exception e3) {
				e3.printStackTrace();
				request.setAttribute("login", Global.WAIT_A_JIFF);
				return reStr;
			}
		}

	}
}
