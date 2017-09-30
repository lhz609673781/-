package com.ycgwl.kylin.web.report.utils;

import java.security.interfaces.ECKey;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

public class DateUtils {

	public static void main(String agrs[]) {
		System.out.print(getDayCountOfMonth(2017, 2));
	}

	public static String getCurrMonth() {
		Calendar rightNow = Calendar.getInstance();
		return new SimpleDateFormat("M").format(rightNow.getTime());
	}

	public static String getCurrYear() {
		Calendar rightNow = Calendar.getInstance();
		return new SimpleDateFormat("yyyy").format(rightNow.getTime());
	}

	public static String toFirstDayOfMonth(String date) {
		if (StringUtils.isBlank(date)) {
			return firstDateOfCurrMonth();
		} else if (date.length() < 10) {
			String dateStr[] = date.split("-");
			if (dateStr[1].length() < 2) {
				dateStr[1] = "0" + dateStr[1];
			}
			if (dateStr[2].length() < 2) {
				dateStr[2] = "0" + dateStr[2];
			}
			return dateStr[0] + "-" + dateStr[1] + "-" + dateStr[2];
		}
		return date;
	}

	public static String toYesterDayOfMonth(String date) {
		if (StringUtils.isBlank(date)) {
			return yesterday();
		} else if (date.length() < 10) {
			String dateStr[] = date.split("-");
			if (dateStr[1].length() < 2) {
				dateStr[1] = "0" + dateStr[1];
			}
			if (dateStr[2].length() < 2) {
				dateStr[2] = "0" + dateStr[2];
			}
			return dateStr[0] + "-" + dateStr[1] + "-" + dateStr[2];
		}
		return date;
	}

	/**
	 * 获取本月1号的日期. return 日期：yyyy-MM-dd.
	 */
	public static String firstDateOfCurrMonth() {
		SimpleDateFormat sbf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar rightNow = Calendar.getInstance();
		rightNow.add(Calendar.MONTH, 0);
		rightNow.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		String firstDateOfMonth = sbf.format(rightNow.getTime());
		return firstDateOfMonth;
	}

	public static String yesterday() {
		SimpleDateFormat sbf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar rightNow = Calendar.getInstance();
		rightNow.add(Calendar.DATE, -1);
		String yestday = sbf.format(rightNow.getTime());
		return yestday;
	}

	/**
	 * 月份-1
	 */
	public static String monthTerday() {
		SimpleDateFormat sbf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar rightNow = Calendar.getInstance();
		rightNow.add(Calendar.DATE, -1);
		rightNow.add(Calendar.MONTH, -1);
		String result = sbf.format(rightNow.getTime());
		return result;
	}

	public static int getDayCountOfMonth(Integer year, Integer month) {
		LocalDate today = LocalDate.of(year, month, 1);
		LocalDate lastDayOfMonth = today.with(TemporalAdjusters.lastDayOfMonth());
		return lastDayOfMonth.getDayOfMonth();
	}

	/**
	 * 当前上月一号
	 * <p>
	 * 
	 * @developer Create by <a href="mailto:86756@ycgwl.com">yanxf</a> at
	 *            2017年9月1日
	 * @return
	 */
	public static String firstDateOfTerdayMonth() {
		SimpleDateFormat sbf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar rightNow = Calendar.getInstance();
		rightNow.add(Calendar.MONTH, -1);
		rightNow.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		String firstDateOfTerdayMonth = sbf.format(rightNow.getTime());
		return firstDateOfTerdayMonth;
	}

	/**
	 * 
	  * @Description: 去除yyyy-MM-dd 中的 -dd 直接取出年月
	  * @param date
	  * @return
	  * @exception
	  * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	  * @date 2017年9月8日 下午1:57:31
	  * @version 2.0
	 */
	public static String getYearMonth(String date) {
		if (date != null && date.length() > 7) {
			return date.substring(0, 7);
		} else {
			return date;
		}
	}
	
	/**
	 * 获取当前字符串日期前一年并转换为yyyy-MM-dd字符串格式
	 */
	public static String getLastYear(String now) {
		SimpleDateFormat sbf = new SimpleDateFormat("yyyy-MM-dd");
		String result = "";
		try {
			Date date = sbf.parse(now);
			Calendar rightNow = Calendar.getInstance();
			rightNow.setTime(date);	
			rightNow.add(Calendar.YEAR, -1);
			result = sbf.format(rightNow.getTime());	
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	public static String getLastMonth(String now) {
		SimpleDateFormat sbf = new SimpleDateFormat("yyyy-MM");
		String result = "";
		try {
			Date date = sbf.parse(now);
			Calendar rightNow = Calendar.getInstance();
			rightNow.setTime(date);	
			rightNow.add(Calendar.YEAR, -1);
			result = sbf.format(rightNow.getTime());	
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/**
	 * 
	  * @Description: date日期转 yyyy-MM-dd字符串日期
	  * @return
	  * @exception
	  * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	  * @date 2017年9月18日 上午11:18:08
	  * @version 2.0
	 */
	public static String getDateString(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = sdf.format(date);
		return dateStr;
	}
	
}
