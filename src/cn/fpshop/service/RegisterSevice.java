package cn.fpshop.service;

import java.sql.SQLException;

import cn.fpshop.domain.User;

public interface RegisterSevice {

	User checkUsername(String username) throws SQLException;

}
