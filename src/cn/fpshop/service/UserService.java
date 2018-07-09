package cn.fpshop.service;

import java.sql.SQLException;
import java.util.List;

import cn.fpshop.domain.Address;
import cn.fpshop.domain.User;

public interface UserService {
	User login(String username, String email, String password) throws SQLException;

	User checkUsername(String username) throws SQLException;

	int register(String uname, String username, String password, String email, String age, String sex,
			String telephone) throws SQLException;

	int modifyUser(String uid, String uname, String email, String age, String sex, String telephone) throws SQLException;


	User updateSession(String uid) throws SQLException;

	int recharge(double money, String uid) throws SQLException;

	List<Address> showAdd(String uid) throws SQLException;

	int insertAdd(String uid, String name, String add, String tel) throws SQLException;

	int changeDefault(String uid, String aid) throws SQLException;

	int changeAdd(String aid, String uid, String name, String add, String tel) throws SQLException;

	Address showDefaultAdd(String uid);

	void changeMoney(double newmoney, String uid);

	int setDefault(String aid);

	List<User> showAddList();

	List<User> orderByMoney(String money);

	List<User> orderByConsume(String consume);

	


}
