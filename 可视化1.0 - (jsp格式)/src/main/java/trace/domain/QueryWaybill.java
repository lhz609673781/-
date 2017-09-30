package trace.domain;

import java.util.Date;

/**        
 * 名称：QueryWaybill    
 * 描述： 封装 运单查询类 （批量短信id）
 * 创建人：yangc    
 * 创建时间：2017年7月14日 上午10:54:39    
 * @version        
 */
public class QueryWaybill {
	private Integer id;
	private Integer userid;
	private Integer groupid;
	private Integer customerid;
	private Date createtime;
    private Integer[] ids;
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public Integer getCustomerid() {
		return customerid;
	}

	public void setCustomerid(Integer customerid) {
		this.customerid = customerid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Integer getGroupid() {
		return groupid;
	}

	public void setGroupid(Integer groupid) {
		this.groupid = groupid;
	}

	public Integer[] getIds() {
		return ids;
	}

	public void setIds(Integer[] ids) {
		this.ids = ids;
	}
    
}
