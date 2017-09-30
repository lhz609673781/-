package trace.domain;
/**        
 * 名称：SendMessage    
 * 描述：   封装发短信模板请求实体
 * 创建人：yangc    
 * 创建时间：2017年7月14日 上午10:57:07    
 * @version        
 */
public class TestUser {
	private String userName;
	private String passWord;
	private String roles;
	private String userType;
	private String mobile;
	private String content;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
 
}
