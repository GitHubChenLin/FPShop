package cn.fpshop.service.impl;

import java.sql.SQLException;
import java.util.List;

import cn.fpshop.dao.UserDao;
import cn.fpshop.domain.Address;
import cn.fpshop.domain.User;
import cn.fpshop.service.UserService;

public class UserServiceImpl implements UserService {

	public User checkUsername(String username) throws SQLException {
		UserDao dao = new UserDao();
		User checkUsername = dao.checkUsername(username);
		return checkUsername;
	}

	public User login(String username, String email, String password) throws SQLException {
		UserDao dao = new UserDao();
		User user = dao.login(username, email, password);
		return user;
	}

	public int register(String uname, String username, String password, String email, String age, String sex,
			String telephone) throws SQLException {
		UserDao dao = new UserDao();
		int success = dao.register(uname, username, password, email, age, sex, telephone);
		return success;
	}

	public int modifyUser(String uid, String uname, String email, String age, String sex, String telephone)
			throws SQLException {
		UserDao dao = new UserDao();
		int modifySuccess = dao.modifyUser(uid, uname, email, age, sex, telephone);
		return modifySuccess;
	}

	public User updateSession(String uid) throws SQLException {
		UserDao dao = new UserDao();
		User newUser = dao.updateSession(uid);
		return newUser;
	}

	public int recharge(double money, String uid) throws SQLException {
		UserDao dao = new UserDao();
		int rechargeSuc = dao.recharge(money, uid);
		return rechargeSuc;
	}

	public List<Address> showAdd(String uid) throws SQLException {
		UserDao dao = new UserDao();
		List<Address> addList = dao.showAdd(uid);
		return addList;
	}

	public int insertAdd(String uid, String name, String add, String tel) throws SQLException {
		UserDao dao = new UserDao();
		int insertSuc = dao.insertAdd(uid, name, add, tel);
		return insertSuc;
	}

	public int changeDefault(String uid, String aid) throws SQLException {
		UserDao dao = new UserDao();
		int changeDefault = dao.changeDefault(uid, aid);
		return changeDefault;
	}

	public int changeAdd(String aid, String uid, String name, String add, String tel) throws SQLException {
		UserDao dao = new UserDao();
		int changeSuc = dao.changeAdd(aid, uid, name, add, tel);
		return changeSuc;
	}

	public Address showDefaultAdd(String uid) {
		UserDao dao = new UserDao();
		Address address = null;
		try {
			address = dao.showDefaultAdd(uid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return address;
	}

	public void changeMoney(double newmoney, String uid) {
		UserDao dao = new UserDao();
		try {
			dao.changeMoney(newmoney, uid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int setDefault(String aid) {
		UserDao dao = new UserDao();
		int setSuc = 0;
		try {
			setSuc = dao.setDefault(aid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return setSuc;
	}

	public List<User> showAddList() {
		UserDao dao = new UserDao();
		List<User> list = null;
		try {
			list = dao.showAddList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public List<User> orderByMoney(String money) {
		UserDao dao = new UserDao();
		List<User> list = null;
		System.out.println("money:"+money);
		try {
			if (money.equals("asc")) {// ÉýÐò
				list = dao.orderByMoneyUp();
			} else if (money.equals("desc")) {
				list = dao.orderByMoneyDown();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public List<User> orderByConsume(String consume) {
		UserDao dao = new UserDao();
		List<User> list = null;
		System.out.println("consume:"+consume);
		try {
			if (consume.equals("asc")) {// ÉýÐò
				list = dao.orderByConsumeUp();
			} else if (consume.equals("desc")) {
				list = dao.orderByConsumeDown();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

}
