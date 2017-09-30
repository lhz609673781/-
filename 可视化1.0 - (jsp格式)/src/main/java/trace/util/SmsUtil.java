package trace.util;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;



import org.apache.commons.lang3.StringUtils;

import trace.domain.TestUser;

import com.alibaba.fastjson.JSONObject;


/**        
 * 名称：SmsUtil    
 * 描述：    发短信工具类
 * 创建人：yangc    
 * 创建时间：2017年7月14日 上午10:58:24    
 * @version        
 */
public class SmsUtil {
	private static final String userName = "Thinkbadman";
	private static final String passWord = "111111";
	private static final String roles = "sample";
	//private static final String loginUrl = "http://10.68.52.17:8009/login";
	//private static final String sendMesUrl = "http://10.68.52.17:8009/SMSSingeSendMessageMy";
	private static final String loginUrl = "http://175.102.129.175:8009/login";
	private static final String sendMesUrl = "http://175.102.129.175:8009/SMSSingeSendMessageMy";
	
	public static String sendMessage(String mobile,String content) throws Exception {
		TestUser testUser = new TestUser();
		testUser.setUserName(userName);
		testUser.setPassWord(passWord);
		testUser.setRoles(roles);
		String json = JSONObject.toJSONString(testUser);
		String entity = testHttp(json, loginUrl);
		System.out.println("返回结果1：" + entity);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String loginToken = httpresult.getString("loginToken");
		
		TestUser testUser2 = new TestUser();
		testUser2.setUserType("");
		testUser2.setMobile(mobile);
		testUser2.setContent(content + "【远成物流】");
		String json2 = JSONObject.toJSONString(testUser2);
		String result = testSendMessage(loginToken, json2, sendMesUrl);
		System.out.println("返回结果2：" + result);
		JSONObject httpresult2 = JSONObject.parseObject(result);
		String errorMessage = httpresult2.getString("errorMessage");
		if (StringUtils.isNotEmpty(errorMessage)) {
			return errorMessage;
		}
		return "ok";
	}

	private static String testHttp(String json, String url) throws Exception {
		HttpClient httpClient = new HttpClient();
		final PostMethod postMethod = new PostMethod(url);
		postMethod.getParams().setContentCharset("UTF-8");
		postMethod.addRequestHeader("Content-Type",
				"application/json; charset=UTF-8");
		StringRequestEntity requestEntity = new StringRequestEntity(json,
				"application/json", "UTF-8");
		postMethod.setRequestEntity(requestEntity);
		httpClient.executeMethod(postMethod);
		String entity = postMethod.getResponseBodyAsString();
		return entity;
	}
	
	private static String testSendMessage(String loginToken,String json, String url) throws Exception {
		HttpClient httpClient = new HttpClient();
		final PostMethod postMethod = new PostMethod(url);
		postMethod.getParams().setContentCharset("UTF-8");
		postMethod.addRequestHeader("Content-Type",
				"application/json; charset=UTF-8");
		postMethod.addRequestHeader("auth-token",loginToken);
		StringRequestEntity requestEntity = new StringRequestEntity(json,
				"application/json", "UTF-8");
		postMethod.setRequestEntity(requestEntity);
		httpClient.executeMethod(postMethod);
		String entity = postMethod.getResponseBodyAsString();
		return entity;
	}

}
