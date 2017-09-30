package trace.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;

/**
 * 
 * @author lt 添加任务单信息
 *
 * 		@Value("${customerByIdURL}") private String CUSTOMER_BYID_URL;
 *
 */

@Controller
public class BarCodeController extends BaseController {

	@Value("${TwoDimensionalCodeBindingURL}") // 扫码绑定的接口路径
	private String TWO_DIMENSIONAL_CODE_BINDING_URL;
	@Value("${checkBarcodeURL}") // 是否可以绑定的接口路径
	private String CHECK_CODE_URL;
	@Value("${batchLocationURL}")
	private String BATCHLOCATIONURL;//保存定位坐标
	@Value("${wayBillBindCustomerURL}")//订单绑定用户
	private String WAYBILL_BIND_CUSTOMER_URL;

	// 扫码完成以后需要先去录单页面(此处的页面申请路径是录单页面weixin/toAddBarCode)
	@RequestMapping(value = "/weixin/toAddBarCode")
	public String toAddBarCode(HttpServletRequest request,
			Model model) {
		String barCode = request.getParameter("bindCode");
		if(StringUtils.isNotEmpty(barCode)){
			request.setAttribute("bindCode", barCode);
		}
		return "barCodeAfter";
	}
	// 点击确定以后跳转到二维码绑定页面
	@RequestMapping(value = "/weixin/addBarCode", method = RequestMethod.POST)
	public String addBarCode(String deliveryNumber,String weight,String volume,String number,String barcode, String orderSummary, String customerid,HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		logger.debug("=========================开始时间========"+System.currentTimeMillis());
		if (StringUtils.isNotEmpty(barcode)) {
			// 绑定的处理
			String latitude = request.getParameter("latitude");
			String longitude = request.getParameter("longitude");
			String locations = request.getParameter("locations");
			JSONObject jsonbcode = new JSONObject();//添加绑定条码
			jsonbcode.put("wbarcode", barcode);
			jsonbcode.put("customerid", customerid);
			jsonbcode.put("weight", weight);
			jsonbcode.put("volume", volume);
			jsonbcode.put("number", number);
			jsonbcode.put("deliveryNumber", deliveryNumber);
			jsonbcode.put("orderSummary", orderSummary);
			jsonbcode.put("userid", getSessionUser(request).getId());
			jsonbcode.put("latitude", latitude);
			jsonbcode.put("longitude",longitude);
			jsonbcode.put("locations", locations);

			logger.debug("--------" + jsonbcode + "---------------------");
			String res = RequestPost(request, response, jsonbcode.toJSONString(), TWO_DIMENSIONAL_CODE_BINDING_URL);
			
			JSONObject httpresult = JSONObject.parseObject(res);
			
			int resultCode = httpresult.getInteger("resultCode");// 状态码
			
			logger.info("---状态码：---" + resultCode);
			String reason = httpresult.getString("reason");// 返回信息
			logger.info(resultCode + "-------------------" + reason);
			if (Global.RIGHT_CODE == resultCode) {//200
				return "redirect:/weixin/toHome.html";
			} else if (Global.PARAM_CODE == resultCode) {
				// 绑定失败的操作
				model.addAttribute("error", reason);
				return toAddBarCode(request,model);
			} else {
				// 处理9999
				model.addAttribute("error", reason);
				return toAddBarCode(request,model);
			}
		}else{
			model.addAttribute("error", Global.PARAMS_ERROR);
			return toAddBarCode(request,model);
		}
	}

	/**
	 * @throws IOException
	 * @throws HttpException
	 * @throws UnsupportedEncodingException
	 * @date 2017年6月1日
	 * @see ajax验证二维码
	 */
	@RequestMapping("/weixin/barcodeVerifyAjax")
	@ResponseBody
	public Integer barcodeVerify(String barcode, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		JSONObject json = new JSONObject();
		if (StringUtils.isNotEmpty(barcode)) {   
			json.put("barcode", barcode);
			json.put("resourceid", getSessionUser(request).getId());
			String result = RequestPost(request, response, json.toJSONString(), CHECK_CODE_URL);
			if (StringUtils.isNotEmpty(result)) {
				int resultCode = JsonTool.getStatus("resultCode", result);
				String reason = JsonTool.getObject("reason", result).toString();
				if(reason!=null &&"非法参数".equals(reason)){
					resultCode =500;
				}
				return resultCode;
			}
		}
		return 0;
	}
}
