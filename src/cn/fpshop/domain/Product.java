package cn.fpshop.domain;

import java.util.Date;

public class Product {
	
//	 `pid` int(50) NOT NULL AUTO_INCREMENT,
//	  `pname` varchar(255) DEFAULT NULL,
//	  `pdate` date DEFAULT NULL,
//	  `amount` varchar(255) DEFAULT NULL,
//	  `price` decimal(10,2) DEFAULT NULL,
//	  `image` varchar(255) DEFAULT NULL,
//	  `pdesc` varchar(998) DEFAULT NULL,
//	  `cid` int(50) DEFAULT NULL,
//	  `pstate` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否在售，0为下架，1为在售。',
	
	private String pid;
	private String pname;
	private int amount;
	private double price;
	private Date pdate;
	private String pdesc;
	private String image;
	private String cid;
	private int pstate;
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public String getPdesc() {
		return pdesc;
	}
	public void setPdesc(String pdesc) {
		this.pdesc = pdesc;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public int getPstate() {
		return pstate;
	}
	public void setPstate(int pstate) {
		this.pstate = pstate;
	}
	
	
}
