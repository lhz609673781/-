package com.ycgwl.kylin.web.report.controller;

import java.io.InputStream;
import java.util.Properties;

public class BaseController {

	public static String LHX_URL;

	static {
		Properties prop = new Properties();
		InputStream in = BaseController.class.getResourceAsStream("/url.properties");
		try {
			prop.load(in);
			LHX_URL = prop.getProperty("LHX_URL");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String getLHX_URL() {
		return LHX_URL;
	}

	public static void setLHX_URL(String lHX_URL) {
		LHX_URL = lHX_URL;
	}

}
