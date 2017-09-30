package trace.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.ycgwl.core.DateUtils;
import com.ycgwl.core.Global;

import trace.domain.QueryVo;
import trace.exception.MessageException;
import ycgwl.track.entity.Barcode;
import ycgwl.track.entity.Customer;
import ycgwl.track.entity.CustomerGroup;
import ycgwl.track.entity.Group;
import ycgwl.track.entity.PageModel;
import ycgwl.track.entity.User;

//客戶信息ConTROLLER
@Controller
public class CustomerController extends BaseController {

	@Value("${addCustomerURL}")
	private String ADD_CUSTOMER_URL;

	@Value("${updateCustomerURL}")
	private String UPDATE_CUSTOMER_URL;

	@Value("${customerPageListURL}")
	private String CUSTOMER_PAGELIST_URL;

	@Value("${customerGroupByIdURL}")
	private String CUSTOMER_GROUP_BYID_URL;
	
	@Value("${customerByIdURL}")
	private String CUSTOMER_BYID_URL;

	@Value("${resourceGroup_list_url}")
	private String RESOURCEGROUP_LIST_URL;
	
	@Value("${customerListByGroupURL}")
    private String CUSTOMER_LIST_BYGROUP_URL;
	
	@Value("${resourceGroup_detail_by_barcode_url}")
    private String RESOURCEGROUP_DETAIL_BY_BARCODE_URL;
	
	// 客户信息列表查询
	@SuppressWarnings("unchecked")
	@RequestMapping("/customer")
	public String customer(QueryVo qv, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User u = (User) request.getSession().getAttribute("user");
		CustomerGroup customerGroup = qv.getCustomerGroup();
		if (customerGroup == null) {
			customerGroup = new CustomerGroup();
		}
		logger.info("-----------customerGroup------------" + customerGroup);
		customerGroup.setUserid(u.getId());
		PageModel<CustomerGroup> page = new PageModel<CustomerGroup>();
		// 设置默认分页
		page.setPageNo(qv.getPageNo());
		page.setPageSize(qv.getPageSize()==null?10:qv.getPageSize());
		page.setObj(customerGroup);
		String json = JSONObject.toJSONString(page);
		logger.info("传输数据:" + json);
		String entity = RequestPost(request, response, json, CUSTOMER_PAGELIST_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {

			JSONObject data = (JSONObject) httpresult.get("resultInfo");
			logger.info("---结果：---" + data);
			PageInfo<CustomerGroup> pageInfo = JSONObject.parseObject(data.toString(), PageInfo.class);
			model.addAttribute("page", pageInfo);
		} else {
			model.addAttribute("page", null);
		}
		//查询资源组
		Group group = new Group();
		group.setUserid(u.getId());
		String json2 = JSONObject.toJSONString(group);
		String entity2 = RequestPost(request, response, json2, RESOURCEGROUP_LIST_URL);
		JSONObject httpresult2 = JSONObject.parseObject(entity2);
		String resultCode2 = httpresult2.getString("resultCode");// 状态码
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode2)) {
			JSONArray goodsArray = httpresult2.getJSONArray("resultInfo");
			if (goodsArray != null) {
				List<Group> groupList = JSON.parseArray(goodsArray.toJSONString(), Group.class);
				model.addAttribute("groups", groupList);
			}else {
				model.addAttribute("groups", null);
			}
		}
		// 查询条件回显
		model.addAttribute("customerGroup", qv.getCustomerGroup());
		return "customInfo";
	}

	// 客户信息新增
	@RequestMapping(value = "/customer/add", method = RequestMethod.POST)
	public String add(CustomerGroup customerGroup, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		addCustomer(customerGroup, request, response);
		return "redirect:/customer.html";
	}

	// 客户信息修改
	@RequestMapping(value = "/customer/update", method = RequestMethod.POST)
	public String update(CustomerGroup customerGroup, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		updateCustomer(customerGroup, request, response);
		return "redirect:/customer.html";
	}

	// 客户findByID
	@RequestMapping(value = "/customer/findById", method = RequestMethod.POST)
	@ResponseBody
	public CustomerGroup findById(Integer id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.info("-----------findById------------" + id);
		CustomerGroup customerGroup = new CustomerGroup();
		customerGroup.setId(id);
		String json = JSONObject.toJSONString(customerGroup);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, CUSTOMER_GROUP_BYID_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("---结果：---" + resultInfo);
			CustomerGroup result = JSONObject.parseObject(resultInfo, CustomerGroup.class);
			return result;
		} else {
			return null;
		}
	}

	// 查询所有的资源组
	@RequestMapping(value = "/customer/findGroups", method = RequestMethod.POST)
	@ResponseBody
	public List<Group> findGroups(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
				return groupList;
			}
		}
		return null;
	}
	
	//查询客户列表
    @RequestMapping(value = "weixin/customerList")
    public String customerList(Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	String bindCode = request.getParameter("bindCode");
    //	Group group = getDroupByBarCode(bindCode, request, response);
    //	List<Customer> list=getCustomerList(request,response,group);
    //    model.addAttribute("customerList", list);
        if(request.getParameter("companyName")!=null){
        	//数据搜索回显
        	model.addAttribute("companyName", request.getParameter("companyName").toString());
        }
     //   model.addAttribute("group", group);//显示资源组名称
        //回显bindCode
        model.addAttribute("bindCode", bindCode);
        return "chooseCustom";
    }
    
    //查询客户列表
    @RequestMapping(value = "weixin/pageCustomer")
    public @ResponseBody List<Customer> pageCustomer(Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	return getCustomerList(request,response,null);
    }

    //获取用户列表(微信分页)
	private List<Customer> getCustomerList(HttpServletRequest request, HttpServletResponse response,Group group)
			throws UnsupportedEncodingException, IOException, HttpException {
		if(group==null){
			String bindCode = request.getParameter("bindCode");
	    	group = getDroupByBarCode(bindCode, request, response);
		}
    	CustomerGroup customerGroup = new CustomerGroup();
    	customerGroup.setGroupid(group.getId());
    	if(request.getParameter("companyName")!=null){
    		String companyName = request.getParameter("companyName");
    		customerGroup.setC_companyName(companyName);
    	}
    	if(request.getParameter("pageSize")!=null){
    		customerGroup.setSize(Integer.parseInt(request.getParameter("pageSize")));//一页五条
    	}else{
    		customerGroup.setSize(5);//默认从5开始
    	}
    	
    	if(request.getParameter("pageNo")!=null){
    		customerGroup.setNum(Integer.parseInt(request.getParameter("pageNo")));//获取页数
    	}else{
    		customerGroup.setNum(0);//默认从0开始
    	}
    	
        String json = JSONObject.toJSONString(customerGroup);
        logger.info("传输数据:" + json);
        String entity = RequestPost(request, response, json, CUSTOMER_LIST_BYGROUP_URL);
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "-------------------" + reason);
        if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
            String data = httpresult.getString("resultInfo");
            logger.info("---结果：---" + data);
            List<Customer> list = JSONObject.parseArray(data, Customer.class);
            return list;
        } else {
            return null;
        }
	}
    
    //选取客户跳转回绑定页面
    @RequestMapping(value = "weixin/chooseCustom")
    public String chooseCustom(Integer customerId,Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	//回显用户数据
    	Customer customer=getcustomeryId(customerId,request, response);
    	model.addAttribute("customer", customer);
        String bindCode = request.getParameter("bindCode");
        Group group = getDroupByBarCode(bindCode, request, response);
        model.addAttribute("group", group);
        //回显bindCode
        model.addAttribute("bindCode", bindCode);
        return "barCodeAfter";
    }
    
    //去添加客户页面
    @RequestMapping(value = "weixin/toAddCustom", method = RequestMethod.GET)
    public String toAddCustom(String bindCode,Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	//获取资源组信息
    	Group group = getDroupByBarCode(bindCode, request, response);
        model.addAttribute("group", group);
        
        //回显bindCode
        model.addAttribute("bindCode", bindCode);
        return "addCustom";
    }
    
    //添加客户
    @RequestMapping(value = "weixin/addCustom")
    public String addCustom(Customer customer,Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	User u = (User) request.getSession().getAttribute("user");
    	CustomerGroup customerGroup = new CustomerGroup();
    	customerGroup.setUserid(u.getId());
    	customerGroup.setCustomer(customer);
    	String bindCode = request.getParameter("bindCode");
    	Group group = getDroupByBarCode(bindCode, request, response);
    	customerGroup.setGroupid(group.getId());
    	addCustomer(customerGroup, request, response);
        //回显bindCode
        
        model.addAttribute("bindCode", bindCode);
        return "redirect:/weixin/customerList.html";
    }
    
    //去修改客户页面
    @RequestMapping(value = "weixin/toEditCustom", method = RequestMethod.GET)
    public String toEditCustom(int customerId,String bindCode,Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	//获取资源组信息
    	Group group = getDroupByBarCode(bindCode, request, response);
        model.addAttribute("group", group);
        
        //通过customerid获取用户详细信息
        Customer customer=getcustomeryId(customerId,request, response);
        model.addAttribute("customer", customer);
        
        //回显bindCode
        model.addAttribute("bindCode", bindCode);
        return "editCustom";
    }
    
    //修改客户
    @RequestMapping(value = "weixin/editCustom")
    public String editCustom(Customer customer,Model model, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	logger.info("createtime----------------->"+DateUtils.formatDate(customer.getCreatetime(), "yyyy-MM-dd HH:mm:ss"));
    	User u = (User) request.getSession().getAttribute("user");
    	CustomerGroup customerGroup = new CustomerGroup();
    	customerGroup.setCustomerid(customer.getId());
    	customerGroup.setCustomer(customer);
    	customerGroup.setUserid(u.getId());
    	String bindCode = request.getParameter("bindCode");
    	Group group = getDroupByBarCode(bindCode, request, response);
    	customerGroup.setGroupid(group.getId());
    	updateCustomer(customerGroup, request, response);
        //回显bindCode
        model.addAttribute("bindCode", bindCode);
        return "redirect:/weixin/customerList.html";
    }
    
    //内部方法，通过id获取用户详细信息
   	private Customer getcustomeryId(int id,HttpServletRequest request, HttpServletResponse response)
  			throws UnsupportedEncodingException, IOException, HttpException {
  		logger.info("-----------findById------------" + id);
          Customer customer = new Customer();
          customer.setId(id);
          String json = JSONObject.toJSONString(customer);
          logger.info("---传输数据：---" + json);
          String entity = RequestPost(request, response, json, CUSTOMER_BYID_URL);
          JSONObject httpresult = JSONObject.parseObject(entity);
          String resultCode = httpresult.getString("resultCode");// 状态码
          String reason = httpresult.getString("reason");// 返回信息
          logger.info(resultCode + "-------------------" + reason);
          if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
              String resultInfo = httpresult.getString("resultInfo");
              logger.info("---结果：---" + resultInfo);
              return JSONObject.parseObject(resultInfo, Customer.class);
          } else {
              return null;
          }
  	}
    
    //内部方法，通过barcod获取资源组信息
    private Group getDroupByBarCode(String barCode,HttpServletRequest request, HttpServletResponse response){
    	Barcode barcode = new Barcode();
        barcode.setBarcode(barCode);
        String json = JSONObject.toJSONString(barcode);
        logger.info("传输数据:" + json);
        String entity = null;
		try {
			entity = RequestPost(request, response, json, RESOURCEGROUP_DETAIL_BY_BARCODE_URL);
		} catch (Exception e) {
			e.printStackTrace();
		} 
        JSONObject httpresult = JSONObject.parseObject(entity);
        String resultCode = httpresult.getString("resultCode");// 状态码
        String reason = httpresult.getString("reason");// 返回信息
        logger.info(resultCode + "---------" + reason);
        if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
            JSONObject goodsObject = httpresult.getJSONObject("resultInfo");
            logger.info("---返回信息：---" + goodsObject);
            if (goodsObject != null) {
                Group group = JSON.parseObject(goodsObject.toJSONString(), Group.class);
                return group;
            } else {
            	return null;
            }
        } else {
        	return null;
        }
    }
    
    //内部方法，添加用户
    private void addCustomer(CustomerGroup customerGroup, HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, IOException, HttpException, MessageException {
		logger.info("-----------add------------" + customerGroup);
		User u = (User) request.getSession().getAttribute("user");
		customerGroup.setUserid(u.getId());
		String json = JSONObject.toJSONString(customerGroup);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, ADD_CUSTOMER_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("--------resultInfo-----------" + resultInfo);
		} else {
			throw new MessageException(reason);
		}
	}

    //内部方法，修改用户
    private void updateCustomer(CustomerGroup customerGroup, HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, IOException, HttpException {
		logger.info("-----------update------------" + customerGroup);
		String json = JSONObject.toJSONString(customerGroup);
		logger.info("---传输数据：---" + json);
		String entity = RequestPost(request, response, json, UPDATE_CUSTOMER_URL);
		JSONObject httpresult = JSONObject.parseObject(entity);
		String resultCode = httpresult.getString("resultCode");// 状态码
		String reason = httpresult.getString("reason");// 返回信息
		logger.info(resultCode + "-------------------" + reason);
		if (Global.RIGHT_CODE == Integer.parseInt(resultCode)) {
			String resultInfo = httpresult.getString("resultInfo");
			logger.info("--------resultInfo-----------" + resultInfo);
		}
	}
}
