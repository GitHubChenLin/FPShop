package cn.fpshop.service;

import java.sql.SQLException;

import cn.fpshop.domain.User;

public interface LoginService {

	User login(String username, String email, String password) throws SQLException;


}
