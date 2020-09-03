package model;

public class Member {
	private String id;
	private String pass;
	private String name;
	private String email;
	private String tel;
	private String dname;
	private int dage;
	private int dsex;
	private String dphoto;
	
	//getter, setter, toString
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public int getDage() {
		return dage;
	}
	public void setDage(int dage) {
		this.dage = dage;
	}
	public int getDsex() {
		return dsex;
	}
	public void setDsex(int dsex) {
		this.dsex = dsex;
	}
	public String getDphoto() {
		return dphoto;
	}
	public void setDphoto(String dphoto) {
		this.dphoto = dphoto;
	}
	
	@Override
	public String toString() {
		return "Member [id=" + id + ", pass=" + pass + ", name=" + name + ", email=" + email + ", tel=" + tel
				+ ", dname=" + dname + ", dage=" + dage + ", dsex=" + dsex + ", dphoto=" + dphoto + "]";
	}
	
}
