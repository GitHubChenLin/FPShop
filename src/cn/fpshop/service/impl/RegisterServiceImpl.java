package cn.fpshop.service.impl;

import java.sql.SQLException;

import cn.fpshop.dao.UserDao;
import cn.fpshop.domain.User;
import cn.fpshop.service.RegisterSevice;

public class RegisterServiceImpl implements RegisterSevice {

	public User checkUsername(String username) throws SQLException {
		UserDao dao = new UserDao();
		User checkUsername = dao.checkUsername(username);
		return checkUsername;
	}

}
