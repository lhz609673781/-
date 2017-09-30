package com.ycgwl.kylin.web.report.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.ycgwl.kylin.web.report.domain.ExportError;
import com.ycgwl.kylin.web.report.domain.OrderRequest;
import com.ycgwl.kylin.web.report.domain.TopList;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import net.sf.json.JSONObject;
import ycapp.Model.BindCusTomerAndDivisionModel;
import ycapp.Model.BranchCondition;
import ycapp.Model.DateModel;
import ycapp.Model.DayReport;
import ycapp.Model.MonthReport;
import ycapp.Model.ResultsSummary;
import ycapp.Model.TurnoverModel;
import ycapp.Model.WeekReport;
import ycapp.dbinterface.bean.BackUserForOut;
import ycapp.dbinterface.bean.CompanyForOut;

/**
 * 工具类
 *
 * @author lixiyuan
 *
 */
public class ToolUtil {
	private static Logger logger = Logger.getLogger(ToolUtil.class);
	final String charSet = "UTF-8";

	/**
	 * 判断是否为空.
	 */
	public static boolean isEmpty(String str) {
		if ("null".equals(str) || "undefined".equals(str) || StringUtils.isEmpty(str)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 连接服务
	 *
	 * @param response
	 * @param json
	 * @param url
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 * @throws HttpException
	 */
	public String RequestPost(HttpServletResponse response, String json, String url)
			throws UnsupportedEncodingException, IOException, HttpException {
		HttpClient httpClient = new HttpClient();
		final PostMethod postMethod = new PostMethod(url);
		postMethod.getParams().setContentCharset(charSet);
		postMethod.addRequestHeader("Content-Type", "application/json; charset=UTF-8");
		StringRequestEntity requestEntity = new StringRequestEntity(json.toString(), "application/json", charSet);
		postMethod.setRequestEntity(requestEntity);
		httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 20000);
		httpClient.executeMethod(postMethod);
		logger.info(response + "-------------------" + response);
		String entity = postMethod.getResponseBodyAsString();
		return entity;
	}

	/**
	 * 判断登录状态
	 *
	 * @param request
	 * @param response
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	public OrderRequest getOrderRequest(HttpServletRequest request, HttpServletResponse response, Object obj)
			throws Exception {
		OrderRequest or = null;
		BackUserForOut user = new BackUserForOut();
		if (request.getSession().getAttribute("user") != null && request.getSession().getAttribute("user") != "") {
			or = new OrderRequest();
			user = (BackUserForOut) request.getSession().getAttribute("user");
			or.setLoginuser(user);
			or.setRole("1");
			if (obj == null) {
				or.setData("");
			} else {
				or.setData(obj);
			}
		} else {
			or = null;
		}
		return or;
	}

	/***
	 * 描述：进行非空判断和业务判断
	 *
	 * @param limap
	 * @param codeNumber
	 * @return
	 */
	public Map<String, Object> provingCodeNumber(Map<String, Object> limap, String codeNumber) {

		// 判断参数是否为空
		if (codeNumber == null || codeNumber.length() <= 0) {
			limap.put("mas", "参数为空");
			return limap;
		}
		// 判断参数是否是数字
		for (int i = codeNumber.length(); --i >= 0;) {
			if (!Character.isDigit(codeNumber.charAt(i))) {
				limap.put("mas", "参数不是数字");
				return limap;
			}
		}
		// 判断参数是否超出或者小于规定的数量（业务判断）
		int number = Integer.parseInt(codeNumber);
		if (number > 1000 || number < 1) {
			limap.put("mas", "参数不合法");
			return limap;
		}
		return limap;
	}

	public CompanyForOut getCompany(String name, String contacts, String phone, long status) {
		CompanyForOut company = new CompanyForOut();
		try {
			if (status != -1) {
				company.setStatus(status);
			}
			if (name != "" && name != null && !"undefined".equals(name)) {
				name = URLDecoder.decode(name, "UTF-8");
				company.setName(name);

			}
			if (contacts != "" && contacts != null && !"undefined".equals(contacts)) {
				contacts = URLDecoder.decode(contacts, "UTF-8");
				company.setContacts(contacts);
			}
			if (phone != "" && phone != null && !"undefined".equals(phone)) {
				company.setPhone(phone);
			}
			company.setId(null);
		} catch (Exception e) {
			logger.error("错误信息:" + e);
		}
		if (name == null && contacts == null && phone == null && company.getStatus() == null) {
			company = null;
		}
		if (name == "" && contacts == "" && phone == "" && company.getStatus() == null) {
			company = null;
		}
		if ("undefined".equals(name) && "undefined".equals(contacts) && "undefined".equals(phone)
				&& "undefined".equals(status)) {
			company = null;
		}
		return company;
	}

	/**
	 * 销售指标导入
	 *
	 * @return
	 */
	public ExportError menagementXlsLead(MultipartFile file, HttpServletResponse response, HttpServletRequest request) {
		ExportError ee = new ExportError();
		List<TurnoverModel> tlist = new ArrayList<TurnoverModel>();
		try {
			// Workbook.getWorkbook方法接受文件流，file.getInputStream()得到文件流
			Workbook book = Workbook.getWorkbook(file.getInputStream());
			// 读取第一个工作区
			Sheet sheet = book.getSheet(0);
			// 得到工作区总行数
			int rows = sheet.getRows();
			// 读取每一行对应的列数目
			int columns = sheet.getColumns();
			for (int i = 1; i < rows; i++) {
				List<String> list = new ArrayList<String>();
				for (int j = 0; j < columns; j++) {
					// 得到具体第几行第几列
					Cell cell = sheet.getCell(j, i);
					String result = cell.getContents();
					list.add(result);
				}
				TurnoverModel t = new TurnoverModel();
				t.setYear("2017");
				if (null != list.get(0).trim()) {
					t.setName(list.get(0).trim());
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "分公司或事业部不能为空");
					ee.setData(tlist);
					break;
				}
				Pattern pattern = Pattern.compile("^[+-]?[0-9]+$");
				if (null != list.get(2).trim()) {
					if (pattern.matcher(list.get(2)).matches() == true) {
						t.setOneMonthIndex(list.get(2).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "1月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "1月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(3).trim()) {
					if (pattern.matcher(list.get(3)).matches() == true) {
						t.setTwoMonthIndex(list.get(3).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "2月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "2月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(4).trim()) {
					if (pattern.matcher(list.get(4)).matches() == true) {
						t.setThreeMonthIndex(list.get(4).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "3月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "3月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(5).trim()) {
					if (pattern.matcher(list.get(5)).matches() == true) {
						t.setFourMonthIndex(list.get(5).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "4月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "4月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(6).trim()) {
					if (pattern.matcher(list.get(6)).matches() == true) {
						t.setFiveMonthIndex(list.get(6).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "5月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "5月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(7).trim()) {
					if (pattern.matcher(list.get(7)).matches() == true) {
						t.setSixMonthIndex(list.get(7).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "6月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "6月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(8).trim()) {
					if (pattern.matcher(list.get(8)).matches() == true) {
						t.setSevenMonthIndex(list.get(8).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "7月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "7月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(9).trim()) {
					if (pattern.matcher(list.get(9)).matches() == true) {
						t.setEightMonthIndex(list.get(9).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "8月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "8月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(10).trim()) {
					if (pattern.matcher(list.get(10)).matches() == true) {
						t.setNineMonthIndex(list.get(10).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "9月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "9月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(11).trim()) {
					if (pattern.matcher(list.get(11)).matches() == true) {
						t.setTenMonthIndex(list.get(11).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "10月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "10月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(12).trim()) {
					if (pattern.matcher(list.get(12)).matches() == true) {
						t.setElevenMonthIndex(list.get(12).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "11月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "11月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				if (null != list.get(13).trim()) {
					if (pattern.matcher(list.get(13)).matches() == true) {
						t.setTwelveMonthIndex(list.get(13).trim());
					} else {
						tlist = null;
						ee.setError("第" + (i + 1) + "行" + "12月销售指标必须是数字");
						ee.setData(tlist);
						break;
					}
				} else {
					tlist = null;
					ee.setError("第" + (i + 1) + "行" + "12月销售指标不能为空");
					ee.setData(tlist);
					break;
				}
				tlist.add(t);
				ee.setData(tlist);
			}
		} catch (Exception e) {
			tlist = null;
			ee.setError("读取Excel失败");
			ee.setData(tlist);
			logger.error("错误信息:" + e);
		}
		return ee;
	}

	/**
	 * 事业部关联客户导入
	 * 
	 * @param file
	 * @param response
	 * @param request
	 * @return
	 */
	public ExportError cognateCustXlsLead(MultipartFile file, HttpServletResponse response,
			HttpServletRequest request) {
		ExportError ee = new ExportError();
		List<BindCusTomerAndDivisionModel> btaList = new ArrayList<BindCusTomerAndDivisionModel>();
		try {
			// Workbook.getWorkbook方法接受文件流，file.getInputStream()得到文件流
			Workbook book = Workbook.getWorkbook(file.getInputStream());
			// 读取第一个工作区
			Sheet sheet = book.getSheet(0);
			// 得到工作区总行数
			int rows = sheet.getRows();
			// 读取每一行对应的列数目
			int columns = sheet.getColumns();
			for (int i = 1; i < rows; i++) {
				List<String> list = new ArrayList<String>();
				BindCusTomerAndDivisionModel bta = new BindCusTomerAndDivisionModel();
				for (int j = 0; j < columns; j++) {
					// 得到具体第几行第几列
					Cell cell = sheet.getCell(j, i);
					String result = cell.getContents();
					list.add(result);
				}
				if (null != list.get(0).trim() && StringUtils.isNotEmpty(list.get(0).trim())) {
					// bta.setCustomerIdGroupId(list.get(0).trim());
					bta.setCustomerIdGroupId(list.get(0).trim());
				} else {
					btaList = null;
					ee.setError("第" + (i + 1) + "行" + "客户ID不能为空");
					ee.setData(btaList);
					break;
				}
				if (null != list.get(1).trim() && StringUtils.isNotEmpty(list.get(1).trim())) {
					bta.setComputerName(list.get(1).trim());
				} else {
					btaList = null;
					ee.setError("第" + (i + 1) + "行" + "代码不能为空");
					ee.setData(btaList);
					break;
				}
				// if (null != list.get(2).trim()) {
				// bta.setBindDivision(list.get(2).trim());
				// } else {
				// btaList = null;
				// ee.setError("第" + (i + 1) + "行" + "事业部不能为空");
				// ee.setData(btaList);
				// break;
				// }
				if (null != list.get(4).trim() && StringUtils.isNotEmpty(list.get(4).trim())) {
					bta.setCustomerType(list.get(4).trim());
				} else {
					btaList = null;
					ee.setError("第" + (i + 1) + "行" + "客户类型不能为空");
					ee.setData(btaList);
					break;
				}

				btaList.add(bta);
				ee.setData(btaList);
			}
		} catch (Exception e) {
			btaList = null;
			ee.setError("读取Excel失败");
			ee.setData(btaList);
			logger.error("错误信息:" + e);
		}
		return ee;
	}

	/**
	 * 分公司销售业绩导出
	 *
	 * @return
	 */
	public void exportAnnualAlerts(List<MonthReport> monthReportList, DateModel dateModel,
			HttpServletResponse response) {
		String[] row1 = { "物流集团", "36789", "0.151", "10679", "0.331", "6826", "6826", "0.751", "0.121" };// 指定列名
		String[] row2 = { " ", "物流集团年度指标", dateModel.getYear() + "销售", "年度完成率", dateModel.getMonth() + "月指标", "第三周销售",
				"第三周完成率", "20日销售", "20日完成率" };// 指定列名
		short cellNumber1 = (short) row1.length;// 表的列数
		short cellNumber2 = (short) row2.length;// 表的列数
		HSSFWorkbook workbook = new HSSFWorkbook(); // 创建一个excel
		HSSFCell cell = null; // Excel的列
		HSSFRow row = null; // Excel的行
		HSSFCellStyle style = workbook.createCellStyle(); // 设置表头的类型
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFCellStyle style1 = workbook.createCellStyle(); // 设置数据类型
		style1.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFFont font = workbook.createFont(); // 设置字体
		HSSFSheet sheet = workbook.createSheet("sheet1"); // 创建一个sheet

		try {
			if (monthReportList.size() < 1) {
				row = sheet.createRow(0);
				row.setHeight((short) 400);
				cell = row.createCell(0);
				cell.setCellValue("暂无数据");
			} else {
				row = sheet.createRow(0);
				row.setHeight((short) 400);
				for (int j = 0; j < cellNumber1; j++) {
					cell = row.createCell(j);// 创建第0行第k列
					cell.setCellValue(row1[j]);// 设置第0行第k列的值
					sheet.setColumnWidth(j, 4000);// 设置列的宽度
					font.setColor(HSSFFont.COLOR_NORMAL); // 设置单元格字体的颜色.
					font.setFontHeight((short) 300); // 设置单元字体高度
					font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
					style1.setFont(font);// 设置字体风格
					cell.setCellStyle(style1);
				}
				row = sheet.createRow(1);
				row.setHeight((short) 400);
				for (int a = 0; a < cellNumber2; a++) {
					cell = row.createCell(a);// 创建第0行第k列
					cell.setCellValue(row2[a]);// 设置第0行第k列的值
					sheet.setColumnWidth(a, 4000);// 设置列的宽度
					font.setColor(HSSFFont.COLOR_NORMAL); // 设置单元格字体的颜色.
					font.setFontHeight((short) 300); // 设置单元字体高度
					font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
					style1.setFont(font);// 设置字体风格
					cell.setCellStyle(style1);
				}
				List<String> row3 = new ArrayList<String>();
				row3.add("部门");
				row3.add("年销售指标");
				row3.add("年销售额");
				row3.add("年完成率(%)");

				row3.add(dateModel.getMonth() + "月销售指标");
				row3.add(dateModel.getMonth() + "月销售");
				row3.add("完成率(%)");
				row3.add("完成率排名");

				row3.add("第一周指标");
				row3.add("第一周销售");
				row3.add("完成率(%)");

				row3.add("第二周指标");
				row3.add("第二周销售");
				row3.add("完成率(%)");

				row3.add("第三周指标");
				row3.add("第三周销售");
				row3.add("完成率(%)");

				row3.add("第四周指标");
				row3.add("第四周销售");
				row3.add("完成率(%)");

				if (monthReportList.get(0).getDayReport().size() > 0) {
					for (int i = 0; i < monthReportList.get(0).getDayReport().size(); i++) {
						row3.add((i + 1) + "号销售指标");
						row3.add((i + 1) + "号销售");
						row3.add("完成率(%)");
					}
				}

				row = sheet.createRow(2);
				row.setHeight((short) 400);
				for (int b = 0; b < row3.size(); b++) {
					cell = row.createCell(b);// 创建第0行第k列
					cell.setCellValue(row3.get(b));// 设置第0行第k列的值
					sheet.setColumnWidth(b, 4000);// 设置列的宽度
					font.setColor(HSSFFont.COLOR_NORMAL); // 设置单元格字体的颜色.
					font.setFontHeight((short) 300); // 设置单元字体高度
					font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
					style1.setFont(font);// 设置字体风格
					cell.setCellStyle(style1);
				}
				for (int i = 0; i < monthReportList.size(); i++) {
					row = sheet.createRow((short) (i + 3));// 创建第i+1行
					row.setHeight((short) 400);// 设置行高
					MonthReport monthReport = monthReportList.get(i);
					// 部门
					if (null != monthReport.getName()) {
						cell = row.createCell(0);// 创建第i+1行第1列
						cell.setCellValue(monthReport.getName());// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					}

					// 年指标
					if (null != monthReport.getYearIndex()) {
						cell = row.createCell(1);// 创建第i+1行第1列
						cell.setCellValue(monthReport.getYearIndex());// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					}

					// 年销售
					if (null != monthReport.getHaveSales()) {
						cell = row.createCell(2);// 创建第i+1行第1列
						cell.setCellValue(monthReport.getHaveSales());// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					}

					// 年完成率
					if (null != monthReport.getYearCompletion()) {
						cell = row.createCell(3);// 创建第i+1行第1列
						cell.setCellValue(monthReport.getYearCompletion());// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					}

					// 月销售指标
					if (null != monthReport.getMonthIndex()) {
						cell = row.createCell(4);// 创建第i+1行第1列
						cell.setCellValue(monthReport.getMonthIndex());// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					}

					// 月销售
					if (null != monthReport.getMonthSales()) {
						cell = row.createCell(5);// 创建第i+1行第1列
						cell.setCellValue(monthReport.getMonthSales());// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					}

					// 完成率
					if (null != monthReport.getMonthCompletion()) {
						cell = row.createCell(6);// 创建第i+1行第1列
						cell.setCellValue(monthReport.getMonthCompletion());// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					}

					// 完成率排名
					if (i < 5) {
						cell = row.createCell(7);// 创建第i+1行第1列
						cell.setCellValue(i + 1);// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
					} else {
						int a = 5;
						cell = row.createCell(7);// 创建第i+1行第1列
						cell.setCellValue(a);// 设置第i+1行第0列的值
						cell.setCellStyle(style);// 设置风格
						a = a - 1;
					}
					int z = 0;
					for (int j = 0; j < monthReport.getWeekReport().size(); j++) {
						WeekReport week = monthReport.getWeekReport().get(j);
						// 周指标
						if (null != week.getWeekIndex()) {
							cell = row.createCell(8 + z);// 创建第i+1行第1列
							cell.setCellValue(week.getWeekIndex());// 设置第i+1行第0列的值
							cell.setCellStyle(style);// 设置风格
							z = z + 1;
						}

						// 周销售
						if (null != week.getHaveSales()) {
							cell = row.createCell(8 + z);// 创建第i+1行第1列
							cell.setCellValue(week.getHaveSales());// 设置第i+1行第0列的值
							cell.setCellStyle(style);// 设置风格
							z = z + 1;
						}

						// 周完成率
						if (null != week.getWeekCompletion()) {
							cell = row.createCell(8 + z);// 创建第i+1行第1列
							cell.setCellValue(week.getWeekCompletion());// 设置第i+1行第0列的值
							cell.setCellStyle(style);// 设置风格
							z = z + 1;
						}
					}
					int a = 20;
					if (monthReportList.get(i).getDayReport().size() > 0) {
						for (int x = 0; x < monthReportList.get(i).getDayReport().size(); x++) {
							DayReport day = monthReportList.get(i).getDayReport().get(x);

							// 日指标
							if (null != day.getDayIndex()) {
								cell = row.createCell(a);// 创建第i+1行第1列
								cell.setCellValue(day.getDayIndex());// 设置第i+1行第0列的值
								cell.setCellStyle(style);// 设置风格
								a = a + 1;
							}

							// 日销售
							if (null != day.getDaySales()) {
								cell = row.createCell(a);// 创建第i+1行第1列
								cell.setCellValue(day.getDaySales());// 设置第i+1行第0列的值
								cell.setCellStyle(style);// 设置风格
								a = a + 1;
							}

							// 日完成率
							if (null != day.getDayCompletion()) {
								cell = row.createCell(a);// 创建第i+1行第1列
								cell.setCellValue(day.getDayCompletion());// 设置第i+1行第0列的值
								cell.setCellStyle(style);// 设置风格
								a = a + 1;
							}
						}
					}
				}

			}
		} catch (Exception e) {
			logger.error("错误信息:" + e);
		}
		OutputStream out = null;// 创建一个输出流对象
		try {
			out = response.getOutputStream();
			String headerStr = dateModel.getYear() + "年" + dateModel.getMonth() + "月销售业绩汇总";
			headerStr = new String(headerStr.getBytes("gb2312"), "ISO8859-1");// headerString为中文时转码
			response.setHeader("Content-disposition", "attachment; filename=" + headerStr + ".xls");// filename是下载的xls的名，建议最好用英文
			response.setContentType("application/msexcel;charset=UTF-8");// 设置类型
			response.setHeader("Pragma", "No-cache");// 设置头
			response.setHeader("Cache-Control", "no-cache");// 设置头
			response.setDateHeader("Expires", 0);// 设置日期头
			workbook.write(out);
			out.flush();
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/***
	 * 对ResultsSummary添加属性值并排序
	 * 
	 * @param list1
	 * @param list2
	 */
	public static void resultSummaryUtil(List<ResultsSummary> list1) {
		for (int i = 0; i < list1.size(); i++) {
			if (null != list1.get(i).getSalesIndicators() && null != list1.get(i).getSales()) {
				Double olddiff = list1.get(i).getSalesIndicators() - list1.get(i).getSales();
				Double newdiff = olddiff >= 0.0 ? olddiff : 0.0;
				list1.get(i).setDifference(newdiff);
			}
		}

		int length = list1.size();
		for (int i = 0; i < length - 1; i++) {
			for (int j = 0; j < length - i - 1; j++) {// 内部循环的边界要比长度小一
				if (null == (list1.get(j).getCompletion())) {
					list1.get(j).setCompletion(0.0);
				}
				if (null == (list1.get(j + 1).getCompletion())) {
					list1.get(j + 1).setCompletion(0.0);
				}
				if (list1.get(j).getCompletion() < list1.get(j + 1).getCompletion()) {
					swapResultsSummary(j, j + 1, list1);// 相邻的两个元素比较，将小的放到最右边
				}

			}
		}
	}

	/**
	 * 把两个对象交换位置（ResultsSummary）
	 */
	public static void swapResultsSummary(int oneIndex, int anotherIndex, List<ResultsSummary> list) {
		ResultsSummary esultsSummary = list.get(oneIndex);
		list.set(oneIndex, list.get(anotherIndex));
		list.set(anotherIndex, esultsSummary);
	}

	public static TopList branchConditionUtil(List<BranchCondition> list1) {
		TopList topList = new TopList();
		List<BranchCondition> branchConditionlist1 = new ArrayList<BranchCondition>();
		List<BranchCondition> branchConditionlist2 = new ArrayList<BranchCondition>();
		int length = list1.size();
		for (int i = 0; i < length - 1; i++) {
			for (int j = 0; j < length - i - 1; j++) {// 内部循环的边界要比长度小一
				if (null == (list1.get(j).getMonthCompletion())) {
					list1.get(j).setMonthCompletion(0.0);
				}
				if (null == (list1.get(j + 1).getMonthCompletion())) {
					list1.get(j + 1).setMonthCompletion(0.0);
				}
				if (list1.get(j).getMonthCompletion() < list1.get(j + 1).getMonthCompletion()) {
					swapBranchCondition(j, j + 1, list1);// 相邻的两个元素比较，将小的放到最右边
				}

			}
		}
		int i = list1.size();
		if (i > 0) { // 集合长度大于0时,先循环第一个list（正序的排名）

			if (i > 5) { // 集合长度大于5，需要遍历集合前五和后五条数据
				for (int y = 0; y < 5; y++) {
					branchConditionlist1.add(list1.get(y));
				}
				for (int y = i - 1; y > i - 6; y--) {
					branchConditionlist2.add(list1.get(y));
				}
			} else {// 集合长度小于5，
				for (int y = 0; y < i; y++) {
					branchConditionlist1.add(list1.get(y));
				}
				for (int y = i - 1; y > -1; y--) {
					branchConditionlist2.add(list1.get(y));
				}
			}
		}

		topList.setBralist1(branchConditionlist1);
		topList.setBralist2(branchConditionlist2);
		return topList;
	}

	/**
	 * 装换分公司名称
	 * 
	 * @param topList
	 * @return
	 */
	public static TopList<BranchCondition> CityToProvince(TopList<BranchCondition> topList) {
		Map<String, String> mapCity = getCity();
		for (int i = 0; i < topList.getBralist1().size(); i++) {
			String province = mapCity.get(topList.getBralist1().get(i).getBranchName());
			if (null != province) {
				topList.getBralist1().get(i).setBranchName(province);
			}
		}
		for (int i = 0; i < topList.getBralist2().size(); i++) {
			String province = mapCity.get(topList.getBralist2().get(i).getBranchName());
			if (null != province) {
				topList.getBralist2().get(i).setBranchName(province);
			}
		}
		return topList;
	}

	/**
	 * 把两个对象交换位置（BranchCondition）
	 */
	public static void swapBranchCondition(int oneIndex, int anotherIndex, List<BranchCondition> list) {
		if (list.size() > 0) {
			BranchCondition branchCondition = list.get(oneIndex);
			list.set(oneIndex, list.get(anotherIndex));
			list.set(anotherIndex, branchCondition);
		}
	}

	/**
	 * 根据年和月获取天数
	 * 
	 * @param year
	 * @param month
	 * @return
	 */
	public static int getDay(int year, int month) {
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, year); // 年
		c.set(Calendar.MONTH, month - 1); // 比如是7月，应该输入6
		int daysOfMonth = c.getActualMaximum(Calendar.DAY_OF_MONTH);// 该月有多少天

		return daysOfMonth;
	}

	/**
	 * 根据天获取周
	 * 
	 * @param intday
	 * @return
	 */
	public static int getWeek(int intday) {
		boolean b = false;
		String day = String.valueOf(intday);
		String[] firstWeek = new String[] { "1", "2", "3", "4", "5", "6", "7" };
		String[] secondWeek = new String[] { "8", "9", "10", "11", "12", "13", "14" };
		String[] thirdWeek = new String[] { "15", "16", "17", "18", "19", "20", "21" };
		for (String s : firstWeek) {
			if (s.equals(day)) {
				b = true;
				break;
			}
		}
		if (b) {
			return 1;
		}
		for (String s : secondWeek) {
			if (s.equals(day)) {
				b = true;
				break;
			}
		}
		if (b) {
			return 2;
		}
		for (String s : thirdWeek) {
			if (s.equals(day)) {
				b = true;
				break;
			}
		}
		if (b) {
			return 3;
		}
		return 4;
	}

	public static Map<String, String> getCity() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("石家庄", "河北");
		map.put("济南", "山东");
		map.put("郑州", "河南");
		map.put("呼和浩特", "内蒙古");
		map.put("太原", "山西");
		map.put("成都", "四川");
		map.put("昆明", "云南");
		map.put("贵阳", "贵州");
		map.put("广州", "广东");
		map.put("南宁", "广西");
		map.put("福州", "福建");
		map.put("武汉", "湖北");
		map.put("南昌", "江西");
		map.put("长沙", "湖南");
		map.put("杭州", "浙江");
		map.put("南京", "江苏");
		map.put("合肥", "安徽");
		map.put("哈尔滨", "黑龙江");
		map.put("长春", "吉林");
		map.put("沈阳", "辽宁");
		map.put("西安", "陕西");
		map.put("兰州", "甘肃");
		map.put("银川", "宁夏");
		map.put("西宁", "青海");
		map.put("乌鲁木齐", "新疆");
		return map;
	}

	public static Map parserToMap(String s) {
		Map map = new HashMap();
		JSONObject json = JSONObject.fromObject(s);
		Iterator keys = json.keys();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			String value = json.get(key).toString();
			if (value.startsWith("{") && value.endsWith("}")) {
				map.put(key, parserToMap(value));
			} else {
				map.put(key, value);
			}

		}
		return map;
	}

	/**
	 * 下载模板，保存成excel
	 * 
	 * @param request
	 * @param response
	 */
	public void downXls(HttpServletRequest request, HttpServletResponse response, String type) {
		String nametype = "";
		String fileName = "";
		if (type.equals("1")) {
			nametype = "/custModel.xls";
			fileName = "平台客户导入模板.xls";
		} else if (type.equals("2")) {
			nametype = "/salesIndexModel.xls";
			fileName = "销售指标导入模板.xls";
		}
		response.setContentType("application/msexcel");// 下载东西的格式
		response.setHeader("Content-disposition",
				"attachment;fileName=" + MyFileUtils.encodeDownloadFilename(fileName, request.getHeader("user-agent")));
		try {
			InputStream in = ToolUtil.class.getClassLoader().getResourceAsStream(nametype);
			java.io.OutputStream os = response.getOutputStream();
			byte[] b = new byte[1024];
			int len = 0;
			while ((len = in.read(b)) != -1) {
				os.write(b, 0, len);
			}
			os.flush();
			os.close();
			in.close();
		} catch (Exception e) {
			logger.error("错误信息:" + e);
		}
	}

	/**
	 * 获取本月1号的日期. return 日期：yyyy-MM-dd
	 * 
	 * @return
	 */
	public static String firstDateOfCurrMonth() {
		SimpleDateFormat sbf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar rightNow = Calendar.getInstance();
		rightNow.add(Calendar.MONTH, 0);
		rightNow.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		String firstDateOfMonth = sbf.format(rightNow.getTime());
		return firstDateOfMonth;
	}

}
