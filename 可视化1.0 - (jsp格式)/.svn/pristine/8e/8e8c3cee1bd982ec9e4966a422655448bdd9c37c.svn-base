package trace.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.httpclient.HttpException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.weixin.sdk.api.AccessTokenApi;
import com.ycgwl.core.DateUtils;
import com.ycgwl.core.Global;
import com.ycgwl.util.FileConstant;
import com.ycgwl.util.StatusUtils;

import trace.exception.MessageException;
import trace.util.WeiXinUtils;
import trace.util.WxConstant;
import ycgwl.track.entity.Address;
import ycgwl.track.entity.ExceptionRepor;
import ycgwl.track.entity.Receipt;
import ycgwl.track.entity.Track;
import ycgwl.track.entity.User;
import ycgwl.track.entity.Waybill;

/**
 * 
 * 任务单的控制层
 * @author 29556
 */

@Controller
public class WayBillController extends BaseController{
	@Value("${ExceptionUploaddingURL}")
	private String ExceptionUploaddingURL;
	
	@Value("${ReceiptUploaddingURL}")
	private String ReceiptUploaddingURL;
	
	@Value("${uploadImgURL}")
	private String UPLOAD_IMG_URL;
	
	@Value("${wayBillByIdURL}")
	private String WAYBILL_BYID_URL;
	
	@Value("${ImagePath}")
	private String IMAGE_PATH;
	
	@Value("${waybill_wx_url}")
	private String WAYBILL_LIST_URL;

	@Value("${group_waybill_url}")
	private String GROUP_WAYBILL_URL;
	
	@Value("${wayBillDetailShareURL}")
	private String WAYBILL_DETAIL_SHARE_URL;
	
	@Value("${resourceGroup_check_url}")
	private String RESOURCEGEOUP_CHECK_URL;
	
	@Value("${waybill_search_list_url}")
	private String WAYBILL_SEARCH_LIST_URL;
	
	@Value("${wayBillDetailShareQueryURL}")
	private String WAYBILL_SEARCH_QUERY_URL;
	
	@Value("${getWaybillURL}")
	private String GET_WAYBILL_URL;
	
	@Value("${getWaybillIdURL}")
	private String GET_WAYBILLID_URL;
	
	@Value("${queryGroupURL}")
	private String QUERY_GROUP_URL;
	
	//任务单详情页面到异常的页面
	@RequestMapping(value="weixin/ToWaybillDetail")
	public String ToWaybillDetail(Model model,Integer wayBillId,String shareId,Integer status,String groupName,
			HttpServletRequest request,HttpServletResponse response) throws Exception{
		this.getwayBillInfo(model, wayBillId, shareId, status,groupName, request, response);
		return "/wx/myTask/myTaskDetails";
	}	
	
	//任务单详情
	public void getwayBillInfo(Model model,Integer wayBillId,String shareId,Integer status,String groupName,HttpServletRequest request,HttpServletResponse response) throws Exception{
		logger.info("---分享人shareId数据：---" + shareId);
		//wayBillId为空就抛错
				if(wayBillId==null){
					throw new MessageException(Global.QUERY_FAIL);
				}
				int userId=getSessionUser(request).getId();
				model.addAttribute("userId", userId);
				String entity,json = "";
				Waybill waybill = new Waybill();
				if(com.ycgwl.util.StringUtils.isNotEmpty(shareId) && Integer.valueOf(shareId) != userId){
					//如果是分享过来的，那么能看到的就是分享人能看到的信息
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("waybillid", wayBillId);
					jsonObject.put("acceptid", userId);
					jsonObject.put("shareid", shareId);
					json = jsonObject.toJSONString();
					logger.info("---传输数据分享：---" + json);
					entity = RequestPost(request, response, json, WAYBILL_SEARCH_QUERY_URL);
				}else{
					//通过任务单id拿到任务单的详细信息、任务单下的所有回单信息、异常上报信息
					waybill.setId(wayBillId);
					waybill.setUserid(userId);
					waybill.setStatus(status);
					json = JSONObject.toJSONString(waybill);
					logger.info("---传输数据：---" + json);
					entity = RequestPost(request, response, json, WAYBILL_BYID_URL);
				}
				JSONObject httpresult = JSONObject.parseObject(entity);
				String resultCode = httpresult.getString("resultCode");// 状态码
				String reason = httpresult.getString("reason");// 返回信息
				logger.info(resultCode + "------------" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					String resultInfo = httpresult.getString("resultInfo");
					logger.info("---返回信息：---" + resultInfo);
					waybill = JSONObject.parseObject(resultInfo, Waybill.class);
					//不知为什么，接口的返回信息中异常上报和回单只会显示第一个用户的信息
					model.addAttribute("wayBillId",wayBillId);//任务单id
					if(com.ycgwl.util.StringUtils.isNotEmpty(shareId) && null==waybill.getType()){
						waybill.setType(StatusUtils.WAYBILL_TYPE_SHARE);
					}
					model.addAttribute("waybill",waybill);//任务单
					model.addAttribute("barCodeEntity", waybill.getBarcode());//任务单号对象
					model.addAttribute("customer", waybill.getCustomer());//收货人
					model.addAttribute("orderSummary", waybill.getOrderSummary());//任务摘要
					if(CollectionUtils.isNotEmpty(waybill.getExceptionRepor())) {
						model.addAttribute("exceptionRepor", waybill.getExceptionRepor());//异常上报列表
					}
					if(CollectionUtils.isNotEmpty(waybill.getReceipts())) {
						model.addAttribute("receipts", waybill.getReceipts());//回单信息列表
					}
					model.addAttribute("receiptNumber", waybill.getReceipts().size());//回单数
					model.addAttribute("createtime", waybill.getCreatetime());//任务单创建日期
					model.addAttribute("createtimestr", DateUtils.date2Str(waybill.getCreatetime()));//任务单创建日期
					model.addAttribute("imagePath",IMAGE_PATH);//图片服务器的路径
					if(status!=null){
						model.addAttribute("groupName", groupName);
					}
					if(waybill.getTracks()!=null&&waybill.getTracks().size()>0){
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
						model.addAttribute("scanDateTime",sdf.format(waybill.getTracks().get(0).getCreatetime()));//最新定位时间
						model.addAttribute("track",waybill.getTracks().get(0));//最新轨迹坐标
						model.addAttribute("address", waybill.getAddress());//最新地址
						
						//将所有轨迹拼接成“12.32,32.32|21.23,53.23|...”的字符串形式，在前端进行解析
						List<Track> trackList = waybill.getTracks();
						String tracksJson = JSON.toJSONString(trackList);
						model.addAttribute("trackList", tracksJson);//所有轨迹拼接
					}
					
					//查询一下该用户是否是该任务单资源组的成员，取标识符返回给页面（控制确认收货按钮）
					boolean resultFlag = false;
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("barcode", waybill.getBarcode().getBarcode());
					jsonObject.put("resourceid", userId);
					json = JSONObject.toJSONString(jsonObject);
					logger.info("---传输数据：---" + json);
					entity = RequestPost(request, response, json, RESOURCEGEOUP_CHECK_URL);
					httpresult = JSONObject.parseObject(entity);
					resultCode = httpresult.getString("resultCode");// 状态码
					reason = httpresult.getString("reason");// 返回信息
					logger.info(resultCode + "------------" + reason);
					if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
						resultInfo = httpresult.getString("resultInfo");
						logger.info("---返回信息：---" + resultInfo);
						String flag = JSONObject.parseObject(resultInfo,String.class);
						resultFlag = Boolean.parseBoolean(flag);
					}
					model.addAttribute("isGroupMermer",resultFlag);//是否是该任务单的组员
					if(shareId!=null){
						//回显分享Id
						model.addAttribute("shareId",shareId);
					}
				}
	}
	
	//异常上报页面跳转
	@RequestMapping(value="weixin/ExceptionUp")
	public String ExceptionUp(Model model,String wayBillId,String shareId){
		
		logger.info("---异常上传页面跳转成功：---" + wayBillId);
		model.addAttribute("wayBillId", wayBillId);//任务单号
		if(shareId!=null){
			//回显分享Id
			model.addAttribute("shareId",shareId);
		}
		return "abnormal";
	}
	
	
	
	//上传回单页面跳转
	//type不为空且为1则是上传选择任务来上传图片
	@RequestMapping(value="weixin/ReceiptUp")
	public String ReceiptUp(Model model,String wayBillId,String shareId,String flag,String code,HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, HttpException, IOException, ParseException{
		logger.info("---回单上传页面跳转成功：---" + wayBillId);
		if(com.ycgwl.util.StringUtils.isNotEmpty(code)){
			this.getWayBillCode(code, model, request, response);
		}else{
			model.addAttribute("wayBillId", wayBillId);//任务单号id
			if(shareId!=null){
				//回显分享Id
				model.addAttribute("shareId",shareId);
			}
			if(com.ycgwl.util.StringUtils.isNotEmpty(wayBillId)){
				this.getWayBill(wayBillId, model, request, response);
			}
		}
		if(com.ycgwl.util.StringUtils.isNotEmpty(flag) && flag.equals("1")){
			model.addAttribute("type", flag);
		}
		return "uploadReceipt";
	}
	
	/**
	 * @author:113076
	 * @info:异常上报
	 * @time:2017-6-5
	 * */
	@RequestMapping(value="weixin/ExceptionUpSubmit")
	public void ExceptionUpSubmit(Model model,HttpServletRequest request,String abNormalInfo,String wayBillId,
			HttpServletResponse response,@RequestParam("file_item")MultipartFile[] file_item/*接收图片*/) 
					throws Exception{
		String resultMessage="操作成功";
		String resultMessageCode="200";
		Integer userId=getSessionUser(request).getId();
	    //开始上传图片
		logger.info("-----------ExceptionUpSubmit------------" + userId);
		String entity=null;
		if(file_item.length>0){
			//有图片就上传图片，以及存储异常信息和图片路径
			entity = upLoadImages(file_item,1/*orderId*/,"张三"/*u.getUsername()*/,"AbNormal");
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			logger.info(resultCode + "-------------------" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				System.out.println("异常上报图片上传成功");
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("---结果：---" + resultInfo);
				
				JSONArray resultDetails = JSONObject.parseArray(resultInfo);
				
				//拿到图片路径
				JSONObject resultDetail = null;
				List<Address> pathList=new ArrayList<Address>();
				Address address = null;
				for (int i = 0; i < resultDetails.size(); i++) {
					resultDetail = resultDetails.getJSONObject(i);
					String upload_address=resultDetail.getString("upload_address"); //原图路径
					String upload_address_main=resultDetail.getString("upload_address_main"); //小图路径		
					//拿到服务器上传图片时间
					String upload_time=resultDetail.getString("upload_time");
					//将图片路径封装到List中，为转换json做准备
					address = new Address();
					address.setPath(upload_address);;
					pathList.add(address);
				}
				
				//将回单图片路径、时间以及相关id信息存储到数据库
				logger.info("-----------addImagePathToDatabase------------" + userId);
				ExceptionRepor execepor = new ExceptionRepor();
				execepor.setContent(abNormalInfo);
				execepor.setUserid(userId);
				execepor.setWaybillid(Integer.parseInt(wayBillId));
				execepor.setList(pathList);
				String json = JSONObject.toJSONString(execepor);
				logger.info("---传输数据：---" + json);
				entity = RequestPost(request, response, json,
						ExceptionUploaddingURL);
				httpresult = JSONObject.parseObject(entity);
				resultCode = httpresult.getString("resultCode");// 状态码
				reason = httpresult.getString("reason");// 返回信息
				logger.info(resultCode + "-------------------" + reason);
				if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
					resultInfo = httpresult.getString("resultInfo");
					logger.info("--------resultInfo-----------" + resultInfo);
				}else{
					//数据存储失败，报错
					resultMessage=reason;
					resultMessageCode=resultCode;
					//throw new MessageException(Global.FAIL_MSG);
				}
				
			}else{
				//图片上传失败，报错
				resultMessage=reason;
				resultMessageCode=resultCode;
				//throw new MessageException(Global.UNLOAD_IMG_FAIL);
			}
		}else{
			//无图片就只上传异常信息
			logger.info("-----------addExceptionMassageToDatabase------------" + userId);
			ExceptionRepor execepor = new ExceptionRepor();
			execepor.setContent(abNormalInfo);
			execepor.setUserid(userId);
			execepor.setWaybillid(Integer.parseInt(wayBillId));
			execepor.setList(null);//无图片
			String json = JSONObject.toJSONString(execepor);
			logger.info("---传输数据：---" + json);
			entity = RequestPost(request, response, json,
					ExceptionUploaddingURL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			logger.info(resultCode + "-------------------" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("--------resultInfo-----------" + resultInfo);
			}else{
				//数据存储失败，报错
				resultMessage=reason;
				resultMessageCode=resultCode;
				//throw new MessageException(Global.FAIL_MSG);
			}
		}
		
		
		//返回前端异步请求数据
		response.setCharacterEncoding("UTF-8");
		//封装json返回数据
		Map param = new HashMap();
		param.put("code", resultMessageCode);
		param.put("msg", resultMessage);
		String resultJson = JSONObject.toJSONString(param);
		response.getWriter().write(resultJson);
	}
	
	/**
	 * @author:113076
	 * @info:上传回单
	 * @time:2017-6-5
	 * */
	@RequestMapping(value="weixin/ReceiptUpSubmit")
	public void ReceiptUpSubmit(Model model,HttpServletRequest request,String wayBillId,
			HttpServletResponse response,@RequestParam("file_item")MultipartFile[] file_item/*接收图片*/)
					throws Exception{ 
		String resultMessage="操作成功";
		String resultMessageCode="200";
		Integer userId=getSessionUser(request).getId();

	    //开始上传图片
		logger.info("-----------ReceiptUpSubmit------------" + userId);
		String entity = upLoadImages(file_item,1/*orderId*/,"张三"/*u.getUsername()*/,"Receipt");
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			System.out.println("回单上传图片上传成功");
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---结果：---" + resultInfo);
			
			JSONArray resultDetails = JSONObject.parseArray(resultInfo);
			
			//拿到图片路径
			JSONObject resultDetail = null;
			List<Address> pathList=new ArrayList<Address>();
			Address address = null;
			for (int i = 0; i < resultDetails.size(); i++) {
				resultDetail = resultDetails.getJSONObject(i);
				String upload_address=resultDetail.getString("upload_address"); //原图路径
				String upload_address_main=resultDetail.getString("upload_address_main"); //小图路径
						
				//拿到服务器上传图片时间
				String upload_time=resultDetail.getString("upload_time");
				//将图片路径封装到List中，为转换json做准备
				address = new Address();
				address.setPath(upload_address);;
				pathList.add(address);
			}

			//将回单图片路径、时间以及相关id信息存储到数据库
			logger.info("-----------addImagePathToDatabase------------" + userId);
			Receipt receipt = new Receipt();
			receipt.setUserid(userId);
			receipt.setWaybillid(Integer.parseInt(wayBillId));
			receipt.setList(pathList);
			String json = JSONObject.toJSONString(receipt);
			logger.info("---传输数据：---" + json);
			entity = RequestPost(request, response, json,
					ReceiptUploaddingURL);
			httpresult = JSONObject.parseObject(entity);
			resultCode = httpresult.getString("resultCode");// 状态码
			reason = httpresult.getString("reason");// 返回信息
			logger.info(resultCode + "-------------------" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				resultInfo = httpresult.getString("resultInfo");
				logger.info("--------resultInfo-----------" + resultInfo);
			}else{
				//数据存储失败，报错
				resultMessage=reason;
				resultMessageCode=resultCode;
				//throw new MessageException(Global.FAIL_MSG);
			}
			
		}else{
			//图片上传失败，报错
			resultMessage=reason;
			resultMessageCode=resultCode;
			//throw new MessageException(Global.UNLOAD_IMG_FAIL);
		}
		
		//返回前端异步请求数据
	    response.setCharacterEncoding("UTF-8");
	    //封装json返回数据
  		Map param = new HashMap();
  		param.put("code", resultMessageCode);
  		param.put("msg", resultMessage);
  		String resultJson = JSONObject.toJSONString(param);
  		response.getWriter().write(resultJson);
	}

	
	/**
	 * @author:113076
	 * @info:上传回单
	 * @param:其中file_item是图片对象集合，
	 * orderid是订单id，username是上传人姓名，
	 * sourceName为图片来源(是回单还是异常上报)
	 * @time:2017-6-5
	 * */
	private String upLoadImages(MultipartFile[] file_item,int orderid,String username,String sourceName)
			throws MessageException, UnsupportedEncodingException, IOException, HttpException {
		if(file_item==null){
			//图片信息为空，报错
			throw new MessageException(Global.UNLOAD_IMG_ERROR);
		}
		
		//将MultipartFile转换为File
		List<File> files = new ArrayList<File>();
		File f = null;
		for (int i = 0; i < file_item.length; i++) {
			MultipartFile mFile_item=file_item[i];
			if(mFile_item.getSize()==0){
				//如果有图片信息，但是图片大小为0，直接跳过
				continue;
			}
			CommonsMultipartFile cf= (CommonsMultipartFile)mFile_item; 
		    DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
	        f = fi.getStoreLocation();
	        files.add(f);
		}
		
		//这种情况files集合中有图片信息，但是图片实际大小为0的情况
		if(files.size()==0){
			//图片信息为空，报错
			throw new MessageException(Global.UNLOAD_IMG_ERROR);
		}

        //封装图片请求参数
        Map<String,String> paraMap = new HashMap<String,String>();
        paraMap.put("orderid", orderid+"");//订单id
        paraMap.put("upload_man", URLEncoder.encode(username/*u.getUsername()*/,"UTF-8"));//上传人
        paraMap.put("photoSource",sourceName);//图片来源
        
		String json = JSONObject.toJSONString(paraMap);
		logger.info("---传输数据：---" + json);
		String entity = MultiPartRequestPost(UPLOAD_IMG_URL, files, json);
		return entity;
	}
	
    //项目组任务单列表
	@RequestMapping(value="weixin/waybill",method={RequestMethod.POST, RequestMethod.GET })
	public String wayBill(String searchData,String bindstatus,String createtime,String groupid,String delay,Model model,HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException, HttpException, IOException, ParseException{
		User u = (User) request.getSession().getAttribute("user");
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("userid",u.getId());
		String json=jsonObject.toJSONString();
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, QUERY_GROUP_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject resultInfo = httpresult.getJSONObject("resultInfo");
			logger.info("返回个人资源组---------" + resultInfo);
			JSONArray groupArray = resultInfo.getJSONArray("groupMembersList");
			model.addAttribute("groupMembersList", groupArray);
		}
		if (createtime!=null) {
			model.addAttribute("createtime", createtime);//回传条件
		}
		//回显
		model.addAttribute("bindstatus", bindstatus);//回传条件
		model.addAttribute("searchData", searchData);//回传条件
		model.addAttribute("groupid", groupid);//回传条件
		model.addAttribute("delay", com.ycgwl.util.StringUtils.isEmpty(delay) ? null : delay);//回传条件
		return "projectTeamTask";
	}
	
		//项目组任务单列表数据加载
		@RequestMapping(value="weixin/waybilldata")
		@ResponseBody
		public Map<String, List<Waybill>> waybilldata(String searchData,String bindstatus,String createtime,String groupid,String delay,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception{
			Map<String, List<Waybill>> map = new HashMap<String, List<Waybill>>(2);
			User u = (User) request.getSession().getAttribute("user");
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("userid", u.getId());
			if(com.ycgwl.util.StringUtils.isNotEmpty(searchData)){
				jsonObject.put("searchData", searchData);
			}
//			jsonObject.put("startDataTime", request.getParameter("startDataTime"));
//			jsonObject.put("endDataTime", request.getParameter("endDataTime"));
			if(request.getParameter("pageSize")!=null){
				jsonObject.put("size",Integer.parseInt(request.getParameter("pageSize")));//一页五条
	    	}else{
	    		jsonObject.put("size",5);//默认从5开始
	    	}
	    	if(request.getParameter("pageNo")!=null){
	    		jsonObject.put("num",Integer.parseInt(request.getParameter("pageNo")));//获取页数
	    	}else{
	    		jsonObject.put("num",0);//默认从0开始
	    	}
			jsonObject.put("createtime", createtime);
			jsonObject.put("bindstatus", com.ycgwl.util.StringUtils.isEmpty(bindstatus)?0:Integer.valueOf(bindstatus));
			jsonObject.put("groupid", groupid);
			jsonObject.put("delay", com.ycgwl.util.StringUtils.isEmpty(delay) ? null : delay);
			String json=jsonObject.toJSONString();
			
			logger.info("传输数据:" + json);
			String entity = RequestPost(request, response, json,GROUP_WAYBILL_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			logger.info(resultCode + "---------" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				JSONObject resultInfo = httpresult.getJSONObject("resultInfo");
				JSONArray goodsArray = resultInfo.getJSONArray("waybillList");
				logger.info("---返回信息：---" + goodsArray);
				if (goodsArray!=null) {
					List<Waybill> waybills = JSON.parseArray(goodsArray.toJSONString(),Waybill.class);
					//合并相同日期
					map = MergeTheSameDate(waybills,1);
				}else {
					map.put("key", null);
				}
			} else {
				map.put("key", null);
			}
			return map;
		}
	
	/**
	 * 处理List中相同日期的数据，然后放置在key相同的map中
	 * @author zyg
	 * @return 合并后的Map集合
	 * @param 需要合并日期的List集合
	 * @param type标记类型1项目组任务,0其他原来功能
	 * */
	private Map<String, List<Waybill>> MergeTheSameDate(List<Waybill> waybills,Integer type) {
		Map<String,List<Waybill>> sameDateMap = new TreeMap<String,List<Waybill>>(
		    new Comparator<String>() {
		        public int compare(String obj1, String obj2) {
		            // 降序排序
		            return obj2.compareTo(obj1);
		        }
		    });
		Waybill wb=null;String dateKey;
		List<Waybill> itemList=new ArrayList<Waybill>();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0;i<waybills.size();i++){
			wb=waybills.get(i);
			//将日期作为map的key，相同日期的数据放在同一key下的list中
//			if(type==1){
//				dateKey=sdf.format(wb.getOrderTime());
//			}else{
				dateKey=sdf.format(wb.getCreatetime());
//			}
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
	
	/**
	 * 微信上传
	 */
	@RequestMapping(value="weixin/uploadWx")
	@ResponseBody
	public Map<String, Object> uploadWx(HttpServletRequest request,HttpServletResponse response,String serverId,String wayBillId,String abNormalInfo,Integer flag) throws UnsupportedEncodingException, HttpException, IOException{
		Map<String, Object> map = new HashMap<String, Object>(2);
		//保存数据
		User u = (User) request.getSession().getAttribute("user");
		List<Address> pathList=new ArrayList<Address>();
		if(!StringUtils.isEmpty(serverId)){
			String access_token = AccessTokenApi.getAccessTokenStr();
			logger.debug("=======取得accessToken====="+access_token);
			String[] spServerId = serverId.split(",");
			for (String strServerId : spServerId) {
				WeiXinUtils.downloadMedia(access_token, strServerId, FileConstant.SIVE_UPLOAD_PATH, FileConstant.IMAGE_UPLOAD_JPEG);
				Address address = new Address();
				address.setPath(FileConstant.SERCH_UPLOAD_PATH+strServerId+"."+FileConstant.IMAGE_UPLOAD_JPEG);
				pathList.add(address);
			}
		}
		
		String entity ="";
		//将异常图片路径、时间以及相关id信息存储到数据库
		if(flag==WxConstant.RC_UPIMAGE){//回单上报
			Receipt receipt = new Receipt();
			receipt.setUserid(u.getId());
			receipt.setWaybillid(Integer.parseInt(wayBillId));
			receipt.setList(pathList);
			String json = JSONObject.toJSONString(receipt);
			logger.info("---传输数据：---" + json);
			entity = RequestPost(request, response, json,ReceiptUploaddingURL);
		}else{//异常上报
			ExceptionRepor execepor = new ExceptionRepor();
			execepor.setContent(abNormalInfo);
			execepor.setUserid(u.getId());
			execepor.setWaybillid(Integer.parseInt(wayBillId));
			execepor.setList(pathList);
			String json = JSONObject.toJSONString(execepor);
			logger.info("---传输数据：---" + json);
			entity= RequestPost(request, response, json,ExceptionUploaddingURL);
		}
		logger.info("-----------uploadWx返回状态------------" + entity);
		if(!StringUtils.isEmpty(entity) && entity.contains(String.valueOf(Global.RIGHT_CODE))){
			map.put("resultCode", Global.RIGHT_CODE);
			map.put("reason", Global.COMMIT_INFO);
		}else{
			map.put("resultCode", 0);
			map.put("reason", Global.COMMIT_ERROR);
		}
		return map;
	}
	
	/**
	 * 回单上传查询选择任务单后waybill
	 */
	public void getWayBill(String wayBillId,Model model,HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, HttpException, IOException, ParseException{
		logger.info("---getWayBill---" );	
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("wayBillId", wayBillId);
		String json=jsonObject.toJSONString();
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, GET_WAYBILL_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject goodsArray = httpresult.getJSONObject("resultInfo");
			logger.info("---返回信息：---" + goodsArray);
			if (goodsArray!=null) {
				Waybill waybill = JSON.parseObject(goodsArray.toJSONString(),Waybill.class);
				model.addAttribute("barcode", waybill.getBarcode().getBarcode());
				if(waybill.getCustomer()!=null){
					model.addAttribute("companyName", waybill.getCustomer().getCompanyName());
					model.addAttribute("address", waybill.getCustomer().getAddress());
				}
				model.addAttribute("orderSummary", waybill.getOrderSummary());
				model.addAttribute("bindtime", DateUtils.timeToString(waybill.getCreatetime()));
				model.addAttribute("arrivaltimeStr", DateUtils.timeToString(waybill.getArrivaltime()));
				model.addAttribute("deliveryNumber", waybill.getDeliveryNumber());
				model.addAttribute("receiptstimeStr", DateUtils.timeToString(waybill.getActualArrivalTime()));
			}
		}
	}
	
	/**
	 * 根据扫码选择任务单根据code查询wayBill
	 */
	public void getWayBillCode(String code,Model model,HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException, HttpException, IOException, ParseException{
		logger.info("---getWayBill---" );	
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("barcode", code);
		String json=jsonObject.toJSONString();
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, GET_WAYBILLID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject goodsArray = httpresult.getJSONObject("resultInfo");
			logger.info("---返回信息：---" + goodsArray);
			if (goodsArray!=null) {
				Waybill waybill = JSON.parseObject(goodsArray.toJSONString(),Waybill.class);
					model.addAttribute("barcode", waybill.getBarcode().getBarcode());
					if(waybill.getCustomer()!=null){
						model.addAttribute("companyName", waybill.getCustomer().getCompanyName());
						model.addAttribute("address", waybill.getCustomer().getAddress());
					}
					model.addAttribute("orderSummary", waybill.getOrderSummary());
					model.addAttribute("bindtime", DateUtils.timeToString(waybill.getCreatetime()));
					model.addAttribute("arrivaltimeStr", DateUtils.timeToString(waybill.getArrivaltime()));
					model.addAttribute("wayBillId", waybill.getId());//任务单号id
					model.addAttribute("deliveryNumber", waybill.getDeliveryNumber());
					model.addAttribute("receiptstimeStr", DateUtils.timeToString(waybill.getActualArrivalTime()));
				}
			}
	}
	
	/**
	 * 通过我的任务跳转到任务详情界面
	 * @param source来源
	 * @param numOfReport定位次数
	 * @param totalTime天数
	 * @param bindstatus绑定状态20已绑定30运输中40已到货
	 * @param wayBillId运单id
	 * @param shareId分享id
	 * @delay true延迟
	 * @throws Exception 
	 */
	@RequestMapping(value="weixin/myTaskDetails")
	public String myTaskDetails(Model model,Integer wayBillId,String shareId,Integer status,String groupName,HttpServletRequest request,HttpServletResponse response) throws Exception{
		logger.info("---我的任务详情界面运单id：---" + wayBillId);
		this.getwayBillInfo(model, wayBillId, shareId, status,groupName, request, response);
		return "/wx/myTask/myTaskDetails";
	}
	
	/**
	 * 描述：我的任务微信端页面跳转
	 * @param searchData
	 * @param status
	 * @param createtime
	 * @param model
	 * @param request
	 * @param response
	 * @author 叶云松
	 */
	@RequestMapping(value="weixin/myTask",method = { RequestMethod.POST, RequestMethod.GET })
	public String myTask(Model model,String searchData,
			String status,String delay, String createtime, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		model.addAttribute("bindstatus", status);//回传条件
		model.addAttribute("searchData", searchData);//回传条件
		model.addAttribute("createtime", createtime);//回传条件
		model.addAttribute("delay", com.ycgwl.util.StringUtils.isEmpty(delay) ? null : delay);//回传条件
		return "myTask";
	}
	
	/**
	 * 描述：我的任务微信端查询接口
	 * @param searchData
	 * @param status
	 * @param createtime
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws HttpException
	 * @throws IOException
	 * @throws ParseException
	 * @author 叶云松
	 */
	@RequestMapping(value="weixin/myTaskdata",method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Map<String, List<Waybill>> myTaskSear(String searchData,
			String status,String delay, String createtime, HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		logger.info("-------------myTask-----------" );	
		Map<String, List<Waybill>> map = new HashMap<String, List<Waybill>>(2);
		User u = (User) request.getSession().getAttribute("user");
		Waybill waybill = new Waybill();
		JSONObject jsonObject = new JSONObject();
		try {
			if(request.getParameter("pageSize")!=null){
				waybill.setSize(Integer.parseInt(request.getParameter("pageSize")));//一页五条
	    	}else{
	    		waybill.setSize(5);//默认从5开始
	    	}
	    	if(request.getParameter("pageNo")!=null){
	    		waybill.setNum(Integer.parseInt(request.getParameter("pageNo")));
	    	}else{
	    		waybill.setNum(0);//默认从0开始
	    	}
			searchData = com.ycgwl.util.StringUtils.isEmpty(searchData) ? null : searchData;
			waybill.setCompanyAddress(searchData);
			waybill.setCompanyName(searchData);
			waybill.setDeliveryNumber(searchData);
			waybill.setOrderSummary(searchData);
			waybill.setBindstatus(com.ycgwl.util.StringUtils.isEmpty(status)?null:Integer.valueOf(status));
			waybill.setDelay(com.ycgwl.util.StringUtils.isEmpty(delay) ?null:Boolean.valueOf(delay));
			waybill.setCreatetime(com.ycgwl.util.StringUtils.isEmpty(createtime)? null: DateUtils.parseDate(createtime, "yyyy-MM-dd"));
			waybill.setUserid(u.getId());
			jsonObject.put("waybill", waybill);
		} catch (Exception e) {
			throw new IOException("参数异常");
		}
		String json=jsonObject.toJSONString();
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, WAYBILL_LIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String array = httpresult.getString("resultInfo");
			if (com.ycgwl.util.StringUtils.isNotEmpty(array)) {
				List<Waybill> results = JSONArray.parseArray(array, Waybill.class);
				map = MergeTheSameDate(results,0);
			}else {
				map.put("key", null);
			}
		} else {
			map.put("key", null);
		}
		return map;
	}
}
