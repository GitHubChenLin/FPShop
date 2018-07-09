package cn.fpshop.domain;

public class OrderItem {
	
//	`itemid` int(50) NOT NULL,
//	  `oid` int(50) DEFAULT NULL,
//	  `pid` int(50) DEFAULT NULL,
//	  `count` int(50) DEFAULT NULL,
//	  `subtotal` varchar(255) DEFAULT NULL,	
	
	private String itemid;
	
	private int count;
	private double subtotal;
	
	private Order order;
	private Product product;
	
	
	public String getItemid() {
		return itemid;
	}
	public void setItemid(String itemid) {
		this.itemid = itemid;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	
	
}
