package cn.fpshop.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import cn.fpshop.domain.Address;
import cn.fpshop.domain.Category;
import cn.fpshop.domain.Order;
import cn.fpshop.domain.OrderItem;
import cn.fpshop.domain.Product;
import cn.fpshop.utils.DataSourceUtils;

public class ProductDao {

	// 查询用户所有订单
	public List<Order> findAllOrders(String uid) throws SQLException {
		// TODO Auto-generated method stub
		String sql = "select o.* from `order` o,`user` u,address a WHERE u.uid = a.uid and o.aid = a.aid AND u.uid = ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		List<Order> orderList = runner.query(sql, new BeanListHandler<Order>(Order.class), uid);
		System.out.println("orderList:" + orderList);
		return orderList;
	}

	// 查询所有订单项
	public List<Map<String, Object>> findOrderItemsByOid(String oid) throws SQLException {
		String sql = "select i.count,i.subtotal,p.pid,p.pname,p.image,p.price from `order` o,orderitem i,product p where i.pid = p.pid and o.oid = i.oid and o.oid = ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		List<Map<String, Object>> mapList = runner.query(sql, new MapListHandler(), oid);
		System.out.println("mapList:" + mapList);
		return mapList;
	}

	// 查询用户地址
	public Address findAddressByUid(String oid) throws SQLException {
		String sql = "select a.* from `address` a,`order` o where a.aid = o.aid AND o.oid = ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		Address address = runner.query(sql, new BeanHandler<Address>(Address.class), oid);
		System.out.println("address:" + address);
		return address;
	}

	// 查询用户及地址
	public List<Map<String, Object>> findAddUserByOid(String oid) throws SQLException {
		String sql = "select a.*,u.* from `address` a,`order` o,`user` u where a.aid = o.aid AND a.uid = u.uid AND o.oid = ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		List<Map<String, Object>> mapList = runner.query(sql, new MapListHandler(), oid);
		System.out.println("address:" + mapList);
		return mapList;
	}

	// 最热商品
	public List<Product> findHotProductList() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select p.*  from orderitem o,product p WHERE (p.pid=o.pid) and (amount!=0) group by pid  order by SUM(count) desc LIMIT ?,? ";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), 0, 10);
	}

	// 最新商品
	public List<Product> findNewProductList() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product WHERE (amount!=0) order by pdate desc limit ?,?";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), 0, 10);
	}

	// 首页分页
	public List<Category> findCategoryList() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from category";
		return runner.query(sql, new BeanListHandler<Category>(Category.class));
	}

	// 统计一类别有多少商品
	public int getCount(String cid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select count(*) from product where cid = ?";
		Long query = (Long) runner.query(sql, new ScalarHandler(), cid);
		return query.intValue();
	}

	// 类别展示商品
	public List<Product> findProductByPage(String cid, int index, int currentCount) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product where cid = ? limit ?,?";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), cid, index, currentCount);
	}

	// 查询商品信息
	public Product productInfo(String pid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product where pid = ?";
		return runner.query(sql, new BeanHandler<Product>(Product.class), pid);
	}

	public int addOrders(Order order) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into `order` (oid,order_time,state,total,aid) values(?,?,?,?,?)";
		return runner.update(sql, order.getOid(), order.getOrder_time(), order.getState(), order.getTotal(),
				order.getAddress().getAid());
	}

	public void addOrderItem(Order order) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into orderitem (oid,pid,count,subtotal) values(?,?,?,?)";

		List<OrderItem> orderItems = order.getOrderItems();
		for (OrderItem item : orderItems) {
			runner.update(sql, item.getOrder().getOid(), item.getProduct().getPid(), item.getCount(),
					item.getSubtotal());
		}

	}

	// 下单时修改商品数量
	public int soldoutProduct(String pid, int count) throws SQLException {
		String sql = "update product set amount = amount-? where pid=?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		int soldoutPro = runner.update(sql, count, pid);
		return soldoutPro;
	}

	// 设置订单状态为已付款
	public int setPayed(String oid) throws SQLException {
		String sql = "update `order` set state = 1 where oid= ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		int setSuc = runner.update(sql, oid);
		return setSuc;
	}

	public List<Order> findOrders() throws SQLException {
		String sql = "select o.* from `order` o,`user` u,address a WHERE u.uid = a.uid and o.aid = a.aid";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		List<Order> orderList = runner.query(sql, new BeanListHandler<Order>(Order.class));
		System.out.println("orderList:" + orderList);
		return orderList;
	}

	// 订单发货
	public int deliveryOrder(String oid) throws SQLException {
		String sql = "update `order` set state = 2 where oid= ? ";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		int deliveryOrd = runner.update(sql, oid);
		return deliveryOrd;
	}

	// 用户确认订单
	public int confirmOrder(String oid) throws SQLException {
		String sql = "update `order` set state = 3 where oid= ? ";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		int confirmOrd = runner.update(sql, oid);
		return confirmOrd;
	}
}
