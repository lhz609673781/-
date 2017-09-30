package trace.controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import trace.util.CheckUtil;

@Controller
@RequestMapping("/wxloc")
public class WxLocController extends BaseController {

	@RequestMapping("/loc")
	public String trace(String code) throws Exception {
		 logger.info("-----------wxloc------------"+code);
		 if ("123456789".equals(code)) {
			 return "unBindCode";
		}else{
			return "weixinLoc";
		}
	}
	@RequestMapping(value="/weixin_get")
	public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 接收微信服务器以Get请求发送的4个参数
        String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");
        String echostr = request.getParameter("echostr");
        logger.debug("signature============================>:"+signature);
        logger.debug("timestamp============================>:"+timestamp);
        logger.debug("nonce============================>:"+nonce);
        logger.debug("echostr============================>:"+echostr);
        PrintWriter out = response.getWriter();
        if (CheckUtil.checkSignature(signature, timestamp, nonce,echostr)) {
            out.print(echostr);        // 校验通过，原样返回echostr参数内容
            logger.debug("echostr============out================>:"+echostr);
        }
    }
	@RequestMapping(value="/weixin_post",method=RequestMethod.POST)
    public String doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	doGet(request, response);
    	return "login";
    }

}
