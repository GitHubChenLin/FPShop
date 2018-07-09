package cn.fpshop.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import cn.fpshop.domain.Address;
import cn.fpshop.domain.Category;
import cn.fpshop.domain.Order;
import cn.fpshop.domain.PageBean;
import cn.fpshop.domain.Product;

public interface ProductService {

	List<Order> findAllOrders(String uid);

	List<Map<String, Object>> findOrderItemsByOid(String oid);

	Address findAddressByOid(String uid);

	List<Product> findHotProductList();

	List<Product> findNewProductList();

	List<Category> findAllCategory();

	PageBean findProductListByCid(String cid, int currentPage, int currentCount);

	Product productInfo(String pid);

	int submitOrder(Order order);

	int soldoutProduct(String pid, int count);

	int setPayed(String oid);

	List<Category> categoryList();

	int addCategory(String cname);

	int modifyCategory(String cid, String cname);

	Product showProductInfo(String pid);

	List<Product> showAllProduct();

	int modifyProduct(String pname, String price, String pdesc, String amount, String pid);

	List<Product> orderBy(String cid, String price, String amount);

	List<Product> orderByPriceOrAmount(String price, String amount) throws SQLException;

	List<Order> findOrders();

	List<Map<String, Object>> findAdressUserByOid(String oid);

	int setdelivery(String oid);

	int confirmOrder(String oid);

}
