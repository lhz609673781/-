package trace.exception;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONException;
import com.ycgwl.core.Global;

/**
 * 异常处理器的自定义的实现类
 */
public class GlobalExceptionResolver implements HandlerExceptionResolver {
	private static Logger logger = Logger.getLogger(GlobalExceptionResolver.class);

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object obj, Exception e) {
		String ctimestr = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
		// 记录日志
		String req_url = request.getRequestURI();
		logger.error("============统一异常==============：request 【"+ req_url+"】parameter【"+ showParams(request) +"】", e);
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("exception_time", ctimestr);
		// 判断异常为类型
		if (e instanceof MessageException) {
			// 预期异常
			MessageException me = (MessageException) e;
			mv.addObject("error", me.getMsg());
		}else if(e instanceof IllegalArgumentException){
			mv.addObject("error", Global.PARAMS_ERROR);
		}else if(e instanceof JSONException){
			mv.addObject("error", Global.JSONERROR);
		}else if(e instanceof IOException){
			mv.addObject("error", Global.IOERROR);
		}else if(e instanceof ParseException){
			mv.addObject("error", Global.PARSEERROR);
		}else if(e instanceof IndexOutOfBoundsException){
			mv.addObject("error", Global.INDEXOUTERROR);
		}else if(e instanceof ClassCastException){
			mv.addObject("error", Global.CLASSCASTERROR);
		}else{
			mv.addObject("error", "未知错误");
		}
		if(req_url.contains("/weixin")){
			mv.setViewName("appError");
		}else{
			mv.setViewName("error");
		}
		return mv;
	}

	private Map<String, Object> showParams(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    map.put(paramName, paramValue);
                }
            }else {
            	 map.put(paramName, paramValues);
            }
        }
        return map;
    }
}
