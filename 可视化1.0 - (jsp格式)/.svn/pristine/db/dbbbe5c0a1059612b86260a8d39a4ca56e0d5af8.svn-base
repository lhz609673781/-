package trace.order.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.core.RequestUtil;
import com.ycgwl.util.StringUtils;

import trace.controller.BaseController;
import trace.exception.MessageException;
import ycgwl.track.entity.GroupMembers;
import ycgwl.track.entity.Outbill;
import ycgwl.track.entity.User;

/**
 * 送货单控制层
 * @author 29556
 */

@Controller
@RequestMapping("/outBill")
public class OutBillController extends BaseController{
	private static Logger logger = Logger.getLogger(OutBillController.class);
	
	@Value("${OutBillImpExcelURL}")
	private String OUTBILL_IMP_EXCEL_URL;
	@Value("${outBillGetListByGroupId}")
	private String OUTBILL_GETLIST_URL;
	@Value("${outBillUpdate}")
	private String OUTBILL_UPDATE_URL;
	
	/**
	 * 跳转送货单列表
	 */
	@RequestMapping(value = "/outbill")
	public String outBill(Model model, HttpServletRequest request,HttpServletResponse response) throws Exception{
		JSONObject paramJson = new JSONObject();
		User user = getSessionUser(request);
		if(null != user){
			paramJson.put("userId", user.getId());
			paramJson.put("pageNum",1);
			paramJson.put("pageSize", 10);
		}
		return getListByGroupId(model, paramJson.toJSONString(), request, response);
	}
	
	/**
	 * @author:113076
	 * @info:导入excel
	 * @time:2017-6-5
	 * */
	@RequestMapping(value="/saveImpExcel",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveImpExcel(Model model,HttpServletRequest request,@RequestParam MultipartFile impExcel,String groupId,HttpServletResponse response)throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		Integer userId=getSessionUser(request).getId();
//		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
//		// 获得文件：
//       MultipartFile impExcel = multipartRequest.getFile("impExcel");
        CommonsMultipartFile cf= (CommonsMultipartFile)impExcel;
        DiskFileItem fi = (DiskFileItem)cf.getFileItem();
        File targetFile = fi.getStoreLocation();
        //将MultipartFile转换为File
      	List<File> files = new ArrayList<File>();
      	files.add(targetFile);
      	//封装excel请求参数
        Map<String,String> paraMap = new HashMap<String,String>();
        paraMap.put("userid", userId+"");
        paraMap.put("groupId", groupId);
		String json = JSONObject.toJSONString(paraMap);
		logger.info("---传输数据：---" + json);
        String entity = MultiPartRequestPost(OUTBILL_IMP_EXCEL_URL, files, json);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        map.put("success", true);
        map.put("code", resultCode);
        map.put("msg", reason);
		return map;
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/getListByGroupId",method=RequestMethod.POST)
	public String getListByGroupId(Model model,String param,HttpServletRequest request,HttpServletResponse response) throws Exception{
		if(StringUtils.isEmpty(param)){
			logger.debug("param is null");
			throw new MessageException(Global.QUERY_FAIL);
		}
		logger.debug("param=================>"+param);
		String result = RequestUtil.requestPost(param,OUTBILL_GETLIST_URL);
		if(StringUtils.isNotEmpty(result)){
			logger.debug("result=================>"+result);
			int resultCode = JsonTool.getStatus("resultCode", result);// 状态码
			String reason = JsonTool.getObject("reason", result).toString();// 返回信息
			if(resultCode==Global.RIGHT_CODE){
				JSONObject resultInfo = JsonTool.getJSON("resultInfo", result);
				String pageInfoStr = resultInfo.getString("pageInfo");
				if(StringUtils.isNotEmpty(pageInfoStr)){
					PageInfo<Outbill> pageInfo = JSONObject.parseObject(pageInfoStr, PageInfo.class);
					model.addAttribute("pageInfo", pageInfo);
					logger.debug("pageInfo=================>"+pageInfoStr);
				}
				String groupListStr = resultInfo.getString("groupList");
				if(StringUtils.isNotEmpty(groupListStr)){
					List<GroupMembers> groupMembersList = JSON.parseArray(groupListStr, GroupMembers.class);
					model.addAttribute("groupList", groupMembersList);
					logger.debug("groupListStr=================>"+groupListStr);
				}
				model.addAttribute("userId",  getSessionUser(request).getId());
			}
		}else{
			logger.debug("reuslt is null");
			throw new MessageException(Global.QUERY_FAIL);
		}
		return "outbill/outBillList";
	}
	
	 /**
	  * 编辑界面填充
	  * @param customerId
	  * @param param
	  * @param model
	  * @param request
	  * @param response
	  * @return
	  * @throws Exception
	  */
    @RequestMapping(value = "toEditOutBill",method = RequestMethod.POST)
    public String toEditCustom(int customerId,String param,Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        //回显outBill
        model.addAttribute("outBill", param);
        return "outBillInfo";
    }
    
    /**
     * 送货详情修改
     * @param outbill
     * @param model
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "editOutBill",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject editCustom(Outbill outbill,Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	String result =null;
//    	int resultCode = JsonTool.getStatus("resultCode", result);// 状态码
//		String reason = JsonTool.getObject("reason", result).toString();// 返回信息
		return JSON.parseObject(result);
    }
}
