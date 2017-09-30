package trace.interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.redis.ICacheMangerTarget;

import trace.exception.MessageException;
import trace.util.PropertiesUtils;
import trace.util.RolePermissionUtils;
import ycgwl.track.entity.GroupRolePermission;
import ycgwl.track.entity.Permission;
import ycgwl.track.entity.User;
import ycgwl.track.entity.UserRole;
import ycgwl.track.entity.Waybill;

public class RoleCheckInterceptor {
	private static Logger logger = Logger.getLogger(RoleCheckInterceptor.class);
	private RolePermissionUtils rolePermissionUtils; 
	private ICacheMangerTarget cacheManger;
	private static String WAYBILL_QUERY_GROUPID_URL;
	private static String RESOURCEGEOUP_CHECK_URL;
	static{
		try {
			PropertiesUtils propertiesUtils = new PropertiesUtils();
			WAYBILL_QUERY_GROUPID_URL = propertiesUtils.getStringByKey("waybill_query_groupId_url","resource.properties");
			RESOURCEGEOUP_CHECK_URL = propertiesUtils.getStringByKey("resourceGroup_check_url","resource.properties");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * @discription 通过request请求检查用户组中权限，在拦截器中使用
	 * @param  HttpServletRequest
	 * @return boolean
	 * @throws Exception 
	 * @Exception 异常对象
	 */
	public boolean checkUserRolePermission(HttpServletRequest request) throws Exception {
		String requestURI = request.getRequestURI();
		if((null==getSessionUser(request)||(StringUtils.isEmpty(getSessionUser(request).getMobilephone())))
				||(requestURI.contains("ToWaybillDetail.html")&&request.getParameter("from")!=null)){
			//如果没登录或者请求的是分享链接，则不作判定
			return true;
		}
		Integer userid = getSessionUser(request).getId();
		Integer wayBillId = null;
		if(request.getParameter("wayBillId")!=null){
			wayBillId = Integer.parseInt(request.getParameter("wayBillId").toString());
		}
		if(requestURI.contains("ReceiptUp.html")){
			return checkUserRolePermissionByURIName("ReceiptUp",wayBillId,userid);
		}else if(requestURI.contains("ExceptionUp.html")){
			return checkUserRolePermissionByURIName("ExceptionUp",wayBillId,userid);
		}else if(requestURI.contains("confirmArrive.html")){
			return checkUserRolePermissionByURIName("confirmArrive",wayBillId,userid);
		}

		return true;
	}
	
	/**
	 * @discription 通过请求关键字请求检查用户组中权限，在jsp中异步调用时使用
	 * @param  checkURI,wayBillId,userid
	 * @return boolean
	 * @throws Exception 
	 * @Exception 异常对象
	 */
	public boolean checkUserRolePermissionByURIName(String checkURI,Integer wayBillId,Integer userid) throws Exception {
		Integer groupid = getGroupidByWayBillId(wayBillId);
		if(!isGroupMember(groupid,userid)){
			//如果不是组中的人，直接放行
			return true;
		}
		return checkPermission(userid,groupid,checkURI);
	}

	/**
	 * @throws Exception 
	 * @discription 检测用户所在组的角色中是否含有该操作的权限
	 * */
	private boolean checkPermission(Integer userid,Integer groupid,String permissionCode) throws Exception{
		//获取用户所有组的权限Map
		//通过用户id查询出用户所有组相关的角色
		rolePermissionUtils = new RolePermissionUtils(cacheManger);
		Map<Integer,GroupRolePermission> rpMap = rolePermissionUtils.getRoleMap(userid);
		GroupRolePermission groupRolePermission = rpMap.get(groupid);//通过groupid拿到该组该用户对应的角色
		if(groupRolePermission==null){
			//说明在该组还没有被分配权限，或者是组长，直接放行
			logger.info("no-groupRolePermission-----rpMapSize:"+rpMap.size());
			return true;
		}
		if(groupRolePermission.getPermissionList()!=null){
			List<Permission> pList = groupRolePermission.getPermissionList();
			for(int i=0;i<pList.size();i++){//判断角色包含的权限中有没有该操作的权限
				logger.info("Permission["+i+"]:"+pList.get(i).getPermissionCode());
				if(pList.get(i).getPermissionCode().equals(permissionCode)){
					return true;
				}
			}
		}
		
		return false;//没有权限则不能通过
	}
	
	/**
	 * @throws Exception 
	 * @discription 通过wayBillId获取groupid信息
	 * */
	private Integer getGroupidByWayBillId(Integer wayBillId) throws Exception{
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("id", wayBillId);
		String json=jsonObject.toJSONString();
		
		logger.info("传输数据:" + json);
		String entity = httpClientPost(json,WAYBILL_QUERY_GROUPID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---返回信息：---" + resultInfo);
			Waybill waybill = JSONObject.parseObject(resultInfo, Waybill.class);
            return waybill.getGroupid();
		}
		return null;
	}

	protected User getSessionUser(HttpServletRequest request) throws Exception {
		return null != request.getSession().getAttribute("user") ? (User) request.getSession().getAttribute("user"): null;
	}
	
	public String httpClientPost(String json, String url) throws Exception {
        logger.debug("jsonObject----------------------->" + json);
        logger.debug("url----------------------->" + url);
        HttpClient httpClient = new HttpClient();
        final PostMethod postMethod = new PostMethod(url);
        postMethod.getParams().setContentCharset("UTF-8");
        postMethod.addRequestHeader("Content-Type", "application/json; charset=UTF-8");
        StringRequestEntity requestEntity = new StringRequestEntity(json, "application/json", "UTF-8");
        postMethod.setRequestEntity(requestEntity);
        httpClient.executeMethod(postMethod);
        String entity = postMethod.getResponseBodyAsString();
        return entity;
    }
	
	public boolean isGroupMember(Integer groupid,Integer userid) throws Exception {
		//查询一下该用户是否是该任务单资源组的成员，取标识符返回给页面（控制确认收货按钮）
		boolean resultFlag = false;
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("groupid", groupid);
		jsonObject.put("resourceid", userid);
		String json = JSONObject.toJSONString(jsonObject);
		logger.info("---传输数据：---" + json);
		String entity = httpClientPost(json, RESOURCEGEOUP_CHECK_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---返回信息：---" + resultInfo);
			String flag = JSONObject.parseObject(resultInfo,String.class);
			resultFlag = Boolean.parseBoolean(flag);
		}
		return resultFlag;
	}

	public void setCacheManger(ICacheMangerTarget cacheManger) {
		this.cacheManger=cacheManger;
	}
}
