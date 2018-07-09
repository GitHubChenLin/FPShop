package cn.fpshop.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cn.fpshop.dao.AdminDao;
import cn.fpshop.dao.ProductDao;
import cn.fpshop.dao.UserDao;
import cn.fpshop.domain.Address;
import cn.fpshop.domain.Category;
import cn.fpshop.domain.Order;
import cn.fpshop.domain.PageBean;
import cn.fpshop.domain.Product;
import cn.fpshop.service.ProductService;

public class ProductServiceImpl implements ProductService {

	public List<Order> findAllOrders(String uid) {
		ProductDao dao = new ProductDao();
		List<Order> orderList = null;
		try {
			orderList = dao.findAllOrders(uid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderList;
	}

	public List<Map<String, Object>> findOrderItemsByOid(String oid) {
		ProductDao dao = new ProductDao();
		List<Map<String, Object>> mapList = null;
		try {
			mapList = dao.findOrderItemsByOid(oid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapList;
	}

	public List<Map<String, Object>> findAdressUserByOid(String oid) {
		ProductDao dao = new ProductDao();
		List<Map<String, Object>> mapList = null;
		try {
			mapList = dao.findAddUserByOid(oid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapList;
	}
	
	public Address findAddressByOid(String oid) {
		ProductDao dao = new ProductDao();
		Address address = null;
		try {
			address = dao.findAddressByUid(oid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return address;
	}

	public List<Product> findHotProductList() {
		ProductDao dao = new ProductDao();
		List<Product> productList = null;
		try {
			productList = dao.findHotProductList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}

	public List<Product> findNewProductList() {
		ProductDao dao = new ProductDao();
		List<Product> productList = null;
		try {
			productList = dao.findNewProductList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productList;
	}

	public List<Category> findAllCategory() {
		ProductDao dao = new ProductDao();
		List<Category> categoryList = null;
		try {
			categoryList = dao.findCategoryList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categoryList;
	}

	public PageBean findProductListByCid(String cid, int currentPage, int currentCount) {
		ProductDao dao = new ProductDao();

		// ��װһ��PageBean ����web��
		PageBean<Product> pageBean = new PageBean<Product>();

		// 1����װ��ǰҳ
		pageBean.setCurrentPage(currentPage);
		// 2����װÿҳ��ʾ������
		pageBean.setCurrentCount(currentCount);
		// 3����װ������
		int totalCount = 0;
		try {
			totalCount = dao.getCount(cid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pageBean.setTotalCount(totalCount);
		// 4����װ��ҳ��
		int totalPage = (int) Math.ceil(1.0 * totalCount / currentCount);
		pageBean.setTotalPage(totalPage);

		// 5����ǰҳ��ʾ������
		// select * from product where cid=? limit ?,?
		// ��ǰҳ����ʼ����index�Ĺ�ϵ
		int index = (currentPage - 1) * currentCount;
		List<Product> list = null;
		try {
			list = dao.findProductByPage(cid, index, currentCount);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pageBean.setList(list);

		return pageBean;
	}

	public Product productInfo(String pid) {
		ProductDao dao = new ProductDao();
		Product product = null;
		try {
			product = dao.productInfo(pid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return product;
	}

	public int submitOrder(Order order) {
		ProductDao dao = new ProductDao();
		int OrderSuc = 0;
		try {
			// �洢order������
			OrderSuc = dao.addOrders(order);
			// �洢orderitem
			dao.addOrderItem(order);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return OrderSuc;
	}

	public int soldoutProduct(String pid, int count) {
		ProductDao dao = new ProductDao();
		int modifySuc = 0;
		try {
			modifySuc = dao.soldoutProduct(pid, count);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return modifySuc;
	}

	public int setPayed(String oid) {
		ProductDao dao = new ProductDao();
		int setSuc = 0;
		try {
			setSuc = dao.setPayed(oid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return setSuc;
	}

	public List<Category> categoryList() {
		AdminDao dao = new AdminDao();
		List<Category> categoryList = null;
		try {
			categoryList = dao.showCategoryList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return categoryList;
	}

	public int addCategory(String cname) {
		AdminDao dao = new AdminDao();
		int suc = 0;
		try {
			suc = dao.addCategory(cname);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return suc;
	}

	public int modifyCategory(String cid, String cname) {
		AdminDao dao = new AdminDao();
		int changeSuc = 0;
		try {
			changeSuc = dao.modifyCategory(cid, cname);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return changeSuc;
	}

	public Product showProductInfo(String pid) {
		AdminDao dao = new AdminDao();
		Product product = null;
		try {
			product = dao.showProductInfo(pid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return product;
	}

	public List<Product> showAllProduct() {
		AdminDao dao = new AdminDao();
		List<Product> productList = null;
		try {
			productList = dao.showAllProduct();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return productList;
	}

	public int modifyProduct(String pname, String price, String pdesc, String amount, String pid) {
		AdminDao dao = new AdminDao();
		int suc = 0;

		try {
			suc = dao.modifyProduct(pname, price, pdesc, amount, pid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("suc:" + suc);
		return suc;
	}

	public List<Product> orderBy(String cid, String price, String amount) {
		AdminDao dao = new AdminDao();
		List<Product> list = null;
		try {
			if (price.equals("asc")) {// ���ռ۸�����
				System.out.println("pa");
				list = dao.OrderbyPriceup(cid);
			} else if (price.equals("desc")) {		//�۸���
				System.out.println("pd");
				list = dao.OrderbyPricedown(cid);
			}else if(amount.equals("asc")) {		//��������
				System.out.println("aa");
				list = dao.findbyAmountup(cid);
			}else if(amount.equals("desc")) {		//��������
				System.out.println("ad");
				list = dao.findbyAmountdown(cid);
			}else {									//��������
				System.out.println("cc");
				list = dao.findProductByCate(cid);	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public List<Product> orderByPriceOrAmount(String price, String amount) throws SQLException {
		AdminDao dao = new AdminDao();
		List<Product> list = null;
		if(price == "") {
			if(amount.equals("asc")) {
				System.out.println("aaa");
				list = dao.Amountup();
			}else if(amount.equals("desc")) {
				System.out.println("aad");
				list = dao.Amountdown();
			}
		}else {
			if(price.equals("asc")) {
				System.out.println("ppa");
				list = dao.Priceup();
			}else if(price.equals("desc")) {
				System.out.println("ppd");
				list = dao.Pricedown();
			}
		}
		return list;
	}

	
	public List<Order> findOrders() {
		ProductDao dao = new ProductDao();
		List<Order> orderList = null;
		try {
			orderList = dao.findOrders();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderList;
	}

	public int setdelivery(String oid) {
		ProductDao dao = new ProductDao();
		int suc = 0;
		try {
			suc = dao.deliveryOrder(oid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return suc;
	}

	public int confirmOrder(String oid) {
		ProductDao dao = new ProductDao();
		int suc = 0;
		try {
			suc = dao.confirmOrder(oid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return suc;
	}

	

}
