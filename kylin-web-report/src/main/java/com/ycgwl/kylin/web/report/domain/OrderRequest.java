package com.ycgwl.kylin.web.report.domain;

import java.io.Serializable;

public class OrderRequest implements Serializable {
	private static final long serialVersionUID = -6950569322538034831L;

	private String role; // 可传参数

	private Object loginuser; // 可传参数

	private Object data; // 可传参数

	private String department; // 可传参数

	public Object getLoginuser() {
		return loginuser;
	}

	public void setLoginuser(Object loginuser) {
		this.loginuser = loginuser;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

}
