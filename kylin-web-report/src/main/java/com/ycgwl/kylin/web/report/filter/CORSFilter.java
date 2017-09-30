package com.ycgwl.kylin.web.report.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CORSFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger(CORSFilter.class);
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("--------------已初始化处理跨域拦截器---------------");
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("--------------进入处理跨域拦截器---------------");
		HttpServletResponse response = (HttpServletResponse) servletResponse; 
		String origin = (String) servletRequest.getRemoteHost() +":"+ servletRequest.getRemotePort(); 
		logger.debug("Origin:{}", origin);
		response.setHeader("Access-Control-Allow-Origin", "*"); 
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE"); 
		response.setHeader("Access-Control-Max-Age", "3600"); 
		response.setHeader("Access-Control-Allow-Headers", "Accept, Origin, XRequestedWith, Content-Type, LastModified, X-Token, X-Request-Type, X-Requested-With"); 
		response.setHeader("Access-Control-Allow-Credentials","true"); 
		chain.doFilter(servletRequest, response);
	}

	@Override
	public void destroy() { 
		System.out.println("--------------已销毁处理跨域拦截器---------------");
	}
}
