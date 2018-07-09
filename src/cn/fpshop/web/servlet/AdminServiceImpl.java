package cn.fpshop.web.servlet;

import java.sql.SQLException;

import cn.fpshop.dao.AdminDao;
import cn.fpshop.domain.Product;
import cn.fpshop.service.AdminService;

public class AdminServiceImpl implements AdminService {

	public void saveProduct(Product product) {
		AdminDao dao = new AdminDao();
		try {
			dao.saveProduct(product);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
