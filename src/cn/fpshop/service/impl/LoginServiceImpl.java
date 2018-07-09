package cn.fpshop.service.impl;

import java.sql.SQLException;

import cn.fpshop.domain.User;
import cn.fpshop.service.LoginService;
import cn.fpshop.dao.UserDao;

public class LoginServiceImpl implements LoginService{

	public User login(String username, String email, String password) throws SQLException {
		UserDao dao = new UserDao();
		User user = dao.login(username,email,password);
		return user;
	}

}
