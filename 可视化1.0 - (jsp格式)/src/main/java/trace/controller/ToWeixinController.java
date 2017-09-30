package trace.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.DateUtils;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;

import trace.exception.MessageException;
import ycgwl.track.entity.Waybill;
@Controller
@RequestMapping("/weixin")
public class ToWeixinController extends BaseController{
	private Logger log = Logger.getLogger(ToWeixinController.class);
	@Value("${home_url}")
	private String HOME_URL;
	@Value("${location_url}")
	private String LOCATION_URL;
	@Value("${bindBarCodeURL}")
	private String BINDBARCODEURL;
	@Value("${unload_url}")
	private String UNLOAD_URL;
	@Value("${scanLocationURL}")
	private String SCANLOCATIONURL;
	@Value("${batchLocationURL}")
	private String BATCHLOCATIONURL;
	@Value("${searchBillURL}")
	private String SEARCH_BILL_URL;
	
	@RequestMapping(value="/toPage")
	public String toPage(HttpServletRequest request,HttpServletResponse response,String page)throws Exception{
		log.debug("======init========"+page);
		String bindCode = request.getParameter("bindCode");
		request.getAttribute("barCode");
		if (bindCode!=null) {
			request.setAttribute("bindCode", bindCode);
		}
		String type = request.getParameter("type");
		if ("pc".equals(type)) {
			page="redirect:/index.html";
		}
		return page;
	}
	@RequestMapping(value="/toHome")
	public String toHome(HttpServletRequest request,HttpServletResponse response)throws Exception{
		log.debug("======init========toHome");
		JSONObject json = new JSONObject();
		json.put("id", getSessionUser(request).getId());
		String result = RequestPost(request, response, json.toJSONString(), BINDBARCODEURL);
		if (Global.RIGHT_CODE == JsonTool.getStatus("resultCode", result)) {
			JSONArray jsonArray = JSONObject.parseArray(JsonTool.getObject("resultInfo", result).toString());
			request.setAttribute("list", jsonArray);
			request.setAttribute("count", jsonArray.size());
			log.debug("==============size=================="+jsonArray.size());
			JSONObject httpresult = JSONObject.parseObject(result);
			String resultInfo = httpresult.getString("resultInfo");
			List<Waybill> list = JSONArray.parseArray(resultInfo, Waybill.class);
			if(list.size()>0){
				request.setAttribute("newCreatetime", list.get(0).getCreatetime());
			}
		} else {
			String error = (String) JsonTool.getObject("reason", result);
			throw new MessageException(error);
		}
		return "weixin_home";
	}
	@RequestMapping(value="/toLocationList")
	public String toLocationList(HttpServletRequest request,HttpServletResponse response)throws Exception{
		log.debug("======init========toLocationList");
		JSONObject json = new JSONObject();
		json.put("userid", getSessionUser(request).getId());
		String result = RequestPost(request, response, json.toJSONString(), HOME_URL);
		if (Global.RIGHT_CODE == JsonTool.getStatus("resultCode", result)) {
			JSONArray jsonArray = JSONObject.parseArray(JsonTool.getObject("resultInfo", result).toString());
			request.setAttribute("list", jsonArray);
			int Count=0;
			for(int i=0;i<jsonArray.size();i++){
				JSONObject jo= (JSONObject) jsonArray.get(i);
				int s= jo.getInteger("status");
				if(s==1){
					Count++;
				}
			}
			request.setAttribute("count", Count);
			log.debug("==============size=================="+jsonArray.size());
		} else {
			String error = (String) JsonTool.getObject("reason", result);
			throw new MessageException(error);
		}
		return "position";
	}
	
	
	@RequestMapping(value="/moreLocationList",method = RequestMethod.POST)
	public String moreLocationList(@RequestParam String param,HttpServletRequest request,HttpServletResponse response)throws Exception{
		log.debug("======init========moreLocationList");
		JSONObject json;int status=0;
		if(StringUtils.isEmpty(param)){
			json = new JSONObject();
		}else{
			json = JSONObject.parseObject(param);
			status=json.getIntValue("status");
		}
		json.put("userid", getSessionUser(request).getId());
		String result = RequestPost(request, response, json.toJSONString(), LOCATION_URL);
		
		List<Waybill> UnLoadingList = null;
		if(status!=2){//如果是非卸货选项，查出所有卸货的，为其设置一个卸货标志位
			json.put("status", 2);
			String resultUnLoading = RequestPost(request, response, json.toJSONString(), LOCATION_URL);
			JSONArray UnLoadingArray = JSONObject.parseArray(JsonTool.getObject("resultInfo", resultUnLoading).toString());
			UnLoadingList = JSONArray.parseArray(UnLoadingArray.toJSONString(), Waybill.class);
		}
		if (Global.RIGHT_CODE == JsonTool.getStatus("resultCode", result)) {
			JSONArray jsonArray = JSONObject.parseArray(JsonTool.getObject("resultInfo", result).toString());
			JSONArray itemArrays = new JSONArray();
			int intransit_count=0;int unloading_count=0;
			if(jsonArray!=null && jsonArray.size()>0){
				for (Object object : jsonArray) {
					JSONObject jsonBase = (JSONObject) object;
					jsonBase.put("createtime", DateUtils.getDate(jsonBase.getLong("createtime")));
					if(status==2){//已卸货
						unloading_count++;
					}else {//全部或运输中
						intransit_count++;
					}
					itemArrays.add(jsonBase);
				}
			}
			
			List<Waybill> itemList = JSONArray.parseArray(itemArrays.toJSONString(), Waybill.class);
			Map<Integer,Boolean> unloadingMap = new HashMap<Integer,Boolean>();
			if(status!=2){//如果是非卸货选项，查出所有卸货的，为其设置一个卸货标志位
				for (int i = 0; i < UnLoadingList.size(); i++) {
					unloadingMap.put(UnLoadingList.get(i).getId(), true);
				}
			}else{//如果是卸货的，为所有数据加卸货标志位
				for (int i = 0; i < itemList.size(); i++) {
					unloadingMap.put(itemList.get(i).getId(), true);
				}
			}
			
			request.setAttribute("items", MergeTheSameDate(itemList));
			request.setAttribute("unloadingMap", unloadingMap);
			request.setAttribute("intransit_count", intransit_count);
			request.setAttribute("unloading_count", unloading_count);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			if(!StringUtils.isEmpty(param)){
				request.setAttribute("createtime", json.getString("createtime"));
			}
			if(!StringUtils.isEmpty(param)){
				request.setAttribute("status",status);//回显选项卡状态
				request.setAttribute("searchData",json.getString("searchData"));//回显选项卡状态
			}
		} else {
			String error = (String) JsonTool.getObject("reason", result);
			throw new MessageException(error);
		}
		return "positionList";
	}
	
	@RequestMapping(value="/toUpload",method=RequestMethod.POST)
	public @ResponseBody JSONObject toUpload(@RequestParam String param,HttpServletRequest request,HttpServletResponse response)throws Exception{
		log.debug("======init========toUpload");
		JSONObject json;
		if(StringUtils.isEmpty(param)){
			json = new JSONObject();
		}else{
			json = JSONObject.parseObject(param);
		}
		json.put("userid", getSessionUser(request).getId());
		String result = RequestPost(request, response, json.toJSONString(), UNLOAD_URL);
		if(request==null){
			throw new MessageException(Global.SYSTEM_ERROR);
		}
		try {
			json = JSONObject.parseObject(result);
			if(Global.RIGHT_CODE==json.getIntValue("resultCode")){
				request.getSession().removeAttribute("waybillid");
				request.getSession().removeAttribute("userId");
				request.getSession().removeAttribute("orderSummary");
				request.getSession().removeAttribute("barCode");
			}
			return json;
		} catch (Exception e) {
			log.debug(e.getMessage());
			throw new MessageException(e.getMessage());
		}
	}
	/**
	 * 扫描上传位置
	 * @author djq
	 * @date 2017年6月9日  
	 * @param param
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/uploadPosition",method=RequestMethod.POST)
	public @ResponseBody JSONObject uploadPosition(@RequestParam String param,HttpServletRequest request,HttpServletResponse response)throws Exception{
		log.debug("======init========toUpload"+param);
		//清除放在session中的定位临时数据
		request.getSession().removeAttribute("waybill");//任务单实体
		request.getSession().removeAttribute("userId");//用户id
		request.getSession().removeAttribute("subscribe");//用户关注公众状态
		//如果该司机的该单已经卸货，该司机就不能定位
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("status", 2);//卸货标志位
		jsonobj.put("userid", getSessionUser(request).getId());
		jsonobj.put("searchData", JSONObject.parseObject(param).get("barCode"));
		String resultUnLoading = RequestPost(request, response, jsonobj.toJSONString(), LOCATION_URL);
		JSONArray UnLoadingArray = JSONObject.parseArray(JsonTool.getObject("resultInfo", resultUnLoading).toString());
		List<Waybill> UnLoadingList = JSONArray.parseArray(UnLoadingArray.toJSONString(), Waybill.class);
		if(UnLoadingList.size()>0){
			//说明该司机该任务单是卸货状态，此时不能定位
			return JSONObject.parseObject(JsonTool.toJsonObject(Global.PARAM_CODE, Global.WAYBILL_ALL_RIGHT_UPLOAD));
		}
		
		if(StringUtils.isEmpty(param)){
			return JSONObject.parseObject(JsonTool.toJsonObject(Global.PARAM_CODE, Global.PARAMS_ERROR));
		}
		String result = RequestPost(request, response,param, SCANLOCATIONURL);
		log.debug("======uploadPosition:result==========>"+result);
		if(request==null){
			return JSONObject.parseObject(JsonTool.toJsonObject(Global.WRONG_CODE, Global.SYSTEM_ERROR));
		}
		try {
			JSONObject json = JSONObject.parseObject(result);
			return json;
		} catch (Exception e) {
			log.debug(e.getMessage());
			throw new MessageException(e.getMessage());
		}
	}
	/**
	 * 批量上传位置
	 * @param param
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/batchUploadPosition",method=RequestMethod.POST)
	public @ResponseBody JSONObject batchUploadPosition(@RequestParam String param,HttpServletRequest request,HttpServletResponse response)throws Exception{
		log.debug("======init========batchUploadPosition"+param);
		if(StringUtils.isEmpty(param)){
			throw new MessageException(Global.PARAMS_ERROR);
		}
		String result = RequestPost(request, response,param, BATCHLOCATIONURL);
		log.debug("======batchUploadPosition:result==========>"+result);
		if(request==null){
			throw new MessageException(Global.SYSTEM_ERROR);
		}
		try {
			return JSONObject.parseObject(result);
		} catch (Exception e) {
			log.debug(e.getMessage());
			throw new MessageException(e.getMessage());
		}
	}
	
	/**
	 * 处理List中相同日期的数据，然后放置在key相同的map中
	 * @author zyg
	 * @return 合并后的Map集合
	 * @param 需要合并日期的List集合
	 * */
	private Map<String, List<Waybill>> MergeTheSameDate(List<Waybill> waybills) {
		Map<String,List<Waybill>> sameDateMap = new TreeMap<String,List<Waybill>>(
		    new Comparator<String>() {
		        public int compare(String obj1, String obj2) {
		            // 降序排序
		            return obj2.compareTo(obj1);
		        }
		    });
		Waybill wb=null;String dateKey;
		List<Waybill> itemList=null;
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0;i<waybills.size();i++){
			wb=waybills.get(i);
			if(wb.getNumOfREPORT()!=null){//判断上传次数是否大于999,如果大于显示999+
				if(wb.getNumOfREPORT()>Global.INTNUM_REPORT){
					wb.setNumOfReport(Global.INTNUM_REPORT+"+");
				}else{
					wb.setNumOfReport(wb.getNumOfREPORT().toString());
				}
			}
			//将日期作为map的key，相同日期的数据放在同一key下的list中
			dateKey=sdf.format(wb.getCreatetime());
			if(sameDateMap.get(dateKey)!=null){
				itemList=sameDateMap.get(dateKey);
				itemList.add(wb);
				sameDateMap.put(dateKey, itemList);
			}else{
				itemList=new ArrayList<Waybill>();
				itemList.add(wb);
				sameDateMap.put(dateKey, itemList);
			}
		}
		return sameDateMap;
	}
	
	@RequestMapping(value="/searchmoreLocationList")
	public String searchmoreLocationList(String searchData,HttpServletRequest request,HttpServletResponse response)throws Exception{
		log.debug("======init========searchmoreLocationList");
		JSONObject  json = new JSONObject();
		json.put("userid", getSessionUser(request).getId());
		json.put("searchData", searchData);
		String result = RequestPost(request, response, json.toJSONString(), SEARCH_BILL_URL);
		if (Global.RIGHT_CODE == JsonTool.getStatus("resultCode", result)) {
			List<Waybill> itemList = JSONArray.parseArray(JsonTool.getObject("resultInfo", result).toString(), Waybill.class);
			request.setAttribute("items", MergeTheSameDate(itemList));
		} else {
			String error = (String) JsonTool.getObject("reason", result);
			throw new MessageException(error);
		}
		request.setAttribute("searchData", searchData);
		return "searchpositionList";
	}
}
