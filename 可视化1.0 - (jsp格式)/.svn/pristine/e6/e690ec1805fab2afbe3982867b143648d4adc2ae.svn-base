package trace.interceptor;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.jboss.netty.util.internal.ConcurrentHashMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.HashKit;
import com.jfinal.weixin.sdk.api.AccessTokenApi;
import com.jfinal.weixin.sdk.api.ApiConfig;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.jfinal.weixin.sdk.api.JsTicket;
import com.jfinal.weixin.sdk.api.JsTicketApi;
import com.jfinal.weixin.sdk.api.JsTicketApi.JsApiType;
import com.ycgwl.core.Base64Utils;
import com.ycgwl.util.HttpUtils;

import trace.controller.WeixinOAuthController;
import trace.util.PropertiesUtils;
import trace.util.WxConstant;
import ycgwl.track.entity.User;

public class LoginInterceptor implements HandlerInterceptor{
	private static Logger logger = Logger.getLogger(WeixinOAuthController.class);
	//private static RoleCheckInterceptor roleCheckInterceptor = new RoleCheckInterceptor();
	
	private static final Map<String, Object> cache = new ConcurrentHashMap<String, Object>();

	private static final String CACHE_WEINXIN_ACCESS_TOKEN_KEY = "CACHE_WEINXIN_ACCESS_TOKEN_KEY";
	private static final String WECHATURL = "https://api.weixin.qq.com/cgi-bin";
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		logger.debug("|||||||||||||||||||||coreDubug000|||||||||||||||||||");
		long start = System.currentTimeMillis();
		logger.debug("=================preHandle==================="+start);
		//判断用户是否登录
		String requestURI = request.getRequestURI();
		/*String param = request.getParameter("weixin");
		param = param!=null?param:"";
		logger.debug("param================>"+param);*/
		logger.debug("requestURI================>"+requestURI);
		if (requestURI.contains("/user/register")//注册与绑定手机号和微信登录放行
				|| requestURI.contains("/user/register_weixin") 
				|| requestURI.contains("weixinAuth.html")
				|| requestURI.contains("weixinCallback.html")) {
			logger.debug("|||||||||||||||||||||coreDubug001|||||||||||||||||||");
			return true;
		}else if(requestURI.contains("/weixin")){
			request.getSession().setMaxInactiveInterval(12*60*60);
			logger.debug("|||||||||||||||||||||coreDubug002|||||||||||||||||||");
			//公众号进入逻辑处理、分享
			if((null==getSessionUser(request)||(StringUtils.isEmpty(getSessionUser(request).getMobilephone())))
					||(requestURI.contains("ToWaybillDetail.html")&&request.getParameter("from")!=null)){
				logger.debug("|||||||||||||||||||||coreDubug003|||||||||||||||||||");
				if(requestURI.contains("toHome.html")){
					logger.debug("|||||||||||||||||||||coreDubug004|||||||||||||||||||");
					request.getRequestDispatcher(request.getContextPath() +"/weixin/weixinAuth.html?type="+WxConstant.BINDCODE).forward(request, response);
				}else if(requestURI.contains("myTask.html")){
					logger.debug("|||||||||||||||||||||coreDubug005|||||||||||||||||||");
					request.getRequestDispatcher(request.getContextPath() +"/weixin/weixinAuth.html?type="+WxConstant.TOLOCATIONLIST).forward(request, response);
				}else if(requestURI.contains("mineResouce.html")){//我的资源组
					logger.debug("|||||||||||||||||||||coreDubug006|||||||||||||||||||");
					request.getRequestDispatcher("/weixin/weixinAuth.html?type="+WxConstant.MINERESOUCE).forward(request, response);
					//response.sendRedirect(request.getContextPath() +"/weixin/weixinAuth.html?type="+WxConstant.MINERESOUCE);
				}else if(requestURI.contains("mine.html")){//我的
					logger.debug("|||||||||||||||||||||coreDubug002Mine|||||||||||||||||||");
					request.getRequestDispatcher(request.getContextPath() +"/weixin/weixinAuth.html?type="+WxConstant.MINE).forward(request, response);
				}else if(requestURI.contains("waybill.html")){//任务单
					logger.debug("|||||||||||||||||||||coreDubug00Mine|||||||||||||||||||");
					request.getRequestDispatcher("/weixin/weixinAuth.html?type="+WxConstant.WAILLBILL).forward(request, response);
//					response.sendRedirect(request.getContextPath() +"/weixin/weixinAuth.html?type="+WxConstant.WAILLBILL);
				}else if(requestURI.contains("ToWaybillDetail.html")&&request.getParameter("from")!=null){
					logger.debug("|||||||||||||||||||||coreDubug007|||||||||||||||||||");
					String strFrom = request.getParameter("from").toString();
					if(WxConstant.SINGLFLAG.equals(strFrom) || WxConstant.GROUPFLAG.equals(strFrom)){//如果来自分享(分享给朋友、分享到群)
						logger.debug("|||||||||||||||||||||coreDubug008|||||||||||||||||||");
						String wayBillId=request.getParameter("wayBillId");
						String userId=request.getParameter("userId");
						request.getRequestDispatcher(request.getContextPath() + "/weixin/weixinAuth.html?type="+WxConstant.SHAREDETAILS
								+"&wayBillId="+wayBillId+"&shareId="+userId).forward(request, response);
					}
				}else if(requestURI.contains("searchmoreLocationList.html") ){
					request.getRequestDispatcher("/weixin/weixinAuth.html?type="+WxConstant.POSITIONLIST).forward(request, response);
				}else if(requestURI.contains("ReceiptUp.html") ){
					request.getRequestDispatcher("/weixin/weixinAuth.html?type="+WxConstant.UPLOADRECEIPT).forward(request, response);
				}else if(requestURI.contains("tobindPhone.html")){
					return true;
				}else if(requestURI.contains("sendSMS") || requestURI.contains("waybilldata.html")){
					return true;
				}else{
					logger.debug("|||||||||||||||||||||coreDubug009|||||||||||||||||||");
					request.getRequestDispatcher(request.getContextPath() +"/weixin/weixinAuth.html?type="+WxConstant.TOHOME).forward(request, response);
					//request.setAttribute("", requestURI);
					//throw new MessageException(Global.NOT_LOGIN);
				}
				long dif = System.currentTimeMillis()-start;
				logger.error("==========dif001=================="+dif);
				return false;
			}
			long dif = System.currentTimeMillis()-start;
			logger.error("==========dif002=================="+dif);
			return true;//此处放行不要被覆盖
		}
		if(!requestURI.contains("/login")){
			if(null == getSessionUser(request)){
				response.sendRedirect(request.getContextPath() + "/login.jsp");
				return false;
			}
		}
		
		//检测组的角色权限(这里注释是因为权限在jsp中异步控制了，但是不代表这里以后不进行拦截，所以注释留着)
		/*roleCheckInterceptor.setCacheManger(cacheManger);
		boolean havePermission = roleCheckInterceptor.checkUserRolePermission(request);
		if(!havePermission){
			throw new MessageException(Global.HAVE_NO_PERMISSION);
		}*/
		
		return true;
	}
	
	/**
	 * getTicketInfo(获取微信临时票据)
	 * @param   name
	 * @return String    request
	 * @throws Exception 
	 * @Exception 异常对象
	 */
	private void getTicketInfo(HttpServletRequest request) throws Exception {
		ApiConfigKit.setThreadLocalApiConfig(getApiConfig());
		JsTicket jsApiTicket = JsTicketApi.getTicket(JsApiType.jsapi);
		String jsapi_ticket = jsApiTicket.getTicket();
		String access_token = AccessTokenApi.getAccessTokenStr();//getToken();
		logger.debug("===========access_token==================>"+access_token);
		String nonce_str = create_nonce_str();
		// 注意 URL 一定要动态获取，不能 hardcode.
		String url = "http://" + request.getServerName() // 服务器地址
		// + ":"
		// + getRequest().getServerPort() //端口号
		+ request.getContextPath() // 项目名称
		+ request.getServletPath();// 请求页面或其他地址
		String qs = request.getQueryString(); // 参数
		if (qs != null) {
			url = url + "?" + (request.getQueryString());
		}
		String timestamp = create_timestamp();
		// 这里参数的顺序要按照 key 值 ASCII 码升序排序
		//注意这里参数名必须全部小写，且必须有序
		String  str = "jsapi_ticket=" + jsapi_ticket +
				"&noncestr=" + nonce_str +
				"&timestamp=" + timestamp +
				"&url=" + url;

		String signature = HashKit.sha1(str);

		request.setAttribute("appId", ApiConfigKit.getApiConfig().getAppId());
		request.setAttribute("nonceStr", nonce_str);
		request.setAttribute("timestamp", timestamp);
		request.setAttribute("url", url);
		request.setAttribute("signature", signature);
		request.setAttribute("jsapi_ticket", jsapi_ticket);
		request.setAttribute("access_token", access_token);
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		String requestURI = request.getRequestURI();
		logger.debug("=================postHandle===================");
		long start= System.currentTimeMillis();
		if(requestURI.contains("/weixin") && !requestURI.contains("/weixinAuth.html") && !requestURI.contains("weixinCallback.html") ){
			getTicketInfo(request);
			long dif = System.currentTimeMillis()-start;
			logger.error("==========dif003=================="+dif);
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.debug("==================afterCompletion===============");
	}

	/**
	 * 如果要支持多公众账号，只需要在此返回各个公众号对应的 ApiConfig 对象即可 可以通过在请求 url 中挂参数来动态从数据库中获取
	 * ApiConfig 属性值
	 * @throws Exception 
	 */
	private static ApiConfig getApiConfig() throws Exception{
		ApiConfig ac = new ApiConfig();
		// 配置微信 API 相关常量
		ac.setToken("");
		ac.setAppId(Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPID")));
		ac.setAppSecret(Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPSECRET")));
		logger.debug("===========appid==================>"+ac.getAppId());
		/**
		 *  是否对消息进行加密，对应于微信平台的消息加解密方式：
		 *  1：true进行加密且必须配置 encodingAesKey
		 *  2：false采用明文模式，同时也支持混合模式
		 */
		ac.setEncryptMessage(false);
		//ac.setEncodingAesKey("");
		return ac;
	}

	private static String create_timestamp() {
		return Long.toString(System.currentTimeMillis() / 1000);
	}

	private static String create_nonce_str() {
		return UUID.randomUUID().toString();
	}
	
	protected User getSessionUser(HttpServletRequest request) throws Exception {
		return null != request.getSession().getAttribute("user") ? (User) request.getSession().getAttribute("user"): null;
	}
	
	
	
	/**
	 * 获取token
	 * @return
	 */
	public String getToken() {
		Object access_token = cache.get(CACHE_WEINXIN_ACCESS_TOKEN_KEY);
		logger.debug("get token 失效需要重新获取1" + access_token );
		if(null == access_token){
			access_token = token();
			logger.debug("get token 失效需要重新获取2" + access_token );
			cache.put(CACHE_WEINXIN_ACCESS_TOKEN_KEY, access_token);
		}else{
			try {
				//监测有效性
				String result =  HttpUtils.get(url(WECHATURL, "getcallbackip?access_token="+ access_token ));
				JSONObject jsonObject = JSONObject.parseObject(result);
				Object ip_list = jsonObject.get("ip_list");
				if(null == ip_list){
					access_token = token();
					cache.put(CACHE_WEINXIN_ACCESS_TOKEN_KEY, access_token);
				}
			} catch (Exception e) {
				logger.error("get token exception", e);
			}
		}
		return String.valueOf(access_token);
	}

	private String token(){
		try {
			String appid = Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPID"));
			String secret = Base64Utils.decryptBASE64(PropertiesUtils.getValue("APPSECRET"));
			
			logger.debug("appid : " +  appid +", secret : "+ secret);
			
			logger.debug("get token 失效需要重新获取" +  DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			String response = HttpUtils.get(url(WECHATURL, "token?grant_type=client_credential&appid="+ appid +"&secret="+ secret ));
			logger.debug("get token " + response);
			if(StringUtils.isNotBlank(response)){
				JSONObject jsonObject = JSONObject.parseObject(response);
				return jsonObject.getString("access_token");
			}
		} catch (Exception e) {
			logger.error("get token exception", e);
		}
		return null;
	}
	
	private String url(String baseUrl, String subUrl){
		if(baseUrl.endsWith("/")){
			return baseUrl + subUrl;
		}
		return baseUrl +"/"+ subUrl;
	}
}
