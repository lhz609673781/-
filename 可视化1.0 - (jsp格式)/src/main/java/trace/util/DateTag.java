package trace.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
/**
 * 自定义的时间处理标签
 *
 */
public class DateTag extends TagSupport {
    /**
     * 
     */
    private static final long serialVersionUID = -8683014812426654300L;
    private String value;//对应jstl表达式中的value值
    private String pattern;//对应表达式中的pattern指定的时间格式

    public int doStartTag() throws JspException {
        String vv = String.valueOf(value);
        long time = Long.valueOf(vv);
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(time);
        SimpleDateFormat dateformat = new SimpleDateFormat(pattern);
        String s = dateformat.format(c.getTime());
        try {
            pageContext.getOut().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return super.doStartTag();
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getPattern() {
        return pattern;
    }

    public void setPattern(String pattern) {
        this.pattern = pattern;
    }


}