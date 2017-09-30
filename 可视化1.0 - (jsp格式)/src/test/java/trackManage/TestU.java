package trackManage;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;


public class TestU {
	
	public static void main(String arg[]){
		String s = "http://ksh.ycgwl.com/index.html";
		try {
			String r = URLEncoder.encode(s,"UTF-8");
			System.out.println(r); 
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*String url = "http://172.16.36.16:21888/user/login";
		JSONObject json = new JSONObject();
		json.put("ip", "172.16.246.11");
		json.put("data",ToolUtil.getStringDate());
		json.put("pageNo",1);
		json.put("pageSize",10);
		json.put("userid", "41");
		Waybill waybill = new Waybill();
		waybill.setUserid(135);
		PageModel<Waybill> page = new PageModel<Waybill>();
		// 设置默认分页
		page.setPageSize(20);
		page.setPageNo(1);
		page.setObj(waybill);
		String json = JSONObject.toJSONString(page);
		json.put("openid", "oCe2Q1WRxQboOMPKpMKwYdi1LbDM");
		try {
			String res = RequestUtil.RequestPost(json.toJSONString(), url);
			System.out.println(res);
		} catch (Exception e) {
			e.printStackTrace();
		}*/
	}
}
