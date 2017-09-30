package com.ycgwl.kylin.web.report.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.para.esc.sdk.oauth.OAuthService;
import com.para.esc.sdk.oauth.utils.OAuthConfigUtil;
import com.ycgwl.core.MD5;

public class FilterUser implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("已初始化..");

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;   
		HttpServletResponse resp = (HttpServletResponse) response;
		Object obj = req.getSession().getAttribute("backuser");
		if(obj==null){
//			String signCode = request.getParameter("signCode");
//			if(req.getMethod().equals("post")&&StringUtils.isNotEmpty(signCode)){
//				//TODO 需要增加MD5加密强度
//				String equalSignCode = MD5.sign("kylin_20170817", "akjksjhdhha", "utf-8");
//				if(equalSignCode.equals(signCode)){
//					chain.doFilter(request, response);
//				}
//			}
			if(req.getServletPath().indexOf("callback")!=-1){
				chain.doFilter(request, response);
			}
			String issuer = "ecp";
			OAuthConfigUtil oauthConfig = new OAuthConfigUtil(issuer);
			req.getSession().setAttribute(OAuthConfigUtil.IDP, issuer);
			OAuthService service = new OAuthService(oauthConfig);
			if (req.getSession().getAttribute(issuer) == null) {
				req.getSession().setAttribute(issuer, service);
			}
			//sso单点登录页面
			resp.sendRedirect(service.getAuthorizationUrl());
		}else{
			chain.doFilter(request, response);
		}
	}

	@Override
	public void destroy() {
		System.out.println("已销毁..");

	}

}
