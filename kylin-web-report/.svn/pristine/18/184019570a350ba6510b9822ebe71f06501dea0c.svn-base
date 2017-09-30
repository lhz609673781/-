package com.ycgwl.kylin.web.report.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.para.esc.sdk.oauth.OAuthService;
import com.para.esc.sdk.oauth.client.model.UserInfo;
import com.para.esc.sdk.oauth.exceptions.OAuthApiException;
import com.para.esc.sdk.oauth.model.Token;
import com.para.esc.sdk.oauth.utils.OAuthConfigUtil;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.kylin.web.report.utils.ToolUtil;

import ycapp.dbinterface.bean.BackUserForOut;

/**
 * 单点登录回调处理.
 * 1.拿到授权码
 * 2.获取用户信息
 */
@Controller
public class LoginCallbackController extends BaseController {
	
	/***
	 * 回调方法.
	 */
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callBack(HttpServletRequest request, HttpServletResponse response) throws OAuthApiException,Exception{
		OAuthService service = null;
		String issuer = "ecp";
		if (request.getSession().getAttribute(issuer) != null) {
			service = (OAuthService) request.getSession().getAttribute(issuer);
		} else {
			OAuthConfigUtil oauthConfig = new OAuthConfigUtil(issuer);
			service = new OAuthService(oauthConfig);
			request.getSession().setAttribute(issuer, service);
		}

		String code = request.getParameter("code");
		//获取token
		Token accessToken = service.getAccessToken(code);
		//获取用户信息
		try {
			UserInfo user_ = new UserInfo(accessToken);
			UserInfo user = user_.requestUserInfo(service.getUserinfoUrl());
			if (user != null) {
				ToolUtil curr = new ToolUtil();
				String entity = curr.RequestPost(response, user.getId(), LHX_URL + Global.REPORT_LOGIN);
			
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
//					String reason = httpresult.getString("reason");// 返回信息
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");// 返回对象
					JSONObject resultInfoJson = JSONObject.parseObject(resultInfo);
					String backUser= resultInfoJson.getString("backUser");
					BackUserForOut backUserForOut = JSONObject.parseObject(backUser,BackUserForOut.class);
					request.getSession().setAttribute("backuser",backUserForOut);
				}else{
					request.getSession().removeAttribute("backuser");
					throw new ServletException("账户:"+user.getId()+"不存在，请联系管理员创建账户",new Exception());
				}
			}	
		} catch (OAuthApiException e) {
			e.printStackTrace();
			throw new ServletException(e.getErrorMsg(),e);
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("系统异常",e);
		}
		return "redirect:/branchData/getfilialeachievement.do?navId=1";
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}
}
