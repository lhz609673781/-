package trace.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.ResponseUtil;

import trace.util.SmsUtil;
import ycgwl.track.entity.User;

@Controller
public class UserController extends BaseController {

    @Value("${userLoginURL}")
    private String USER_LOGIN_URL;

    // 设置过期时间10分钟
    private static final int CODE_VALID_SECONDS = 600;

    // 登录
    @RequestMapping(value = "/user/login")
    public String userLogin(User user, HttpServletRequest request, HttpServletResponse response) throws Exception {

        logger.info("-----------login------------" + user);
        String json = JSONObject.toJSONString(user);
        logger.info("传输数据:" + json);
        String entity = RequestPost(request, response, json, USER_LOGIN_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);

        if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
            String resultInfo = httpresult.getString("resultInfo");
            user = JSONObject.parseObject(resultInfo, User.class);
            request.getSession().setAttribute("userNotExists", null);
            request.getSession().setAttribute("user", user);
        } else if (Global.PARAM_CODE == Integer.parseInt(resultCode)) {
            request.getSession().setAttribute("userNotExists", user);
        }
        return "redirect:/index.html";
    }

    // 注册
    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public String userRegister(User user, HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("-----------register------------" + user);
        String json = JSONObject.toJSONString(user);
        todoData(json, request, response);
        return "redirect:/index.html";
    }

	@RequestMapping(value = "/user/register_weixin", method = RequestMethod.POST)
	public @ResponseBody String userRegisterWeixin(@RequestParam String param, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (param == null) {
			logger.error(Global.PARAMS_ERROR);
			return ResponseUtil.toJsonObject(Global.PARAM_CODE, Global.PARAMS_ERROR);
		}
		String entity = todoData(param, request, response);
		return entity;
	}

    // 退出登录
    @RequestMapping(value = "/user/logout")
    public String logout(HttpServletRequest request) {

        logger.info("-----------logout------------");
        request.getSession().removeAttribute("user");
        request.getSession().removeAttribute("userNotExists");
        return "redirect:/index.html";
    }

    // 首页
    @RequestMapping(value = "/index")
    public String index() {
        return "index";
    }

    // 发送短信
    @RequestMapping(value = "/user/sendSMS",method=RequestMethod.POST)
    @ResponseBody
    public String sendSMS(String mobile, HttpServletRequest request) throws Exception {
        logger.info("-----------sendSMS------------" + mobile);
        User u = (User) getSessionUser(request);
        String code = createRandomVcode();
        String result = SmsUtil.sendMessage(mobile, "您的验证码是" + code + "，请在页面中提交验证码完成验证，10分钟有效。");
        if ("ok".equals(result)) {
            cacheManger.setKeyValue("valid_code_" + u.getId(), code);
        } else {
            cacheManger.setKeyValue("valid_code_" + u.getId(), null);
        }
        cacheManger.expire("valid_code_" + u.getId(), CODE_VALID_SECONDS);
        return "ok";
    }

    // 生成随机数
    public static String createRandomVcode() {
        String vcode = "";
        for (int i = 0; i < 6; i++) {
            vcode = vcode + (int) (Math.random() * 9);
        }
        return vcode;
    }

    // 发送短信移动端
    // @RequestMapping(value
    // ="/user/sendSms2Mobile/{mobile}/{code}",method=RequestMethod.POST)
    // @ResponseBody
    // public KshResult sendSMS2Mobile(@PathVariable String mobile,
    // @PathVariable String code, HttpServletRequest request)
    // throws Exception {
    // logger.info("-----------sendSMS------------" + mobile + code);
    // if (StringUtils.isEmpty(mobile) || StringUtils.isEmpty(code)) {
    // return KshResult.build(400, "请求参数有误！");
    // }
    // String result = SmsUtil.sendMessage(mobile, "您的验证码是" + code +
    // "，请在页面中提交验证码完成验证，10分钟有效。");
    // if (!"ok".equals(result)) {
    // return KshResult.build(500, "发送失败，请重试!");
    // }
    // return KshResult.ok();
    // }
}
