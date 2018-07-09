package cn.fpshop.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.fpshop.domain.Category;
import cn.fpshop.domain.Product;
import cn.fpshop.utils.DataSourceUtils;

public class AdminDao {
	// չʾ�������
	public List<Category> showCategoryList() throws SQLException {
		String sql = "select * from category;";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		return runner.query(sql, new BeanListHandler<Category>(Category.class));
	}

	// ������
	public int addCategory(String cname) throws SQLException {
		String sql = "insert into category (cname) values(?)";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		return runner.update(sql, cname);
	}

	// �޸ķ���
	public int modifyCategory(String cid, String cname) throws SQLException {
		String sql = "update category set cname = ? where cid = ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		return runner.update(sql, cname, cid);
	}

	// չʾ��Ʒ������Ϣ
	public Product showProductInfo(String pid) throws SQLException {
		String sql = "select * from product where pid = ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		return runner.query(sql, new BeanHandler<Product>(Product.class), pid);
	}

	//// ���������Ʒ
	public List<Product> showAllProduct() throws SQLException {
		String sql = "select * from product";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	// �޸Ĳ�Ʒ��Ϣ
	public int modifyProduct(String pname, String price, String pdesc, String amount, String pid) throws SQLException {
		String sql = "update product set pname = ? , price = ? , pdesc = ? , amount = ? where pid = ?";
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		System.out.println("dao...");
		return runner.update(sql, pname, price, pdesc, amount, pid);
	}

	// ������𣬼۸�����
	public List<Product> OrderbyPriceup(String cid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product where cid=? order by price ASC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), cid);
	}

	// ������𣬼۸���
	public List<Product> OrderbyPricedown(String cid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product where cid=? order by price DESC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), cid);
	}

	// ���������������
	public List<Product> findbyAmountdown(String cid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product where cid=? order by amount DESC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), cid);
	}

	// ���������������
	public List<Product> findbyAmountup(String cid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product where cid=? order by amount ASC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), cid);
	}

	// ������������
	public List<Product> Amountup() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product order by amount ASC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	// ������������
	public List<Product> Amountdown() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product order by amount DESC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	// ���շ�������
	public List<Product> findProductByCate(String cid) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product where  cid = ?";
		return runner.query(sql, new BeanListHandler<Product>(Product.class), cid);
	}

	// ���ռ۸�����
	public List<Product> Priceup() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product order by price ASC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	// ���շ�������
	public List<Product> Pricedown() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from product order by price DESC";
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	public void saveProduct(Product product) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into product (pname,pdate,amount,price,image,pdesc,cid) values(?,?,?,?,?,?,?)";
		runner.update(sql, product.getPname(),product.getPdate(),product.getAmount(), product.getPrice(), product.getImage(), 
				product.getPdesc(), product.getCid());
	}

}
