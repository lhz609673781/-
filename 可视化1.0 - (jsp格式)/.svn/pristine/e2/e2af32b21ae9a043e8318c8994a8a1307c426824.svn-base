package trace.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.ycgwl.core.DateUtils;
import com.ycgwl.core.Global;
import com.ycgwl.util.FileConstant;
import com.ycgwl.util.FileUtils;
import com.ycgwl.util.StringUtils;

import trace.domain.QueryVo;
import trace.domain.QueryWaybill;
import trace.exception.MessageException;
import trace.util.SmsUtil;
import ycgwl.track.entity.AccountInfo;
import ycgwl.track.entity.Customer;
import ycgwl.track.entity.CustomerGroup;
import ycgwl.track.entity.Group;
import ycgwl.track.entity.PageModel;
import ycgwl.track.entity.Track;
import ycgwl.track.entity.User;
import ycgwl.track.entity.Waybill;

//任务单管理
@Controller
public class TraceController extends BaseController {
	@Value("${wayBillEditURL}")
	private String WAYBILL_EDIT_URL;

	@Value("${wayBillPageListURL}")
	private String WAYBILL_PAGELIST_URL;

	@Value("${wayBillByIdURL}")
	private String WAYBILL_BYID_URL;

	@Value("${wayBillConfirmURL}")
	private String WAYBILL_CONFIRM_URL;

	@Value("${wayBillBindCustomerURL}")
	private String WAYBILL_BIND_CUSTOMER_URL;

	@Value("${queryCustomerListURL}")
	private String QUERY_CUSTOMER_LIST_URL;

	@Value("${ImagePath}")
	private String IMAGE_PATH;

	@Value("${wayBillImgByidUrl}")
	private String WAYBILL_IMG_BYID_URL;
	
	@Value("${wayBillAccountUrl}")
	private String WAYBILL_ACCOUNT_URL;

	@Value("${resourceGroup_list_url}")
	private String RESOURCEGROUP_LIST_URL;
	
	@Value("${account_list_url}")
	private String ACCOUNT_LIST_URL;
	
	@Value("${account_by_waybill_url}")
	private String ACCOUNT_BY_WAYBILLID_URL;
	
	@Value("${add_account_url}")
	private String ADD_ACCOUNT_URL;

	// 任务单列表
	@RequestMapping(value = "/trace")
	public String trace(QueryVo qVo, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		PageInfo<Waybill> pageInfo = null;
		Waybill waybill = qVo.getWaybill()==null?new Waybill():qVo.getWaybill();
		if(waybill!=null && waybill.getBarcode()!=null && StringUtils.isNotEmpty(waybill.getBarcode().getBarcode())){
			waybill.getBarcode().setBarcode(waybill.getBarcode().getBarcode().trim());
		}
		pageInfo = getTraceListPagesByUserId(qVo,waybill,model,request, response);
		model.addAttribute("page", pageInfo);
		// 搜索条件回显
		model.addAttribute("waybill", waybill);
		List<Group> groupList = getGroupListByUserId(getSessionUser(request).getId(),request, response);
		model.addAttribute("groups", groupList);
		return "track";
	}
	
	// 获取地图waybill信息
	@RequestMapping(value = "/trace/enterBillDetail", method = RequestMethod.POST)
	@ResponseBody
	public List<Track> enterBillDetail(Integer id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("-----------waybillID------------" + id);
		Waybill waybill = new Waybill();
		waybill.setId(id);
		User u = (User) request.getSession().getAttribute("user");
		waybill.setUserid(u.getId());
		String json = JSONObject.toJSONString(waybill);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, WAYBILL_BYID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---返回信息：---" + resultInfo);
			waybill = JSONObject.parseObject(resultInfo, Waybill.class);
			List<Track> tracks = waybill.getTracks();
			if (tracks != null && tracks.size() > 0) {
				return tracks;
			}
		}
		return null;
	}

	// 任务单findByID
	@RequestMapping(value = "/trace/findById")
	public String findById(Integer id, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("-----------findById------------" + id);
		Waybill waybill = new Waybill();
		waybill.setId(id);
		User u = (User) request.getSession().getAttribute("user");
		waybill.setUserid(u.getId());
		String json = JSONObject.toJSONString(waybill);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, WAYBILL_BYID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---返回信息：---" + resultInfo);
			waybill = JSONObject.parseObject(resultInfo, Waybill.class);
			model.addAttribute("waybill", waybill);
		} else {
			model.addAttribute("waybill", null);
		}
		model.addAttribute("imagePath", IMAGE_PATH);// 图片服务器的路径
		return "billDetails";

	}

	// 发送短信通知
	@RequestMapping(value = "/trace/sendSMS", method = RequestMethod.POST)
	@ResponseBody
	public String sendSMS(@RequestBody QueryWaybill vo, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("-----------sendSMS------------" + vo);
		User u = (User) request.getSession().getAttribute("user");
		List<Integer> idList = Arrays.asList(vo.getIds());
		String result = "发送成功";
		for (Integer id : idList) {
			Waybill waybill = new Waybill();
			waybill.setId(id);
			waybill.setUserid(u.getId());
			String json = JSONObject.toJSONString(waybill);
			logger.info("---传输数据：---" + json);
			String entity = RequestPost(request, response, json, WAYBILL_BYID_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			logger.info(resultCode + "------------" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("---返回信息：---" + resultInfo);
				waybill = JSONObject.parseObject(resultInfo, Waybill.class);
				String barcode = waybill.getBarcode().getBarcode();
				String address = waybill.getAddress();
				String contactNumber = waybill.getCustomer().getContactNumber();
				String memContent = "尊敬的客户您好！您的货物单号" + barcode + "已到达" + address + ",如有问题请联系13370216559,祝你工作顺利,生活愉快！";
				result = SmsUtil.sendMessage(contactNumber, memContent);
				// 记录发送的次数
				/*
				 * Integer customerid = waybill.getCustomer().getId();
				 * QueryWaybill q = new QueryWaybill();
				 * q.setCustomerid(customerid); q.setUserid(u.getId()); String
				 * json2 = JSONObject.toJSONString(q);
				 * logger.info("---传输数据2：---" + json2); String entity2 =
				 * RequestPost(request, response, json2, WAYBILL_SMS_URL);
				 * JSONObject httpresult2 = JSONObject.parseObject(entity2);
				 * String resultCode2 = httpresult.getString("resultCode");//
				 * 状态码 String reason2 = httpresult.getString("reason");// 返回信息
				 * logger.info(resultCode2 + "------------" + reason2 +
				 * "-------------" + httpresult2);
				 */
			}
		}
		return result;
	}

	// 进入地图
	@RequestMapping(value = "/trace/gomap")
	public String gomap(Integer id, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("-----------gomap------------" + id);
		Waybill waybill = new Waybill();
		waybill.setId(id);
		User u = (User) request.getSession().getAttribute("user");
		waybill.setUserid(u.getId());
		String json = JSONObject.toJSONString(waybill);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, WAYBILL_BYID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---返回信息：---" + resultInfo);
			waybill = JSONObject.parseObject(resultInfo, Waybill.class);
			// 获取最新一次的位置
			if (waybill.getTracks() != null && waybill.getTracks().size() > 0) {
				Track track = waybill.getTracks().get(0);
				model.addAttribute("track", track);
			}
		} else {
			model.addAttribute("track", null);
		}
		return "map";
	}

	// 确认到货
	@RequestMapping(value = "/trace/confirmArrive", method = RequestMethod.POST)
	@ResponseBody
	public String confirmArrive(Integer id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("-----------confirmArrive------------" + id);
		Waybill waybill = new Waybill();
		waybill.setId(id);
		User u = (User) request.getSession().getAttribute("user");
		waybill.setUserid(u.getId());
		String json = JSONObject.toJSONString(waybill);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, WAYBILL_CONFIRM_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		String resultInfo = httpresult.getString("resultInfo");
		logger.info("---返回信息：---" + resultInfo);
		// if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
		// }
		return reason;
	}

	// 查询全部客户信息
	@RequestMapping(value = "/trace/customer", method = RequestMethod.POST)
	@ResponseBody
	public List<Customer> customerList(Integer groupid, String companyName, String contacts, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("-----------customerList------------" + groupid + companyName + contacts);
		User u = (User) request.getSession().getAttribute("user");
		CustomerGroup cg = new CustomerGroup();
		Customer customer = new Customer();
		// customer.setUserId(u.getId());
		if (StringUtils.isNotEmpty(companyName)) {
			customer.setCompanyName(companyName);
		}
		if (StringUtils.isNotEmpty(contacts)) {
			customer.setContacts(contacts);
		}
		cg.setCustomer(customer);
		cg.setGroupid(groupid);
		cg.setUserid(u.getId());
		String json = JSONObject.toJSONString(cg);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, QUERY_CUSTOMER_LIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONArray goodsArray = httpresult.getJSONArray("resultInfo");
			logger.info("---返回信息：---" + goodsArray);
			return JSON.parseArray(goodsArray.toJSONString(), Customer.class);
		} else {
			return null;
		}
	}

	// 任务单绑定收货人
	@RequestMapping(value = "/trace/bindCustomer", method = RequestMethod.POST)
	@ResponseBody
	public String bindCustomer(Integer customerid, Integer id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("-----------bindCustomer------------" + customerid + id);
		User u = (User) request.getSession().getAttribute("user");
		Waybill waybill = new Waybill();
		waybill.setUserid(u.getId());
		waybill.setId(id);
		waybill.setCustomerid(customerid);
		String json = JSONObject.toJSONString(waybill);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, WAYBILL_BIND_CUSTOMER_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		return reason;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); // true:允许输入空值，false:不能为空值
	}

	// 任务单图片批量下载
	@RequestMapping(value = "/trace/dowloadImage")
	public void dowloadImage(Integer[] ids, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("-----------dowloadImage------------" + ids);
		User u = (User) request.getSession().getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>(2);
		map.put("userid", u.getId());
		map.put("id", ids);
		String json = JSONObject.toJSONString(map);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, WAYBILL_IMG_BYID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		// 压缩成功后读取文件压缩下载
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			logger.info("============开始下载文件========");
			FileUtils.download(reason, DateUtils.formatDate() + "." + FileConstant.IMAGE_UPLOAD_ZIP, response, true);
			logger.info("============结束下载文件========");
		}
	}

	// 编辑任务单信息
	@RequestMapping(value = "/trace/editWaybill", method = RequestMethod.POST)
	@ResponseBody
	public String editWaybill(Integer id, String orderSummary, String arrivetime, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("-----------editWaybill------------" + id + orderSummary + arrivetime);
		Waybill waybill = new Waybill();
		waybill.setId(id);
		User u = (User) request.getSession().getAttribute("user");
		waybill.setUserid(u.getId());
		waybill.setOrderSummary(orderSummary);
		waybill.setArrivaltimeStr(arrivetime);
		String json = JSONObject.toJSONString(waybill);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, WAYBILL_EDIT_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		return reason;
	}
	
	// 获取任务单列表(内部方法)
	@SuppressWarnings("unchecked")
	private PageInfo<Waybill> getTraceListPagesByUserId(QueryVo qVo,Waybill waybill,Model model, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException, IOException, HttpException {
		PageInfo<Waybill> pageInfo = null;
		User u = (User) request.getSession().getAttribute("user");
		logger.info("-----------traceList------------" + waybill);
		waybill.setUserid(u.getId());
		PageModel<Waybill> page = new PageModel<Waybill>();
		// 设置默认分页
		page.setPageNo(qVo.getPageNo());
		page.setPageSize(qVo.getPageSize()==null?10:qVo.getPageSize());
		page.setObj(waybill);
		String json = JSONObject.toJSONString(page);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, WAYBILL_PAGELIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---返回信息：---" + data);
			pageInfo = JSONObject.parseObject(data.toString(), PageInfo.class);
		}
		return pageInfo;
	}
	
	// 获取资源组(内部方法)
	private List<Group> getGroupListByUserId(Integer userid,HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		// 查询资源组
		Group group = new Group();
		group.setUserid(userid);
		String json2 = JSONObject.toJSONString(group);
		String entity2 = RequestPost(request, response, json2, RESOURCEGROUP_LIST_URL);
		JSONObject httpresult2 = JSONObject.parseObject(entity2);
		String resultCode2 = httpresult2.getString("resultCode");// 状态码
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode2)) {
			JSONArray goodsArray = httpresult2.getJSONArray("resultInfo");
			if (goodsArray != null) {
				List<Group> groupList = JSON.parseArray(goodsArray.toJSONString(), Group.class);
				return groupList;
			}
		}
		return null;
	}
	
	//获取我的账单信息
	@RequestMapping(value = "/MyAccountBook")
	public String myAccountBook(QueryVo qVo, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		PageInfo<Waybill> pageInfo = null;
		User u = (User) request.getSession().getAttribute("user");
		Waybill waybill = qVo.getWaybill()==null?new Waybill():qVo.getWaybill();
		pageInfo = getTraceListPagesByUserId(qVo,waybill,model, request, response);
		model.addAttribute("page", pageInfo);
		//通过运单列表获取每个运单的对账信息
		List<Waybill> wList = JSONObject.parseArray(JSONObject.toJSONString(pageInfo.getList()), Waybill.class);
		//这里对账单是定制化的，所以请求时要带有该用户的userid，所以暂时使用waybill的userid字段
		for(int i=0;i<wList.size();i++){
			wList.get(i).setUserid(u.getId());
		}
		Map<Integer,AccountInfo> mapResult = getAccountInfoMapFormList(model, request, response, wList);
		model.addAttribute("accountMap", mapResult);
		// 搜索条件回显
		model.addAttribute("waybill", waybill);
		List<Group> groupList = getGroupListByUserId(u.getId(),request, response);
		model.addAttribute("groups", groupList);
		return "myAccountBook";
	}

	private Map<Integer,AccountInfo> getAccountInfoMapFormList(Model model, HttpServletRequest request, 
			HttpServletResponse response,List<Waybill> wList)
			throws UnsupportedEncodingException, IOException, HttpException {
		Map<Integer,AccountInfo> mapResult = new HashMap<Integer,AccountInfo>();
		String json = JSONObject.toJSONString(wList);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, ACCOUNT_LIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---返回信息：---" + resultInfo);
			List<AccountInfo> accountInfos = JSONObject.parseArray(resultInfo, AccountInfo.class);
			if(accountInfos!=null&&accountInfos.size()>0){
				//一Map<运单id,对账实体>
				for(AccountInfo account:accountInfos){
					if(account!=null){
						mapResult.put(account.getWaybillid(), account);
					}
				}
			}
		}
		return mapResult;
	}
	
	@RequestMapping(value = "/trace/findAccountByWayBillId", method = RequestMethod.POST)
	@ResponseBody
	public String findAccountByWayBillId(Integer id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String resultStr = "";
		Waybill waybill = new Waybill();
		waybill.setId(id);
		waybill.setUserid(getSessionUser(request).getId());
		String json = JSONObject.toJSONString(waybill);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, ACCOUNT_BY_WAYBILLID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---返回信息：---" + resultInfo);
			AccountInfo accountInfo = JSONObject.parseObject(resultInfo, AccountInfo.class);
			resultStr=JSONObject.toJSONString(accountInfo);  
		}
		return resultStr;
	}
	
	@RequestMapping(value = "/trace/addAccountInfo", method = RequestMethod.POST)
	public String addAccountInfo(AccountInfo accountInfo, Model model,HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		accountInfo.setUserid(getSessionUser(request).getId());
		String json = JSONObject.toJSONString(accountInfo);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, ADD_ACCOUNT_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		if (Global.RIGHT_CODE != Integer.parseInt(resultCode)) {
			throw new MessageException(reason);
		}
		return myAccountBook(new QueryVo(),model,request,response);
	}
	
	@RequestMapping(value = "/trace/dowloadAccountFile", method = RequestMethod.POST)
	public void dowloadAccountFile(String [] accountType, Waybill waybill,
			Model model,HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String type = null;
		//accountType长度为2说明收入和支出都要下载，反之就一个
		if(accountType.length==2){type="all";}else if(accountType.length==1){type=accountType[0];}
		Map<String, Object> map = new HashMap<String, Object>(2);
		User u = (User) request.getSession().getAttribute("user");
		map.put("userid",u.getId());
		map.put("type",type);
		map.put("waybill", waybill);
		String json = JSONObject.toJSONString(map);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, WAYBILL_ACCOUNT_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		// 压缩成功后读取文件压缩下载
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			logger.info("============开始下载文件========");
			FileUtils.download(reason, DateUtils.formatDate() + "." + FileConstant.IMAGE_UPLOAD_ZIP, response, true);
			logger.info("============结束下载文件========");
		}
	    
	}
	
	

}
