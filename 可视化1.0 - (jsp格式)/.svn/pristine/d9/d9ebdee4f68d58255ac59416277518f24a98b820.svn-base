package trace.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.redis.ICacheMangerTarget;

import trace.exception.MessageException;
import ycgwl.track.entity.GroupRolePermission;
import ycgwl.track.entity.UserRole;

/**
 * @discription 用户角色相关工具类
 * @author zyg
 * @created 2017年7月31日11:26:21
 */
public class RolePermissionUtils{
	private static Logger logger = Logger.getLogger(RolePermissionUtils.class);
	private static String USER_ALL_ROLE_URL;
	private static String USER_ADD_ROLE_URL;
	static{
		try {
			PropertiesUtils propertiesUtils = new PropertiesUtils();
			USER_ALL_ROLE_URL = propertiesUtils.getStringByKey("userAllRoleURL","resource.properties");
			USER_ADD_ROLE_URL = propertiesUtils.getStringByKey("userAddRoleURL","resource.properties");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    ICacheMangerTarget cacheManger;
    
    public RolePermissionUtils() {}
	
	public RolePermissionUtils(ICacheMangerTarget cacheManger) {
		this.cacheManger=cacheManger;
	}

	/**
     * 
     * @discription 通过用户id查询出用户所有组相关的角色
     * @author zyg
     * @created 2017年7月31日11:27:41
     * @param id
     * @return Map<Integer,RolePermission>
     */
	public Map<Integer,GroupRolePermission> getRoleMap(Integer id) throws Exception {
		Map<Integer,GroupRolePermission> rpMap = new HashMap<Integer,GroupRolePermission>();
		if(cacheManger.getAllWithHashKey("user"+id)==null){
			//缓存中上无用户权限信息，有两种情况：
			//1.该用户为新用户，尚未加入任何组，所以没有分配权限
			//2.缓存已过期
			//上面的情况都需要重新从数据库加载用户的权限信息保存至缓存中
	        JSONObject jsonObject=new JSONObject();
			jsonObject.put("id", id);
			String json=jsonObject.toJSONString();
			
			logger.info("传输数据:" + json);
			String entity = httpClientPost(json,USER_ALL_ROLE_URL);
			JSONObject httpresult = JSONObject.parseObject(entity);
			String resultCode = httpresult.getString("resultCode");// 状态码
			String reason = httpresult.getString("reason");// 返回信息
			logger.info(resultCode + "---------" + reason);
			if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
				String resultInfo = httpresult.getString("resultInfo");
				logger.info("---返回信息：---" + resultInfo);
				List<GroupRolePermission> rpList = JSONObject.parseArray(resultInfo, GroupRolePermission.class);
				for(GroupRolePermission grp:rpList){
					rpMap.put(grp.getGroupid(), grp);
				}
				//由于redis的HashMap存储只支持Map<String,String>，所以这里进行转换后再存储至缓存
				Map<String,String> strMap = new HashMap<String,String>();
				for (Integer key : rpMap.keySet()) {
					strMap.put(key.toString(), JSONObject.toJSONString(rpMap.get(key)));
			    }
				cacheManger.setHashKeyValues("user"+id, strMap);//存储的key是user字符加上用户的唯一id
			}
		}else{
			//缓存中存在用户权限信息，不用从数据库取出，直接从缓存获取
			//由于redis的HashMap存储只支持Map<String,String>，所以这里进行转换后再返回给外部
			Map<String,String> strMap = cacheManger.getAllWithHashKey("user"+id);
			for (String key : strMap.keySet()) {
				rpMap.put(Integer.parseInt(key), JSONObject.parseObject(strMap.get(key),GroupRolePermission.class));
		    }
		}
		
		return rpMap;
	}
	
	/**
	 * @throws Exception 
	 * @discription 为用户设置默认角色
	 * */
	public void setDefaultRoleForUser(Integer userid, Integer groupid, int roleid) throws Exception{
		UserRole userRole = new UserRole();
		userRole.setUserid(userid);
		userRole.setRoleid(roleid);
		userRole.setGroupid(groupid);
		String json=JSONObject.toJSONString(userRole);
		
		logger.info("传输数据:" + json);
		String entity = httpClientPost(json,USER_ADD_ROLE_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE != Integer.parseInt(resultCode)) {
			throw new MessageException(reason);
		}
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
}
