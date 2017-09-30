package trace.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ycgwl.core.Global;
import com.ycgwl.core.JsonTool;
import com.ycgwl.redis.ICacheMangerTarget;

import trace.exception.MessageException;
import trace.util.RolePermissionUtils;
import ycgwl.track.entity.Group;
import ycgwl.track.entity.GroupMembers;
import ycgwl.track.entity.ResourcseApp;
import ycgwl.track.entity.RolePermission;
import ycgwl.track.entity.User;
import ycgwl.track.entity.UserRole;

/*
 * 我的资源模块功能
 * @Author yangc
 * */
@Controller
@RequestMapping("/weixin")
public class MineController extends BaseController {

    @Value("${resourceGroup_list_url}")
    private String RESOURCEGROUP_LIST_URL;

    @Value("${resourceGroup_detail_url}")
    private String RESOURCEGROUP_DETAIL_URL;

    @Value("${resourceGroup_add_url}")
    private String RESOURCEGROUP_ADD_URL;

    @Value("${resourceGroup_edit_url}")
    private String RESOURCEGROUP_EDIT_URL;

    @Value("${group_member_delete_url}")
    private String GROUP_MEMBER_DELETE_URL;

    @Value("${resource_app_url}")
    private String RESOURCE_APP_URL;

    @Value("${user_update_url}")
    private String USER_UPDATE_URL;

    @Value("${get_ticket_url}")
    private String GET_TICKET_URL;
    
    @Value("${userQueryURL}")
    private String USER_QUERY_URL;
    
    @Value("${user_role_url}")
    private String USER_ROLE_URL;
    
    @Value("${add_user_role_url}")
    private String ADD_USER_ROLE_URL;
    
    @Value("${role_all_list_url}")
    private String ROLE_ALL_LIST_URL;

    @Resource
    ICacheMangerTarget cacheManger;

    // 我的模块
    @RequestMapping(value = "/mine")
    public String mine() {
        return "mine";
    }

    // 我的资源列表
    @RequestMapping(value = "/mine/mineResouce")
    public String mineResouce(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("----mineResouce------");
        getResourceGroup(model, request, response);
        return "mineResouce";
    }

    private void getResourceGroup(Model model, HttpServletRequest request, HttpServletResponse response)
            throws UnsupportedEncodingException, IOException, HttpException {
        User u = (User) request.getSession().getAttribute("user");
        Group group = new Group();
        group.setUserid(u.getId());
        String json = JSONObject.toJSONString(group);
        logger.info("传输数据:" + json);
        String entity = RequestPost(request, response, json, RESOURCEGROUP_LIST_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "---------" + reason);
        if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
            JSONArray goodsArray = httpresult.getJSONArray("resultInfo");
            logger.info("---返回信息：---" + goodsArray);
            if (goodsArray != null) {
                List<Group> groupList = JSON.parseArray(goodsArray.toJSONString(), Group.class);
                model.addAttribute("groupList", groupList);
            } else {
                model.addAttribute("groupList", null);
            }
        } else {
            model.addAttribute("groupList", null);
        }
    }

    // 进入我的资源申请
    @RequestMapping(value = "/mine/enterMineResApply")
    public String enterMineResApply(Integer type, Integer groupId, Model model, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        logger.info("----enterMineResApply------" + type + groupId);
        if (type == 1) {
            // 全部资源组
            getResourceGroup(model, request, response);
        } else if (type == 2) {
            // 单个资源组
            List<Group> groupList = new ArrayList<Group>();
            Group group = new Group();
            group.setId(groupId);
            String json = JSONObject.toJSONString(group);
            logger.info("---传输数据：---" + json);
            String entity = RequestPost(request, response, json, RESOURCEGROUP_DETAIL_URL);
            JSONObject httpresult = JSONObject.parseObject(entity);
            String resultCode = httpresult.getString("resultCode");// 状态码
            String reason = httpresult.getString("reason");// 返回信息
            logger.info(resultCode + "-------------------" + reason);
            String resultInfo = httpresult.getString("resultInfo");
            logger.info("--------resultInfo-----------" + resultInfo);
            if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
                JSONObject data = (JSONObject) httpresult.get("resultInfo");
                logger.info("---返回信息：---" + data);
                group = JSONObject.parseObject(data.toString(), Group.class);
                groupList.add(group);
            } else {
                throw new MessageException("获取失败！");
            }
            model.addAttribute("groupList", groupList);
        }
        model.addAttribute("type", type);
        return "mineResApply";
    }

    // 我的资源申请
    @RequestMapping(value = "/mine/mineResApply", method = RequestMethod.POST)
    public String mineResApply(ResourcseApp resourcseApp, Model model, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        logger.info("----mineResApply------" + resourcseApp);
        String json = JSONObject.toJSONString(resourcseApp);
        logger.info("---传输数据：---" + json);
        Integer groupid = resourcseApp.getGroupid();
        // 返回资源组详情
        getResourceDetail(groupid, model, request, response);
        String entity = RequestPost(request, response, json, RESOURCE_APP_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        String resultInfo = httpresult.getString("resultInfo");
        logger.info("--------resultInfo-----------" + resultInfo);
        if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
            model.addAttribute("appStatus", "success");
        } else {
            model.addAttribute("appStatus", "fail");
        }
        model.addAttribute("resourceApp", resourcseApp);
        return "mineResApplyStatus";
    }

    // 进入我的资源组添加
    @RequestMapping(value = "/mine/mineResAdd")
    public String mineResAdd() {
        return "mineResAdd";
    }

    // 我的资源组添加
    @RequestMapping(value = "/mine/addResGroup", method = RequestMethod.POST)
    @ResponseBody
    public String addResGroup(String groupName, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        logger.info("----addResGroup------" + groupName);
        User u = (User) request.getSession().getAttribute("user");
        Group group = new Group();
        group.setUserid(u.getId());
        group.setGroupName(groupName);
        String json = JSONObject.toJSONString(group);
        logger.info("---传输数据：---" + json);
        String entity = RequestPost(request, response, json, RESOURCEGROUP_ADD_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        if(Global.RIGHT_CODE == Integer.parseInt(resultCode)){
        	JSONObject data = (JSONObject) httpresult.get("resultInfo");
            logger.info("--------resultInfo-----------" + data);
            group = JSONObject.parseObject(data.toString(), Group.class);
            //为该用户在组中设定一个默认角色（组长）
            int roleid = 1;
    		new RolePermissionUtils().setDefaultRoleForUser(u.getId(),group.getId(),roleid);
    		//将用户权限信息更新到缓存中
    		UserRole userRole = new UserRole();
    		userRole.setUserid(u.getId());
    		userRole.setGroupid(group.getId());
			RolePermission rolePermission = getRoleByUserAndGroup(userRole, request, response);
			Map<String,String> strMap = cacheManger.getAllWithHashKey("user"+u.getId());
			logger.info("---cacheManger.strMap：---" + strMap.size());
			strMap.put(group.getId().toString(),JSONObject.toJSONString(rolePermission));
			cacheManger.setHashKeyValues("user"+u.getId(), strMap);
        }
        return reason;
    }

    // 我的资源组详情
    @RequestMapping(value = "/mine/detailResGroup")
    public String detailResGroup(Integer id, Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        logger.info("----detailResGroup------" + id);
        getResourceDetail(id, model, request, response);
        return "mineProjectTeam";
    }
    
    private void getResourceDetail(Integer id, Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	User u = (User) request.getSession().getAttribute("user");
        Group group = new Group();
        group.setId(id);
        String json = JSONObject.toJSONString(group);
        logger.info("---传输数据：---" + json);
        String entity = RequestPost(request, response, json, RESOURCEGROUP_DETAIL_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        String resultInfo = httpresult.getString("resultInfo");
        logger.info("--------resultInfo-----------" + resultInfo);
        if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
            JSONObject data = (JSONObject) httpresult.get("resultInfo");
            logger.info("---返回信息：---" + data);
            group = JSONObject.parseObject(data.toString(), Group.class);
            List<GroupMembers> list = group.getList();
            Integer membersId  = null;
            UserRole userRole = null;
            Map<Integer,RolePermission> roleMap = new HashMap<Integer,RolePermission>();
            for (GroupMembers groupMembers : list) {
            	//加载每个组员在组中的角色
            	Integer userid = groupMembers.getUserid();
            	userRole = new UserRole();
            	userRole.setUserid(userid);
            	userRole.setGroupid(groupMembers.getGroupid());
            	RolePermission rolePermission = getRoleByUserAndGroup(userRole, request, response);
            	roleMap.put(userid, rolePermission);
            	
				if(membersId==null&&userid.equals(u.getId())){
					membersId = groupMembers.getId();
				}
			}
            model.addAttribute("roleMap", roleMap);
            model.addAttribute("group", group);
            model.addAttribute("membersId", membersId);
        } else {
            model.addAttribute("group", null);
        }
    }

	private RolePermission getRoleByUserAndGroup(UserRole userRole, HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, IOException, HttpException {
		String json = JSONObject.toJSONString(userRole);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, USER_ROLE_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		String resultInfo = httpresult.getString("resultInfo");
		logger.info("--------resultInfo-----------" + resultInfo);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
		    logger.info("---返回信息：---" + data);
		    return JSONObject.parseObject(data.toString(), RolePermission.class);
		}else{
			return null;
		}
	}

    // 进入删除资源组成员
    @RequestMapping(value = "/mine/enterDeleteGroupUser")
    public String enterDeleteGroupUser(Integer id, Model model, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        logger.info("----enterDeleteGroupUser------" + id);
        getResourceDetail(id, model, request, response);
        return "minePTDelete";
    }

    // 删除资源组成员
    @RequestMapping(value = "/mine/deleteGroupUser", method = RequestMethod.POST)
    @ResponseBody
    public String deleteGroupUser(Integer id, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        logger.info("----deleteGroupUser------" + id);
        User u = (User) request.getSession().getAttribute("user");
        GroupMembers g = new GroupMembers();
        g.setId(id);
        g.setUserid(u.getId());
        String json = JSONObject.toJSONString(g);
        logger.info("---传输数据：---" + json);
        String entity = RequestPost(request, response, json, GROUP_MEMBER_DELETE_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        String resultInfo = httpresult.getString("resultInfo");
        logger.info("--------resultInfo-----------" + resultInfo);
        if (Global.RIGHT_CODE == Integer.valueOf(resultCode)) {
            return "success";
        } else {
            return reason;
        }
    }

    // 进入编辑资源组
    @RequestMapping(value = "/mine/enterEditResGroupName")
    public String enterEditResGroup(Integer id, Model model) {
        logger.info("----enterEditResGroupName------" + id);
        model.addAttribute("groupId", id);
        return "minePTNameEdit";
    }

    // 编辑资源组名称
    @RequestMapping(value = "/mine/editResGroupName", method = RequestMethod.POST)
    @ResponseBody
    public String editResGroupName(String groupName, Integer groupId, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        logger.info("----editResGroupName------" + groupName + groupId);
        User u = (User) request.getSession().getAttribute("user");
        Group group = new Group();
        group.setUserid(u.getId());
        group.setId(groupId);
        group.setGroupName(groupName);
        String json = JSONObject.toJSONString(group);
        logger.info("---传输数据：---" + json);
        String entity = RequestPost(request, response, json, RESOURCEGROUP_EDIT_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        String resultInfo = httpresult.getString("resultInfo");
        logger.info("--------resultInfo-----------" + resultInfo);
        return reason;
    }

    // 进入资源组二维码
    @RequestMapping(value = "/mine/entermMineCard")
    public String enterMineCard(Integer id, Model model) throws Exception {
        logger.info("----enterMineCard------" + id);
        model.addAttribute("groupId", id);
        return "mineCard";
    }
    
    // 关注公众号
    @RequestMapping(value = "/mine/attentionUs")
    public String attentionUS(){
        logger.info("----attentionUS------");
        return "attentionUS";
    }
    
    
    @RequestMapping(value = "/mine/enterEdit/{type}")
    public String enterEditResGroup(@PathVariable String type, HttpServletRequest request, Model model) {
        logger.info("----enterEdit------" + type);
        User u = (User) request.getSession().getAttribute("user");
        model.addAttribute("user", u);
        return type;
    }

    // 编辑我的姓名
    @RequestMapping(value = "/mine/editName", method = RequestMethod.POST)
    @ResponseBody
    public String editName(String name, HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("----editName------" + name);
        User u = (User) request.getSession().getAttribute("user");
        u.setUname(name);
        String json = JSONObject.toJSONString(u);
        logger.info("---传输数据：---" + json);
        String entity = RequestPost(request, response, json, USER_UPDATE_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        String resultInfo = httpresult.getString("resultInfo");
        logger.info("--------resultInfo-----------" + resultInfo);
        return reason;
    }

    // 编辑我的手机号
    @RequestMapping(value = "/mine/editPhone", method = RequestMethod.POST)
    @ResponseBody
    public String editPhone(String phone, String code, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        logger.info("----editPhone------" + phone + code);
        User u = (User) request.getSession().getAttribute("user");
        // 验证码不为空
        String validCode = cacheManger.getWithkey("valid_code_" + u.getId());
        if (StringUtils.isNotEmpty(validCode)) {
            if (validCode.equals(code)) {
                u.setMobilephone(phone);
                String json = JSONObject.toJSONString(u);
                logger.info("---传输数据：---" + json);
                String entity = RequestPost(request, response, json, USER_UPDATE_URL);
                JSONObject httpresult = JSONObject.parseObject(entity);
                String resultCode = httpresult.getString("resultCode");// 状态码
                String reason = httpresult.getString("reason");// 返回信息
                logger.info(resultCode + "-------------------" + reason);
                String resultInfo = httpresult.getString("resultInfo");
                logger.info("--------resultInfo-----------" + resultInfo);
                return httpresult.toJSONString();
            } else {
                return JsonTool.toJsonObject(Global.PARAM_CODE, "验证码不正确");
            }
        } else {
            return JsonTool.toJsonObject(Global.PARAM_CODE, "验证码过期，请重新获取");
        }
    }
    
    //查看组员详细信息
    @RequestMapping(value = "/mine/groupUserDetail")
    public String groupUserDetail(Integer userid,Integer groupid,Integer guserid,String roleName,Integer roleid,Model model,
    		HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        logger.info("----userId------" + userid);
        User user = new User();
        user.setId(userid);
        String json = JSONObject.toJSONString(user);
        logger.info("---传输数据：---" + json);
        String entity = RequestPost(request, response, json, USER_QUERY_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        String resultInfo = httpresult.getString("resultInfo");
        logger.info("--------resultInfo-----------" + resultInfo);
        if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
            JSONObject data = (JSONObject) httpresult.get("resultInfo");
            logger.info("---返回信息：---" + data);
            user = JSONObject.parseObject(data.toString(), User.class);
            model.addAttribute("UserDetail", user);
        } else {
            model.addAttribute("UserDetail", null);
        }
        
        //回显数据
        model.addAttribute("roleName", roleName);
        model.addAttribute("roleid", roleid);
        model.addAttribute("groupid", groupid);
        model.addAttribute("guserid", guserid);
        return "mineMemberDetail";
    }
    
    //前往修改组员角色页面
    @RequestMapping(value = "/mine/editGroupUserRole")
    public String editGroupUserRole(Integer userid,Integer groupid,Integer roleid,Model model,
    		HttpServletRequest request, HttpServletResponse response)
    				throws Exception {
    	//获取所有角色以及角色对应的权限信息
    	Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("id", userid);
		String json = JSONObject.toJSONString(paraMap);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, ROLE_ALL_LIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String jsonResult = httpresult.get("resultInfo").toString();
			logger.info("------返回结果:-------" + jsonResult);
			List<RolePermission> rolePermissionList = JSONObject.parseArray(jsonResult.toString(), RolePermission.class);
			model.addAttribute("rolePermissionList", rolePermissionList);
		} else {
			model.addAttribute("rolePermissionList", null);
		} 
		model.addAttribute("roleid", roleid);
    	model.addAttribute("userid", userid);
    	model.addAttribute("groupid", groupid);
    	return "mineMemberRole";
    }
    
    //为资源组的组员设置角色
    @RequestMapping(value = "/mine/addUserRole")
    public String addUserRole(UserRole userRole,Model model,
    		HttpServletRequest request, HttpServletResponse response)
    				throws Exception {
    	userRole.setCreatetime(new Date());
    	logger.info("----UserRole------" + userRole);
        String json = JSONObject.toJSONString(userRole);
        logger.info("---传输数据：---" + json);
        String entity = RequestPost(request, response, json, ADD_USER_ROLE_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			//获取新的用户权限信息
			RolePermission rolePermission = getRoleByUserAndGroup(userRole, request, response);
			//将用户更新的权限信息更新到缓存中
			Map<String,String> strMap = cacheManger.getAllWithHashKey("user"+userRole.getUserid());
			logger.info("---cacheManger.strMap：---" + strMap.size());
			strMap.put(userRole.getGroupid().toString(),JSONObject.toJSONString(rolePermission));
			cacheManger.setHashKeyValues("user"+userRole.getUserid(), strMap);
			return detailResGroup(userRole.getGroupid(),model,request,response);
		} else {
			throw new MessageException(reason);
		} 
    }
    
}
