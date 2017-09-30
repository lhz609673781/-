package trace.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.weixin.sdk.api.AccessTokenApi;
import com.jfinal.weixin.sdk.api.ApiConfig;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.jfinal.weixin.sdk.api.ApiResult;
import com.jfinal.weixin.sdk.api.SnsAccessToken;
import com.jfinal.weixin.sdk.api.SnsAccessTokenApi;
import com.jfinal.weixin.sdk.api.SnsApi;
import com.jfinal.weixin.sdk.api.UserApi;
import com.ycgwl.core.Base64Utils;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;

import trace.exception.MessageException;
import trace.interceptor.RoleCheckInterceptor;
import trace.util.PropertiesUtils;
import trace.util.RolePermissionUtils;
import trace.util.WxConstant;
import ycgwl.track.entity.GroupMembers;
import ycgwl.track.entity.RolePermission;
import ycgwl.track.entity.User;
import ycgwl.track.entity.UserRole;

@Controller
@RequestMapping("/weixin")
public class WeixinOAuthController extends BaseController {
	@Value("${domian_url}")
	private String domain;
	@Value("${userLoginURL}")
	private String USER_LOGIN_URL;
	@Value("${checkBarcodeURL}")
	private String CHECKBARCODEURL;
	@Value("${user_role_url}")
    private String USER_ROLE_URL;
	private static String encodingAESKey = "";
	boolean snsapiBase = true;

	@Value("${group_member_add_url}")
	private String GROUP_MEMBER_ADD_URL;
	
	@Value("${driver_waybill_statue_url}")
	private String DRIVER_WAYBILL_STATUE_URL;
	
	private String groupId = "";
	private String type;
	
	private static ApiConfig apiConfig = WeixinOAuthController.initConfig();
	/**
	 * 1.访问OAuth授权接口获取CODE.
	 */
	@RequestMapping(value = "/weixinAuth", method = RequestMethod.GET)
	public void userAuth(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.debug("|||||||||||||||||||||coreDubug111|||||||||||||||||||");
		String state = request.getParameter("code");
		state = state != null ? state : "";
		type = request.getParameter("type");
		groupId = request.getParameter("groupId");//扫码加群逻辑参数
		if(!snsapiBase){
			type = request.getAttribute("type")==null?"":request.getAttribute("type").toString();
			groupId = request.getAttribute("groupId")==null?"":request.getAttribute("groupId").toString();
			state = request.getAttribute("state")==null?"":request.getAttribute("state").toString();
		}
		logger.debug("|||||||||||||||||||||type="+type+"|||||||||||||||||||");
		
		if(request.getParameter("wayBillId")!=null
				&&request.getParameter("shareId")!=null){//从分享点击进来到任务单详情页
			logger.debug("|||||||||||||||||||||coreDubug222|||||||||||||||||||");
			int wayBillId=Integer.parseInt(request.getParameter("wayBillId").toString());
			String shareId=request.getParameter("shareId").toString();
			state=wayBillId+"-"+shareId;//标记这是从分享点击进来到任务单详情页
		}
		ApiConfigKit.setThreadLocalApiConfig(apiConfig);
		//判断是否是第一次扫描进入
		User user = getSessionUser(request);
		if(null != user && StringUtils.isNotEmpty(user.getMobilephone()) && null!=AccessTokenApi.getAccessToken()){
			logger.debug("|||||||||||||||||||||coreDubug333|||||||||||||||||||phone="+getSessionUser(request).getMobilephone());
			//openId = getSessionUser(request).getOpenid();
			toPageDo(request, response, state, getSessionUser(request));//已登录逻辑跳转
			return;
		}
		logger.debug("|||||||||||||||||||||coreDubug444|||||||||||||||||||");
		// 跳转到授权页面
		String url = SnsAccessTokenApi.getAuthorizeURL(Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPID")), domain
					+ "/weixin/weixinCallback.html", state, snsapiBase);
		logger.debug("weixinAuth===============>" + url);
		logger.debug("snsapiBase==============>" + snsapiBase);
		response.sendRedirect(url);
	}

	/**
	 * @author djq
	 * @param callback(获取openId和用户信息) 2.userAuth访问完回调当前方法.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/weixinCallback", method = RequestMethod.GET)
	public void callback(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		long start = System.currentTimeMillis();
		logger.error("callback==========dif004=================="+start);
		if(request.getAttribute("forward_FLag")!=null){
			request.removeAttribute("forward_FLag");
			return;
		}
		logger.debug("|||||||||||||||||||||coreDubug555|||||||||||||||||||");
		logger.debug("=====callback=====type="+type+"==============");
		logger.debug("==========init==============>weixinCallback");
		String code = request.getParameter("code");// 授权请求后返回的code,提供下面获取用户信息参数
		logger.debug("==========code==============>code"+code);
		ApiConfigKit.setThreadLocalApiConfig(apiConfig);// 初始化配置jfinal内部用到
		if (code != null) {
			logger.debug("|||||||||||||||||||||coreDubug666|||||||||||||||||||");
			// 通过code换取网页授权access_token
			SnsAccessToken snsAccessToken;
			if(vlidateSessionId(request, request.getParameter("state"))){
				logger.debug("|||||||||||||||||||||coreDubug777|||||||||||||||||||");
				snsAccessToken = SnsAccessTokenApi.getSnsAccessToken(WxConstant.APPID_PRODUCE_OPEN, WxConstant.APPSECRET_PRODUCE_OPEN,
						code);
			}else{
				logger.debug("|||||||||||||||||||||coreDubug888|||||||||||||||||||");
				logger.debug("-----------------appId--------------"+Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPID")));
				snsAccessToken = SnsAccessTokenApi.getSnsAccessToken(Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPID")), Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPSECRET")),
						code);
			}
			logger.debug("|||||||||||||||||||||coreDubug999|||||||||||||||||||");
			if (!snsapiBase) {
				logger.debug("|||||||||||||||||||||coreDubug1002|||||||||||||||||||");
				snsapiBase = true;
				String state = request.getParameter("state");
				addUser(request, response, snsAccessToken,state);
			}
			logger.debug("|||||||||||||||||||||coreDubug1003|||||||||||||||||||");
			checkUser(request, response, snsAccessToken);
			long dif = System.currentTimeMillis()-start;
			logger.error("callback==========dif005=================="+dif);
		}
	}

	private void addUser(HttpServletRequest request, HttpServletResponse response,SnsAccessToken snsAccessToken,String state)
			throws Exception {
		logger.debug("|||||||||||||||||||||coreDubug1004|||||||||||||||||||");
		String access_token = snsAccessToken.getAccessToken();
		logger.debug("==========accessToken==============>" + access_token);
		String openId = snsAccessToken.getOpenid();
		
		ApiResult apiResult = SnsApi.getUserInfo(access_token, openId);
		if (apiResult.isSucceed()) {
			logger.debug("|||||||||||||||||||||coreDubug1005|||||||||||||||||||");
			JSONObject jsonObject = JSON.parseObject(apiResult.getJson());
			logger.debug("===========ApiResult============>:" + jsonObject.toJSONString());
			String nickName =  apiResult.get("nickname");
			logger.debug("===========nickName============>:" + nickName);
			String headimgurl = apiResult.getStr("headimgurl");
			logger.debug("===========headimgurl============>:" + headimgurl);
			/*
			 * String nickName = jsonObject.getString("nickname");
			 * //用户的性别，，值为0时是未知 int sex =
			 * jsonObject.getIntValue("sex");//值为1时是男性，值为2时是女性，0是未知
			 * String city = jsonObject.getString("city");//城市
			 * String province =
			 * jsonObject.getString("province");//省份 String country
			 * = jsonObject.getString("country");//国家 String
			 * headimgurl = jsonObject.getString("headimgurl");
			 * String unionid = jsonObject.getString("unionid");
			 */
			//注册用户
			String unionid = apiResult.getStr("unionid");
			
			if(null!=access_token){
				logger.debug("|||||||||||||||||||||coreDubug1001|||||||||||||||||||");
				cacheManger.setKeyValue(access_token, access_token);
				cacheManger.expire(access_token, WxConstant.WEIXINTIMEOUT - 5);
			}
			
			JSONObject jsonParam = new JSONObject();
			jsonParam.put("uname",nickName);
			jsonParam.put("openid", unionid);
			jsonParam.put("openId", openId);
			initUser(request, response, jsonParam,state);
			logger.debug("|||||||||||||||||||||coreDubug1006|||||||||||||||||||");
		}
	}
	/**
	 * 注册用户功能
	 * @param request
	 * @param response
	 * @param nickName
	 * @throws Exception 
	 */
	private void initUser(HttpServletRequest request, HttpServletResponse response, JSONObject jsonParam,String state)
			throws Exception {
		logger.debug("|||||||||||||||||||||coreDubug1007|||||||||||||||||||");
		String res = userRegister(jsonParam.toJSONString(), request, response);
		logger.debug("========注册=========" + res);
		if (JsonTool.getStatus("resultCode", res) == Global.RIGHT_CODE) {
			logger.debug("|||||||||||||||||||||coreDubug1008|||||||||||||||||||type="+type);
			request.setAttribute("groupId", groupId);
			request.setAttribute("state", state);
			request.setAttribute("type", type);
			Integer uId = JsonTool.getJSON("resultInfo", res).getInteger("id");
			String openId = jsonParam.getString("openId");
			String key = "openid_"+uId;
			if(com.ycgwl.util.StringUtils.isNotEmpty(openId)){
				cacheManger.setKeyValue(key, openId);
				cacheManger.expire(key, WxConstant.WEIXINTIMEOUT);
			}
			//response.sendRedirect("/weixin/tobindPhone.html");
			request.setAttribute("forward_FLag", true);
			request.getRequestDispatcher("/weixin/tobindPhone.html").forward(request, response);
		} else {
			throw new MessageException(JsonTool.getObject("reason", res).toString());
		}
	}

	/**
	 * 根据用户openid检查用户是否存在，不存在添加到用户表
	 * 
	 * @param request
	 * @param response
	 * @param args
	 * @throws Exception
	 */
	private void checkUser(HttpServletRequest request,
			HttpServletResponse response,SnsAccessToken snsAccessToken) throws Exception {
		logger.debug("|||||||||||||||||||||coreDubug1009|||||||||||||||||||");
		String access_token = snsAccessToken.getAccessToken();
		logger.debug("==========accessToken==============>" + access_token);
		String unionId = snsAccessToken.getUnionid();//通过Unionid做唯一标识
		
		String state = request.getParameter("state");// 条码编号
		if (StringUtils.isNotEmpty(unionId)) {
			logger.debug("|||||||||||||||||||||coreDubug1010|||||||||||||||||||");
			JSONObject json = new JSONObject();
			json.put("openid", unionId);
			String entity = RequestPost(request, response, json.toJSONString(),
					USER_LOGIN_URL);
			logger.debug("entity===================>" + entity);
			logger.debug("reason===================>"
					+ JsonTool.getObject("reason", entity).toString());
			if (JsonTool.getStatus("resultCode", entity) != Global.RIGHT_CODE) {
				logger.debug("|||||||||||||||||||||coreDubug1011|||||||||||||||||||");
				if(vlidateSessionId(request, state)){
					addUser(request, response, snsAccessToken,state);
				}
				logger.debug("snsapiBase======fff========>" + snsapiBase);
				logger.debug("=============第二次进来了==================");
				snsapiBase = false;
				// response.sendRedirect("/weixin/weixinAuth.html");
				logger.debug("=====checkUser=====type"+type+"==============");
				request.setAttribute("type", type);
				request.setAttribute("state", state);
				request.setAttribute("groupId", groupId);
				request.setAttribute("forward_FLag", true);
				request.getRequestDispatcher("/weixin/weixinAuth.html").forward(request, response);
				//response.sendRedirect("/weixin/weixinAuth.html");
				return;
			} else {// 用户存在后的逻辑
				logger.debug("|||||||||||||||||||||coreDubug1012|||||||||||||||||||");
				User user = JSON.parseObject(
						JsonTool.getObject("resultInfo", entity).toString(),
						User.class);
				if (user == null) {
					throw new MessageException(Global.USERE_NAME_ERROR);
				}
				//判断用户是否关注公众部分逻辑
				String openId = snsAccessToken.getOpenid();//通过Unionid做唯一标识
				String key = "openid_"+user.getId();
				if(com.ycgwl.util.StringUtils.isNotEmpty(openId)){
					cacheManger.setKeyValue(key, openId);
					cacheManger.expire(key, WxConstant.WEIXINTIMEOUT);
				}
				request.getSession().setAttribute("user", user);
				/*rolePermissionUtils = new RolePermissionUtils();
				//通过用户id查询出用户所有组相关的角色
				Map<Integer,GroupRolePermission> rpMap = rolePermissionUtils.getRoleMap(user.getId());
				request.getSession().setAttribute("RoleMap", rpMap);*///将权限信息放入session中，用以权限判定
				logger.debug("========扫描登录state===========>"+state);
				// 判断用户是否绑定手机号没有调到绑定手机号界面
				if (StringUtils.isEmpty(user.getMobilephone())) {
					logger.debug("|||||||||||||||||||||coreDubug1013|||||||||||||||||||");
					request.setAttribute("groupId", groupId);
					request.setAttribute("state", state);
					request.setAttribute("type", type);
					//response.sendRedirect("/weixin/tobindPhone.html");
					request.setAttribute("forward_FLag", true);
					request.getRequestDispatcher("/weixin/tobindPhone.html").forward(request, response);
					return;
				}
				//扫描登录跳转逻辑
				if(vlidateSessionId(request, state)){
					logger.debug("|||||||||||||||||||||coreDubug1014|||||||||||||||||||");
					logger.debug("========扫描登录成功===========>");
					response.sendRedirect("/index.html");
					return;
				}
				logger.debug("|||||||||||||||||||||coreDubug1015|||||||||||||||||||");
				toPageDo(request, response, state, user);
			}
		}

	}
	/**
	 * 根据参数类型做不同逻辑处理
	 * @param request
	 * @param response
	 * @param state
	 * @param user
	 * @throws IOException
	 * @throws Exception
	 */
	private void toPageDo(HttpServletRequest request, HttpServletResponse response, String state, User user)
			throws IOException, Exception {
		logger.debug("|||||||||||||||||||||coreDubug1016|||||||||||||||||||");
		logger.debug("===========type============="+type+"========state========"+state);
		if(StringUtils.isNoneEmpty(type)){//根据不同类型跳转到不同的界面
			logger.debug("|||||||||||||||||||||coreDubug1017|||||||||||||||||||");
			int toPage = Integer.valueOf(type);
			if(toPage==WxConstant.BINDCODE){
				response.sendRedirect("/weixin/toHome.html");
				//request.getRequestDispatcher("/weixin/toHome.html").forward(request, response);
			}else if(toPage==WxConstant.TOLOCATIONLIST){
				response.sendRedirect("/weixin/myTask.html");
			}else if(toPage==WxConstant.MINERESOUCE){
				response.sendRedirect("/weixin/mine/mineResouce.html");
			}else if(toPage==WxConstant.SCANADDGROUP){
				if (StringUtils.isNotEmpty(groupId)) {
					addMineCard(request, response, groupId, user.getId());
				}
			}else if(toPage==WxConstant.SCANCODE){
				if(StringUtils.isNotEmpty(state)){
					checkBarcode(request, response, state);
				}
			}else if(toPage==WxConstant.SHAREDETAILS){
				logger.debug("|||||||||||||||||||||coreDubug1018|||||||||||||||||||");
				String wayBillId=state.split("-")[0];
				String shareId=state.split("-")[1];
				response.sendRedirect(request.getContextPath() + "/weixin/ToWaybillDetail.html?wayBillId="
						+wayBillId+"&shareId="+shareId);
				logger.debug("===========Redirect==============>"
						+ request.getContextPath() + "/weixin/ToWaybillDetail.html?wayBillId="
						+wayBillId+"&shareId="+shareId);
			}else if(toPage==WxConstant.MINE){
				response.sendRedirect("/weixin/mine.html");
			}else if(toPage == WxConstant.WAILLBILL){//任务单跳转
				response.sendRedirect("/weixin/waybill.html"); 
			}else if(toPage == WxConstant.UPLOADRECEIPT){//上传回单
				if(StringUtils.isNotEmpty(state)){
					response.sendRedirect("/weixin/ReceiptUp.html?code="+state+"&flag=1");
				}else{
					response.sendRedirect("/weixin/ReceiptUp.html");
				}
			}else if(toPage == WxConstant.POSITIONLIST){//任务单详情
				response.sendRedirect("/weixin/searchmoreLocationList.html");
			}else if(toPage == WxConstant.TOHOME){
				response.sendRedirect("toHomeWeChat.html");
			}
		}else{
			logger.debug("toPageDo======================>type is null");
			throw new MessageException(Global.PARAMS_ERROR);
		}
	}

	/**
	 * 检查条码的状态,根据条码状态跳转不同界面
	 * @param request,response,barCode,userId
	 * @return int
	 * @throws Exception 
	 */
	/**
	 * @param request
	 * @param response
	 * @param barCode
	 * @param userId
	 * @throws Exception
	 */
	private void checkBarcode(HttpServletRequest request, HttpServletResponse response,String barCode) throws Exception{
		Integer uId = getSessionUser(request).getId();
		String opneId = cacheManger.getWithkey("openid_"+uId);
		int subscribe = getSubscribe(opneId);
		//如果该司机扫码的运单已经卸货（该司机对应的waybill的状态为非1），则直接跳转运单详情界面
		JSONObject jParam = new JSONObject();
		jParam.put("userid", uId);
		jParam.put("barcode", barCode);
		logger.debug("==========driver_waybill_statue=============>:"+barCode);
		logger.debug("==========driver_waybill_statue=============>:"+uId);
		String res = RequestPost(request, response, jParam.toJSONString(), DRIVER_WAYBILL_STATUE_URL);
		int code = JsonTool.getStatus("resultCode", res);
		String reason= JsonTool.getObject("reason", res).toString();
		if(code==Global.RIGHT_CODE){
			JSONObject resultInfo = JsonTool.getJSON("resultInfo", res);
			logger.debug("=========driver_waybill_statue-resultInfo========="+resultInfo);
			if(resultInfo!=null){
				int status = resultInfo.getIntValue("status");
				if(status==2||status==20){
					String waybillid = resultInfo.getString("waybillid");
					response.sendRedirect("/weixin/ToWaybillDetail.html?wayBillId="+waybillid);
				}
			}
		}/*else{
			throw new MessageException(reason);
		}*/
		
		logger.debug("|||||||||||||||||||||coreDubug1019|||||||||||||||||||");
		JSONObject jsonParam = new JSONObject();
		jsonParam.put("barcode", barCode);
		jsonParam.put("resourceid", uId);
		logger.debug("==========checkBarcode=============>:"+barCode);
		logger.debug("==========checkBarcode=============>:"+uId);
		String result = RequestPost(request, response, jsonParam.toJSONString(), CHECKBARCODEURL);
		//状态码为200跳转到绑定条码首页
		code = JsonTool.getStatus("resultCode", result);
		reason= JsonTool.getObject("reason", result).toString();
		if(code==Global.RIGHT_CODE){
			response.sendRedirect("/weixin/toPage.html?page=barCodeAfter&bindCode="+barCode);
		}else if(code==Global.RIGHT_BIND_CODE){//跳转到定位详情界面
			JSONObject resultInfo = JsonTool.getJSON("resultInfo", result);
			logger.debug("=========isBind========="+resultInfo);
			//Old version code
			/*request.getSession().setAttribute("waybillid",resultInfo.getIntValue("id"));
			request.getSession().setAttribute("barCode",barCode);
			request.getSession().setAttribute("orderSummary",resultInfo.getString("orderSummary"));
			request.getSession().setAttribute("userId",userId);
			JSONObject customerJson = resultInfo.getJSONObject("customer");
			request.getSession().setAttribute("customer",customerJson);
			response.sendRedirect("/weixin/toPage.html?page=positionInfo")*/
			request.getSession().setAttribute("userId",uId);
			request.getSession().setAttribute("subscribe", subscribe);
			request.getSession().setAttribute("waybill", resultInfo);
			response.sendRedirect("/weixin/toPage.html?page=positionInfoNew");
		}else if(code == Global.END_BIND_CODE){
			throw new MessageException(reason);
		}else if(code == Global.PARAM_CODE){
			throw new MessageException(reason);
		}else if(code == Global.NO_PERMISSION){
			throw new MessageException(reason);
		}else if(code == Global.WRONG_CODE){
			throw new MessageException(reason);
		}else{
			throw new MessageException(Global.CONNECT_ERROR);
		}
	}

	/**
	 * initConfig(初始化配置)
	 * 
	 * @param ApiConfig
	 * @throws Exception 
	 * @Exception 异常对象
	 */
	private static ApiConfig initConfig(){
		try{
			ApiConfig ac = new ApiConfig();
			// 配置微信 API 相关常量
			ac.setToken("");
			ac.setAppId(Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPID")));
			ac.setAppSecret(Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPSECRET")));
	
			/**
			 * 是否对消息进行加密，对应于微信平台的消息加解密方式： 1：true进行加密且必须配置 encodingAesKey
			 * 2：false采用明文模式，同时也支持混合模式
			 */
			ac.setEncryptMessage(false);
			ac.setEncodingAesKey(encodingAESKey);
			return ac;
		}catch(Exception e){
			logger.error("=============获取initConfig========异常",e);
		}
		return null;
	}

	/**
	 * 跳转到绑定手机号界面
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/tobindPhone")
	public String tobindPhone(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		logger.debug("|||||||||||||||||||||coreDubug1020|||||||||||||||||||");
		logger.debug("=========tobindPhone=============");
		request.setAttribute("id", getSessionUser(request).getId()+"");
		logger.debug("=============userId================"+getSessionUser(request).getId()+"");
		if(vlidateSessionId(request, request.getParameter("state"))){
			return "bindphonePc";
		}
		return "bindPhone";
	}
	
	/**
	 * 内部扫描功能逻辑(暂无使用)
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/internalScan")
	public void internalScan(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		User user = getSessionUser(request);
		if(null != user){
			String barCode = request.getParameter("barCode");//获取扫描条码号
			// 上报位置
			checkBarcode(request, response, barCode);
		}else{
			logger.error("session user is null");
			//userAuth(request, response);
		}
	}
	
	/**
	 * 权限检测
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/CheckRolePermission")
	public @ResponseBody String CheckRolePermission(HttpServletRequest request,
			HttpServletResponse response,String checkURI,Integer wayBillId) throws Exception{
		//检测组的角色权限
		RoleCheckInterceptor roleCheckInterceptor = new RoleCheckInterceptor();
		roleCheckInterceptor.setCacheManger(cacheManger);
		boolean havePermission = roleCheckInterceptor.checkUserRolePermissionByURIName(checkURI,wayBillId,getSessionUser(request).getId());
		logger.debug("=========CheckRolePermission输出权限boolean============="+havePermission);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("havePermission", havePermission);
		return jsonObject.toJSONString();
	}

	// 分享二维码加好友
	public void addMineCard(HttpServletRequest request,
			HttpServletResponse response, String groupId, Integer userId)
			throws Exception {
		logger.info("----mineCard------" + userId + groupId);
		GroupMembers g = new GroupMembers();
		g.setUserid(userId);
		g.setGroupid(Integer.valueOf(groupId));
		String json = JSONObject.toJSONString(g);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json,
				GROUP_MEMBER_ADD_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		int resultCode = httpresult.getIntValue("resultCode");// 状态码
		logger.info("---状态码：---" + resultCode);
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		String resultInfo = httpresult.getString("resultInfo");
		logger.info("--------resultInfo-----------" + resultInfo);
		if(Global.RIGHT_CODE==resultCode){
			//操作成功
			//为该用户在组中设定一个默认角色
			int roleid = 4;
			new RolePermissionUtils().setDefaultRoleForUser(getSessionUser(request).getId(),Integer.parseInt(groupId),roleid);
			//将用户权限信息更新到缓存中
    		UserRole userRole = new UserRole();
    		userRole.setUserid(getSessionUser(request).getId());
    		userRole.setGroupid(Integer.parseInt(groupId));
			RolePermission rolePermission = getRoleByUserAndGroup(userRole, request, response);
			Map<String,String> strMap = cacheManger.getAllWithHashKey("user"+getSessionUser(request).getId());
			logger.info("---cacheManger.strMap：---" + strMap.size());
			strMap.put(groupId,JSONObject.toJSONString(rolePermission));
			cacheManger.setHashKeyValues("user"+getSessionUser(request).getId(), strMap);
			request.setAttribute("forward_FLag", true);
			request.getRequestDispatcher("/weixin/mine/mineResouce.html").forward(request, response);
			//response.sendRedirect("/weixin/mine/mineResouce.html");
		}else{
			throw new MessageException(reason);
		}
	}
	
	private RolePermission getRoleByUserAndGroup(UserRole userRole, HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, IOException, HttpException {
		String json = JSONObject.toJSONString(userRole);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, USER_ROLE_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		String resultInfo = httpresult.getString("resultInfo");
		logger.info("--------resultInfo-----------" + resultInfo);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
		    logger.info("---返回信息：---" + data);
		    return JSONObject.parseObject(data.toString(), RolePermission.class);
		}else{
			return null;
		}
	}
	// 获取用户信息判断是否关注
	private int getSubscribe(String openId){
		int subscribe=0;
		ApiConfigKit.setThreadLocalApiConfig(apiConfig);//初始化
		ApiResult userInfo = UserApi.getUserInfo(openId);
		if (userInfo.isSucceed()) {
			String userStr = userInfo.toString();
			subscribe = JSON.parseObject(userStr).getIntValue("subscribe");//公众关注状态，1:已关注，0:取消关注
			logger.debug("weixinUserInfo===========subscribe============>:" + subscribe);
		}
		return subscribe;
	}
}
