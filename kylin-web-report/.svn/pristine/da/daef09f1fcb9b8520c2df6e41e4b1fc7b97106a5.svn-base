package com.ycgwl.kylin.web.report.utils;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import ycapp.Model.ExcelForm;

/**
 * 
 * @Description: excel导出工具.
 * @author <a href="mailto:109668@ycgwl.com">lihuixia</a>
 * @date 2017年8月15日 上午10:25:02
 * @version 1.3
 *
 */
public class ExcelReportUtils {
	/**
	 * 
	 * @Description: 一句话描述做了什么 @author
	 *               <a href="mailto:109668@ycgwl.com">zhangqianqian</a> @date
	 *               2017年8月15日 上午10:25:02 @param excelForm @param
	 *               response @throws Exception @exception
	 */
	public static void exportExcel(ExcelForm excelForm, HttpServletResponse response) throws Exception {
		SimpleDateFormat sbf = new SimpleDateFormat("yyMMddHHmmss");
		response.reset();
		response.setContentType("application/x-msdownload;charset=UTF-8");
		String fileName = java.net.URLEncoder.encode(excelForm.getFileName(), "UTF-8") + "(" + sbf.format(new Date())
				+ ")";
		response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xlsx");
		OutputStream os = response.getOutputStream();
		// 创建工作文档对象
		org.apache.poi.ss.usermodel.Workbook book = new XSSFWorkbook();
		// 创建sheet对象
		org.apache.poi.ss.usermodel.Sheet wsheet = (org.apache.poi.ss.usermodel.Sheet) book
				.createSheet(excelForm.getSheetName());
		detailContent(excelForm, wsheet, book);
		book.write(os);
		os.flush();
		// book.close();
		// os.close();
	}

	/**
	 * 根据传入的数据生成excel.
	 * 
	 * @param list
	 * @param book
	 * @param wsheet
	 * @param contentName
	 * @param headerName
	 */
	public static void detailContent(ExcelForm excelForm, Sheet wsheet, Workbook book) throws Exception {
		int titleRow = 0;
		if (excelForm.getTotal() != null) {
			titleRow = titleRow + 2;
			createTitle(excelForm, wsheet, book);
		}

		if (excelForm.getImplParam() != null) {
			titleRow = titleRow + 1;
			createSubTitle(excelForm, wsheet, book);
		}
		
		org.apache.poi.ss.usermodel.Row row = (org.apache.poi.ss.usermodel.Row) wsheet.createRow(0 + titleRow);

		// 循环写入列标题
		String showName[] = excelForm.getShowColumnName();
		for (int i = 0; i < showName.length; i++) {
			row.createCell(i).setCellValue(showName[i]);
		}
		// 设置列宽
		Integer columnWidth[] = excelForm.getShowColumnWidth();
		for (int i = 0; i < columnWidth.length; i++) {
			wsheet.setColumnWidth(i, columnWidth[i] * 256);
		}
		List<String[]> list = excelForm.getList();
		for (int i = 0; i < list.size(); i++) {
			String rowDetail[] = list.get(i);
			row = (org.apache.poi.ss.usermodel.Row) wsheet.createRow(i + titleRow + 1);
			for (int j = 0; j < rowDetail.length; j++) {// 每行数据是一个对象
				row.createCell(j).setCellValue(rowDetail[j]);
			}
		}
	}

	/**
	 * 
	 * @Description: 增加第一行大标题
	 * @param excelForm
	 * @param wsheet
	 * @param book
	 * @exception @author
	 *                <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月15日 上午10:38:05
	 * @version 需求对应版本号
	 */
	private static void createTitle(ExcelForm excelForm, Sheet wsheet, Workbook book) {
		org.apache.poi.ss.usermodel.Row title = (org.apache.poi.ss.usermodel.Row) wsheet.createRow(0);

		wsheet.addMergedRegion(new CellRangeAddress(0, 1, 0, excelForm.getShowColumnName().length - 1));

		Cell titleCell = title.createCell(0);
		titleCell.setCellValue(excelForm.getTotal());

		CellStyle createCellStyle = book.createCellStyle();
		createCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		Font createFont = book.createFont();
		createFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		createFont.setFontName("黑体");
		createFont.setFontHeightInPoints((short) 20);
		createCellStyle.setFont(createFont);
		titleCell.setCellStyle(createCellStyle);
	}

	/**
	 * 
	 * @Description: 增加第二行大标题
	 * @param excelForm
	 * @param wsheet
	 * @param book
	 * @exception 
	 * @author <a href="mailto:87111@ycgwl.com">zhangqianqian</a>
	 * @date 2017年8月15日 上午10:38:05
	 * @version 需求对应版本号
	 */
	private static void createSubTitle(ExcelForm excelForm, Sheet wsheet, Workbook book) {
		int firstRow = 0;
		if (excelForm.getTotal() != null) {
			firstRow = 2;
		}
		org.apache.poi.ss.usermodel.Row title = (org.apache.poi.ss.usermodel.Row) wsheet.createRow(firstRow);
		wsheet.addMergedRegion(new CellRangeAddress(firstRow, firstRow, 0, excelForm.getShowColumnName().length - 1));

		Cell titleCell = title.createCell(0);
		titleCell.setCellValue(excelForm.getImplParam());

		CellStyle createCellStyle = book.createCellStyle();
		createCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		Font createFont = book.createFont();
		createFont.setFontName("黑体");
		createFont.setFontHeightInPoints((short) 16);
		createCellStyle.setFont(createFont);
		titleCell.setCellStyle(createCellStyle);
	}

	/**
	 * 导出报表excel.
	 * 
	 * @param headerName
	 * @param contentName
	 */
	@Deprecated
	public static void exportExcelBack(ExcelForm excelForm, HttpServletResponse response) throws Exception {
		SimpleDateFormat sbf = new SimpleDateFormat("yyMMddHHmmss");
		response.reset();
		response.setContentType("application/x-msdownload;charset=UTF-8");
		String fileName = java.net.URLEncoder.encode(excelForm.getFileName(), "UTF-8") + "(" + sbf.format(new Date())
				+ ")";
		response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xlsx");
		OutputStream os = response.getOutputStream();
		// 创建工作文档对象
		org.apache.poi.ss.usermodel.Workbook book = new XSSFWorkbook();
		// 创建sheet对象
		org.apache.poi.ss.usermodel.Sheet wsheet = (org.apache.poi.ss.usermodel.Sheet) book
				.createSheet(excelForm.getSheetName());
		detailContent(excelForm, wsheet, book);
		book.write(os);
		os.flush();
		// book.close();
		// os.close();
	}

	/**
	 * 根据传入的数据生成excel.
	 * 
	 * @param list
	 * @param book
	 * @param wsheet
	 * @param contentName
	 * @param headerName
	 */
	@Deprecated
	public static void detailContentBack(ExcelForm excelForm, Sheet wsheet, Workbook book) throws Exception {
		org.apache.poi.ss.usermodel.Row row = (org.apache.poi.ss.usermodel.Row) wsheet.createRow(0);

		// 循环写入列标题
		String showName[] = excelForm.getShowColumnName();
		for (int i = 0; i < showName.length; i++) {
			row.createCell(i).setCellValue(showName[i]);
		}
		// 设置列宽
		Integer columnWidth[] = excelForm.getShowColumnWidth();
		for (int i = 0; i < columnWidth.length; i++) {
			wsheet.setColumnWidth(i, columnWidth[i] * 256);
		}
		List<String[]> list = excelForm.getList();
		for (int i = 0; i < list.size(); i++) {
			String rowDetail[] = list.get(i);
			row = (org.apache.poi.ss.usermodel.Row) wsheet.createRow(i + 1);
			for (int j = 0; j < rowDetail.length; j++) {// 每行数据是一个对象
				row.createCell(j).setCellValue(rowDetail[j]);
			}
		}
	}
}
