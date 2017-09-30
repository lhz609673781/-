package trace.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WeChatController extends BaseController {
	/**
	 * 微信首页
	 * @param request
	 * @param response
	 * @return homeWeChat
	 * @throws Exception
	 */
	@RequestMapping(value="weixin/toHomeWeChat")
	public String toHome(HttpServletRequest request,HttpServletResponse response)throws Exception{
		logger.debug("======init========toHomeWeChat");
		return "homeWeChat";
	}
}
