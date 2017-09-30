package com.ycgwl.kylin.web.report.utils;


import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;

public class CalcUtils {
	
	/**
	 * 避免科学计数法.
	 * @return
	 */
	public static String calcScientficNum(Double num){
		return new BigDecimal(num.toString()).toString();
	}
	
	public static String formatNumber(Double num,int numCount){
		NumberFormat nf = NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(numCount);// 设置小数点后面尾数最大为4
		nf.setMinimumFractionDigits(numCount);// 设置小数点后面尾数最小为4
		return nf.format(num).equals("-0") ? "0.0000" : nf.format(num);
	}

	/**
	 * 计算毛利率.
	 * @param income
	 * @param cost
	 * @return
	 */
	public static Double calcGrossProfitRate(Double income,Double cost,int num){
		Double rate =income>0?(income-cost)/income:0;
		BigDecimal decimal = new BigDecimal(rate);
		double rateDouble = decimal.setScale(num,RoundingMode.HALF_UP).doubleValue();
		return rateDouble;
	}
	
	/**
	 * 保留小数.
	 */
	public static Double calcDecimal(Double date,int decimalNum){
		BigDecimal decimal = new BigDecimal(date);
		return decimal.setScale(decimalNum,RoundingMode.HALF_UP).doubleValue();
	}
}
