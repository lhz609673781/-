package trace.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.core.ResponseUtil;
import com.ycgwl.redis.ICacheMangerTarget;

import trace.exception.MessageException;
import trace.util.WxConstant;
import ycgwl.track.entity.User;

@Controller
public class BaseController {
    static Logger logger = Logger.getLogger(BaseController.class);

    private String errorMessage;

    @Value("${userRegisterURL}")
    private String USER_REGISTER_URL;

    @Value("${bindPhoneURL}")
    private String BIND_PHONE_URL;

    @Resource
    ICacheMangerTarget cacheManger;

    public void cleanSession(HttpServletRequest request) {
        if (null != request) {
            System.out.print("clean==========================================>");
            request.getSession().removeAttribute("errorMessage");
        }
    }

    /**
     * todoData(数据请求处理)
     * 
     * @param param,request,response
     * @param String
     * @throws Exception
     * @Exception 异常对象
     */
    public String todoData(String param, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 用户注册和绑定手机号特殊处理
        logger.debug("===========todoData===========start");
        String code = JsonTool.getObject("code", param).toString();
        if (StringUtils.isNotEmpty(code)) {
            logger.debug("===========todoData===========start");
            USER_REGISTER_URL = BIND_PHONE_URL;// 绑定手机号请求url
        }
        Integer uId = getSessionUser(request).getId();
        // 验证码不为空'
        logger.debug("uId==============todoData==============>"+uId);
        String validCode = cacheManger.getWithkey("valid_code_" + uId);
        logger.debug("validCode==============todoData==============>"+validCode);
        if (StringUtils.isNotEmpty(validCode)) {

            if (validCode.equals(code)) {
                String entity = RequestPost(request, response, param, USER_REGISTER_URL);
                JSONObject httpresult = JSONObject.parseObject(entity);
                int resultCode = httpresult.getIntValue("resultCode");// 状态码
                logger.info("---状态码：---" + resultCode);
                String reason = httpresult.getString("reason");// 返回信息
                logger.info(resultCode + "-------------------" + reason);
                if (Global.RIGHT_CODE == resultCode && !USER_REGISTER_URL.equals(BIND_PHONE_URL)) {
                    String resultInfo = httpresult.getString("resultInfo");
                    request.getSession().setAttribute("userNotExists", null);
                    request.getSession().setAttribute("user", JSONObject.parseObject(resultInfo, User.class));
                }
                return entity;
            } else {
                return JsonTool.toJsonObject(Global.PARAM_CODE, "验证码不正确");
            }
        } else {
            return JsonTool.toJsonObject(Global.PARAM_CODE, "验证码过期，请重新获取");
        }
    }
    
    /**
     * userRegister(用户注册处理)
     * 
     * @param param,request,response
     * @param String
     * @throws Exception
     * @Exception 异常对象
     */
    public String userRegister(String param, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String entity = RequestPost(request, response, param, USER_REGISTER_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        int resultCode = httpresult.getIntValue("resultCode");// 状态码
        logger.info("---状态码：---" + resultCode);
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        if (Global.RIGHT_CODE == resultCode) {
            String resultInfo = httpresult.getString("resultInfo");
            request.getSession().setAttribute("userNotExists", null);
            request.getSession().setAttribute("user", JSONObject.parseObject(resultInfo, User.class));
        }
        return entity;
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
    public String RequestPost(HttpServletRequest request, HttpServletResponse response, String json, String url)
            throws UnsupportedEncodingException, IOException, HttpException {
//        String ip = ToolUtil.getIpAddress(request);
//        String date = ToolUtil.getStringDate();
        /*
         * JSONObject jsonObject = JSONObject.parseObject(json);
         * jsonObject.put("ip", ip); jsonObject.put("date", date); String
         * newjson =
         * jsonObject.toJSONString();//URLEncoder.encode(jsonObject.toJSONString
         * (), Global.CHARSET);
         */
        logger.debug("jsonObject----------------------->" + json);
        HttpClient httpClient = new HttpClient();
        final PostMethod postMethod = new PostMethod(url);
        postMethod.getParams().setContentCharset("UTF-8");
        postMethod.addRequestHeader("Content-Type", "application/json; charset=UTF-8");
        StringRequestEntity requestEntity = new StringRequestEntity(json, "application/json", "UTF-8");
        postMethod.setRequestEntity(requestEntity);
        httpClient.executeMethod(postMethod);
        int statusCode = postMethod.getStatusCode();
        if(statusCode == 200){
        	return postMethod.getResponseBodyAsString();
        }else{
        	return ResponseUtil.toJsonObject(Global.WRONG_CODE,Global.CONNECT_ERROR);
        }
    }

    /**
     * 连接服务(带文件流的请求)
     *
     * @param response
     * @param json
     * @param url
     * @return
     * @throws UnsupportedEncodingException
     * @throws IOException
     * @throws HttpException
     */
    public String MultiPartRequestPost(String urlString, List<File> files, String receiptstr)
            throws UnsupportedEncodingException, IOException, HttpException {
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost postRequest = new HttpPost(urlString);
        HttpResponse response = null;
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        try {
            // Set various attributes
            for (File file2 : files) {
                builder.addBinaryBody("attachment", file2);
                builder.addTextBody("fileName", file2.getName());
            }
            builder.addTextBody("fileDescription", receiptstr);

            // builder.addTextBody("type", "APP");
            // FileBody fileBody = new FileBody(file2);// 把文件转换成流对象FileBody
            // builder.addPart("attachment", fileBody);

            HttpEntity entity = builder.build();
            postRequest.setEntity(entity);
            response = client.execute(postRequest);
            // Verify response if any
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        InputStream is = response.getEntity().getContent();
        StringBuffer sb = new StringBuffer();
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        String line = "";
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        return sb.toString();
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(HttpServletRequest request, String errorMessage) {
        this.errorMessage = errorMessage;
        request.getSession().setAttribute("errorMessage", errorMessage);
    }

    protected User getSessionUser(HttpServletRequest request) throws Exception {
        return null != request.getSession().getAttribute("user") ? (User) request.getSession().getAttribute("user")
                : null;
    }

    /**
     * 判断sessionId是否一致
     * 
     * @param request
     * @param sessionId
     * @return
     */
    boolean vlidateSessionId(HttpServletRequest request, String sessionId) {
        String currSessionId = request.getSession().getId();
        logger.debug("curren_SessionId-------------->" + currSessionId);
        logger.debug("sessionId-------------->" + sessionId);
        if (currSessionId.equals(sessionId)) {
            cacheManger.setKeyValue("state", currSessionId);
            cacheManger.expire("state", WxConstant.WEIXINTIMEOUT);
            return true;
        } else {
            return false;
        }
    }
}
