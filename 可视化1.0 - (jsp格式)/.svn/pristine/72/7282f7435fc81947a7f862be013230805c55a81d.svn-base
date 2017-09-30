package trace.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.ycgwl.core.DateUtils;
import com.ycgwl.core.Global;

import trace.domain.QueryVo;
import trace.exception.MessageException;
import ycgwl.track.entity.Group;
import ycgwl.track.entity.PageModel;
import ycgwl.track.entity.Total;
import ycgwl.track.entity.User;
import ycgwl.track.entity.Waybill;

/**
 * 名称：DailyTotalController 描述： 每日统计 创建人：yangc 创建时间：2017年7月26日 上午9:36:31
 * 
 * @version
 */
@Controller
public class DailyTotalController extends BaseController {

	@Value("${dailyTotalUrl}")
	private String DAILY_TOTAL_LIST_URL;

	@Value("${resourceGroup_list_url}")
	private String RESOURCEGROUP_LIST_URL;

	@Value("${resourceGroup_detail_url}")
	private String RESOURCEGROUP_DETAIL_URL;

	@Value("${wayBillPageListURL}")
	private String WAYBILL_PAGELIST_URL;

	@RequestMapping("/dailyTotal")
	public String toPage(Waybill waybill, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User u = (User) request.getSession().getAttribute("user");
		// 查询资源组
		Group group = new Group();
		group.setUserid(u.getId());
		String json2 = JSONObject.toJSONString(group);
		String entity2 = RequestPost(request, response, json2, RESOURCEGROUP_LIST_URL);
		JSONObject httpresult2 = JSONObject.parseObject(entity2);
		String resultCode2 = httpresult2.getString("resultCode");// 状态码
		List<Group> groupList = new ArrayList<>();
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode2)) {
			JSONArray goodsArray = httpresult2.getJSONArray("resultInfo");
			if (goodsArray != null) {
				groupList = JSON.parseArray(goodsArray.toJSONString(), Group.class);
				model.addAttribute("groups", groupList);
			} else {
				model.addAttribute("groups", null);
			}
		}
		if (waybill == null) {
			waybill = new Waybill();
		}
		logger.debug("======dailyTotal========" + waybill);
		waybill.setUserid(u.getId());
		 
		if (StringUtils.isEmpty(waybill.getBindStartTime()) || StringUtils.isEmpty(waybill.getBindEndTime())) {
			waybill.setBindStartTime(DateUtils.getMonthFirstDay());
			waybill.setBindEndTime(DateUtils.getMonthLastDay());
		}
		if (waybill.getGroupid() == null) {
			if (groupList.size() == 0) {
				model.addAttribute("total", null);
				return "dailyTotal";
			} else {
				waybill.setGroupid(groupList.get(0).getId());// 默认选择第一个资源组
			}
		}
		//去除空格
		if (StringUtils.isNotEmpty(waybill.getCustomerName())) {
			waybill.setCustomerName(waybill.getCustomerName().trim());
		}
		String json = JSONObject.toJSONString(waybill);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, DAILY_TOTAL_LIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---结果：---" + data);
			Total total = JSON.parseObject(data.toJSONString(), Total.class);
			model.addAttribute("total", total);
		} else {
			model.addAttribute("total", null);
		}
		// 查询条件回显
		model.addAttribute("waybill", waybill);
		return "dailyTotal";
	}
	
	@RequestMapping("go/dailyTotals")
	public String godailyTotal(Waybill waybill, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User u = (User) request.getSession().getAttribute("user");
		// 查询资源组
		Group group = new Group();
		group.setUserid(u.getId());
		String json2 = JSONObject.toJSONString(group);
		String entity2 = RequestPost(request, response, json2, RESOURCEGROUP_LIST_URL);
		JSONObject httpresult2 = JSONObject.parseObject(entity2);
		String resultCode2 = httpresult2.getString("resultCode");// 状态码
		List<Group> groupList = new ArrayList<>();
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode2)) {
			JSONArray goodsArray = httpresult2.getJSONArray("resultInfo");
			if (goodsArray != null) {
				groupList = JSON.parseArray(goodsArray.toJSONString(), Group.class);
				model.addAttribute("groups", groupList);
			} else {
				model.addAttribute("groups", null);
			}
		}
		LocalDate localDate = LocalDate.now();
		
		if(waybill.getSelectYear() == null || waybill.getSelectYear() <= 0){
			waybill.setSelectYear(localDate.getYear());
		}
		if(waybill.getSelectMonth() == null || waybill.getSelectMonth() <= 0){
			waybill.setSelectMonth(localDate.getMonthValue());
		}
		model.addAttribute("waybill", waybill);
		return "/wx/total/dailyTotal";
	}
	@RequestMapping("weixin/dailyTotal")
	//@RequestMapping("dailyTotals")
	public String dailyTotal(Waybill waybill, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User u = (User) request.getSession().getAttribute("user");
		logger.debug("======dailyTotal========" + waybill);
		waybill.setUserid(u.getId());
		// 查询资源组
		Group group = new Group();
		group.setUserid(u.getId());
		String json2 = JSONObject.toJSONString(group);
		String entity2 = RequestPost(request, response, json2, RESOURCEGROUP_LIST_URL);
		JSONObject httpresult2 = JSONObject.parseObject(entity2);
		String resultCode2 = httpresult2.getString("resultCode");// 状态码
		List<Group> groupList = new ArrayList<>();
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode2)) {
			JSONArray goodsArray = httpresult2.getJSONArray("resultInfo");
			if (goodsArray != null) {
				groupList = JSON.parseArray(goodsArray.toJSONString(), Group.class);
				model.addAttribute("groups", groupList);
			} else {
				model.addAttribute("groups", null);
			}
		}
		if (waybill.getGroupid() == null) {
			if (groupList.size() == 0) {
				model.addAttribute("total", null);
				return "/wx/total/dailyTotal";
			} else {
				waybill.setGroupid(groupList.get(0).getId());// 默认选择第一个资源组
			}
		}
		
		LocalDate localDate = LocalDate.now();
		if(waybill.getSelectYear() == null || waybill.getSelectYear() <= 0){
			waybill.setSelectYear(localDate.getYear());
		}
		if(waybill.getSelectMonth() == null || waybill.getSelectMonth() <= 0){
			waybill.setSelectMonth(localDate.getMonthValue());
		}
		localDate = LocalDate.of(waybill.getSelectYear(), waybill.getSelectMonth(), 1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		waybill.setBindStartTime(localDate.format(formatter));
		waybill.setBindEndTime(localDate.with(TemporalAdjusters.lastDayOfMonth()).format(formatter));
		//去除空格
		if (StringUtils.isNotEmpty(waybill.getCustomerName())) {
			waybill.setCustomerName(waybill.getCustomerName().trim());
		}
		String json = JSONObject.toJSONString(waybill);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, DAILY_TOTAL_LIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---结果：---" + data);
			Total total = JSON.parseObject(data.toJSONString(), Total.class);
			model.addAttribute("total", total);
		} else {
			model.addAttribute("total", null);
		}
		// 查询条件回显
		model.addAttribute("waybill", waybill);
		return "/wx/total/dailyTotal";
	}
	
	// 统计详情列表
	@RequestMapping("/weixin/dailyDetail/{groupid}/{date}")
	//@RequestMapping("/dailyDetails/{groupid}/{date}")
	public String dailyTotalDetail(@PathVariable Integer groupid, @PathVariable String date, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("-----------traceList------------" + groupid + date);
		User u = (User) request.getSession().getAttribute("user");
		Waybill waybill = new Waybill();
		waybill.setUserid(u.getId());
		waybill.setGroupid(groupid);
		waybill.setBindtime(date);
		PageModel<Waybill> page = new PageModel<Waybill>();
		// 设置默认分页
		page.setPageSize(Integer.MAX_VALUE);
		page.setPageNo(1);
		page.setObj(waybill);
		String json = JSONObject.toJSONString(page);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, WAYBILL_PAGELIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---返回信息：---" + data);
			PageInfo<Waybill> pageInfo = JSONObject.parseObject(data.toString(), PageInfo.class);
			model.addAttribute("page", pageInfo);
		} else {
			model.addAttribute("page", null);
		}
		getGroupById(model, request, response, groupid);
		model.addAttribute("waybill", waybill);
		return "/wx/total/dailyTotalDetail";
	}
	
	// 统计详情搜索列表
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "weixin/dailyDetailSearch", method = RequestMethod.POST)
	//@RequestMapping(value = "/dailyDetailSearchs", method = RequestMethod.POST)
	public String dailyDetailSearch(QueryVo qVo, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User u = (User) request.getSession().getAttribute("user");
		Waybill waybill = qVo.getWaybill();
		logger.info("-----------traceList------------" + waybill);
		waybill.setUserid(u.getId());
		PageModel<Waybill> page = new PageModel<Waybill>();
		// 设置默认分页
		page.setPageSize(Integer.MAX_VALUE);
		page.setPageNo(1);
		page.setObj(waybill);
		String json = JSONObject.toJSONString(page);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, WAYBILL_PAGELIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---返回信息：---" + data);
			PageInfo<Waybill> pageInfo = JSONObject.parseObject(data.toString(), PageInfo.class);
			model.addAttribute("page", pageInfo);
		} else {
			model.addAttribute("page", null);
		}

		getGroupById(model, request, response, waybill.getGroupid());

		// 搜索条件回显
		model.addAttribute("waybill", waybill);
		return "/wx/total/dailyTotalDetail";
	}
	

	// 统计详情列表
	@SuppressWarnings("unchecked")
	@RequestMapping("/dailyDetail/{groupid}/{date}")
	public String trace(@PathVariable Integer groupid, @PathVariable String date, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("-----------traceList------------" + groupid + date);
		User u = (User) request.getSession().getAttribute("user");
		Waybill waybill = new Waybill();
		waybill.setUserid(u.getId());
		waybill.setGroupid(groupid);
		waybill.setBindtime(date);
		PageModel<Waybill> page = new PageModel<Waybill>();
		// 设置默认分页
		page.setPageSize(10);
		page.setPageNo(1);
		page.setObj(waybill);
		String json = JSONObject.toJSONString(page);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, WAYBILL_PAGELIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---返回信息：---" + data);
			PageInfo<Waybill> pageInfo = JSONObject.parseObject(data.toString(), PageInfo.class);
			model.addAttribute("page", pageInfo);
		} else {
			model.addAttribute("page", null);
		}
		
		getGroupById(model, request, response, groupid);
		
		model.addAttribute("waybill", waybill);
		return "dailyTotalDetail";
	}

	// 统计详情搜索列表
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/dailyDetailSearch", method = RequestMethod.POST)
	public String searchtrace(QueryVo qVo, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User u = (User) request.getSession().getAttribute("user");
		Waybill waybill = qVo.getWaybill();
		logger.info("-----------traceList------------" + waybill);
		waybill.setUserid(u.getId());
		PageModel<Waybill> page = new PageModel<Waybill>();
		// 设置默认分页
		page.setPageSize(qVo.getPageSize()==null?10:qVo.getPageSize());
		page.setPageNo(qVo.getPageNo());
		page.setObj(waybill);
		String json = JSONObject.toJSONString(page);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, WAYBILL_PAGELIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "---------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---返回信息：---" + data);
			PageInfo<Waybill> pageInfo = JSONObject.parseObject(data.toString(), PageInfo.class);
			model.addAttribute("page", pageInfo);
		} else {
			model.addAttribute("page", null);
		}

		getGroupById(model, request, response, waybill.getGroupid());

		// 搜索条件回显
		model.addAttribute("waybill", waybill);
		return "dailyTotalDetail";
	}

	private void getGroupById(Model model, HttpServletRequest request, HttpServletResponse response, Integer id)
			throws Exception {
		// 根据id查询资源组
		Group group = new Group();
		group.setId(id);
		String json2 = JSONObject.toJSONString(group);
		String entity2 = RequestPost(request, response, json2, RESOURCEGROUP_DETAIL_URL);
		JSONObject httpresult2 = JSONObject.parseObject(entity2);
		String resultCode2 = httpresult2.getString("resultCode");// 状态码
		String resultInfo2 = httpresult2.getString("resultInfo");
		logger.info("--------resultInfo2-----------" + resultInfo2);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode2)) {
			JSONObject data2 = (JSONObject) httpresult2.get("resultInfo");
			group = JSONObject.parseObject(data2.toString(), Group.class);
			model.addAttribute("group", group);
		} else {
			model.addAttribute("group", null);
		}
	}
	
	
}
