package user;

public class RegisterDTO {
	 private String user_id;
	 private String user_password;
	 private String user_name;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_pwd) {
		this.user_password = user_pwd;
	}
	public String getUser_Name() {
		return user_name;
	}
	public void setUser_Name(String name) {
		this.user_name = name;
	}
}
