package cn.fpshop.dao;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.fpshop.domain.Address;
import cn.fpshop.domain.Category;
import cn.fpshop.domain.Product;
import cn.fpshop.domain.User;
import cn.fpshop.utils.DataSourceUtils;

public class UserDao {
		public User login(String username, String email, String password) throws SQLException {
			String sql = "select * from user where username = ? and password = ? or email = ? and password = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			User user = runner.query(sql, new BeanHandler<User>(User.class),username,password,email,password);
			return user;
		}

		public User checkUsername(String username) throws SQLException {
			String sql = "select username from user where username = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			User count = runner.query(sql, new BeanHandler<User>(User.class), username);
			System.out.println(count);
			return count;
		}

		public int register(String uname, String username, String password, String email, String age, String sex,String telephone) throws SQLException {
			String sql = "insert into user (username,uname,password,email,age,sex,telephone) values(?,?,?,?,?,?,?)";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			int success = runner.update(sql, username, uname, password,email,age,sex,telephone);
			return success;
		}

		public int modifyUser(String uid, String uname, String email, String age, String sex,
				String telephone) throws SQLException {
			String sql = "update user set uname = ? ,email = ? , age = ? , sex = ? , telephone = ? where uid = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			int modifySuccess = runner.update(sql, uname,email,age,sex,telephone,uid);
			return modifySuccess;
		}

		public User updateSession(String uid) throws SQLException {
			String sql = "select * from user where uid = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			User newUser = runner.query(sql, new BeanHandler<User>(User.class),uid);
			return newUser;
		}


		public int recharge(double money,String uid) throws SQLException {
			String sql = "update user set money = ? where uid = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			int rechargeSuc = runner.update(sql,money,uid);
			return rechargeSuc;
		}

		public List<Address> showAdd(String uid) throws SQLException {
			String sql = "select *from address where uid = ? ";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			return runner.query(sql, new BeanListHandler<Address>(Address.class), uid);
		}

		public int insertAdd(String uid, String name, String add, String tel) throws SQLException {
			String sql = "insert into address (uid,name,address,tel) values(?,?,?,?)";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			int insertSuc = runner.update(sql,uid,name,add,tel);
			return insertSuc;
		}

		public int changeDefault(String uid, String aid) throws SQLException {
//			String sql = "update address set defaultAdd = (case when uid = ? then 0 when aid = ? and defaultAdd = ? then 1";
			String sql = "update address set defaultAdd = 0 where uid = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			int changeSuc = runner.update(sql,uid);
			return changeSuc;
		}

		public int changeAdd(String aid, String uid, String name, String add, String tel) throws SQLException {
			String sql = "update address set uid = ? , name = ? , address = ? , tel = ? where aid = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			int changeSuc = runner.update(sql,uid,name,add,tel,aid);
			return changeSuc;
		}

		public Address showDefaultAdd(String uid) throws SQLException {
			String sql = "select * from address where uid = ? and defaultAdd = 1";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			return runner.query(sql, new BeanHandler<Address>(Address.class), uid);
		}

		public void changeMoney(double newmoney, String uid) throws SQLException {
			String sql = "update user set money = ? where uid = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			runner.update(sql,newmoney,uid);
		}

		public int setDefault(String aid) throws SQLException {
			String sql = "update address set defaultAdd = 1 where aid = ?";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			int setSuc = runner.update(sql,aid);
			return setSuc;
		}

		public List<User> showAddList() throws SQLException {
			String sql = "select * from user";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			return runner.query(sql, new BeanListHandler<User>(User.class));
		}

		public List<User> orderByMoneyUp() throws SQLException {
			String sql = "select * from user order by money ASC";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			return runner.query(sql, new BeanListHandler<User>(User.class));
		}

		public List<User> orderByMoneyDown() throws SQLException {
			String sql = "select * from user order by money DESC";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			return runner.query(sql, new BeanListHandler<User>(User.class));
		}

		public List<User> orderByConsumeUp() throws SQLException {
			String sql = "select u.* from `order` o,address a ,`user` u WHERE (o.aid=a.aid) and (a.uid=u.uid) and (state!=0) GROUP BY a.uid order by SUM(total) asc";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			return runner.query(sql, new BeanListHandler<User>(User.class));
		}

		public List<User> orderByConsumeDown() throws SQLException {
			String sql = "select u.* from `order` o,address a ,`user` u WHERE (o.aid=a.aid) and (a.uid=u.uid) and (state!=0) GROUP BY a.uid order by SUM(total) desc";
			QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
			return runner.query(sql, new BeanListHandler<User>(User.class));
		}	

	}


