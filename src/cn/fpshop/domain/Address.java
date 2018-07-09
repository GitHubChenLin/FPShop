package cn.fpshop.domain;

import java.io.Serializable;

public class Address implements Serializable {
	private String aid;
	
	private User user;			//该地址属于哪个用户
	private String address;
	private String name;
	private String tel;
	private Boolean defaultAdd;
	
	
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Boolean getDefaultAdd() {
		return defaultAdd;
	}
	public void setDefaultAdd(Boolean defaultAdd) {
		this.defaultAdd = defaultAdd;
	}
	
	
}
