package cn.fpshop.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;

import cn.fpshop.domain.Address;
import cn.fpshop.domain.Category;
import cn.fpshop.domain.Order;
import cn.fpshop.domain.OrderItem;
import cn.fpshop.domain.Product;
import cn.fpshop.domain.User;
import cn.fpshop.service.ProductService;
import cn.fpshop.service.UserService;
import cn.fpshop.service.impl.ProductServiceImpl;
import cn.fpshop.service.impl.UserServiceImpl;

public class adminServlet extends BaseServlet {
	public void categoryManage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		ProductService service = new ProductServiceImpl();
		List<Category> categoryList = null;
		categoryList = service.categoryList();
		
		if(categoryList != null) {
			request.setAttribute("categoryList", categoryList);
			request.getRequestDispatcher("/admin/categoryManage.jsp").forward(request, response);;
		}else {
			System.out.println("meiyou categorylist aaaaa!");
		}
	}
	
	public void addOrchange(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String cid = request.getParameter("cid");
		String cname = request.getParameter("cname");
		
		ProductService service = new ProductServiceImpl();
		int insertSuc = 0;
		int changeSuc = 0;
		if(cid == "") { //新增分类
			System.out.println("!cnm");
			insertSuc = service.addCategory(cname);
			if(insertSuc != 0) {
				System.out.println("aaaa");
				request.getRequestDispatcher("/admin?method=categoryManage").forward(request, response);
			}
		}else{ //修改分类
			changeSuc = service.modifyCategory(cid,cname);
			if(changeSuc != 0) {
				System.out.println("bbb!");
				request.getRequestDispatcher("/admin?method=categoryManage").forward(request, response);
			}
		}
		
	}
	
	public void showAllProduct(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		ProductService service = new ProductServiceImpl();
		List<Product> productList = service.showAllProduct();
		List<Category> categoryList = null;
		categoryList = service.categoryList();
		if(productList != null) {
			request.setAttribute("productList", productList);
			request.setAttribute("categoryList", categoryList);
			request.getRequestDispatcher("/admin/productManage.jsp").forward(request, response);
		}
	}
	
	public void showProductInfo(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String pid = request.getParameter("pid");
		
		ProductService service = new ProductServiceImpl();
		Product product = service.showProductInfo(pid);
		
		Gson gson = new Gson();
		String json = gson.toJson(product);
		System.out.println(json);
		
		if(product != null) {
			response.getWriter().write(json);
		}
	}
	
	public void modifyProduct(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String pid = request.getParameter("pid");
		String pname = request.getParameter("pname");
		String price = request.getParameter("price");
		String pdesc =request.getParameter("pdesc");
		String amount = request.getParameter("amount");
		System.out.println("pid:"+pid);
		ProductService service = new ProductServiceImpl();
		int modifySuc = 0; 
		modifySuc = service.modifyProduct(pname,price,pdesc,amount,pid);
		System.out.println("BBB");
		if(modifySuc != 0) {
			System.out.println("aaaaacnm!");
			response.getWriter().write("{\"isSuc\":"+true+"}");
		}
	}
	
	public void orderBy(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String cid = request.getParameter("cid");
		String price = request.getParameter("price");
		String amount = request.getParameter("amount");
		
		
		System.out.println(cid);
		System.out.println("price:"+price);
		System.out.println("amount:"+amount);
		ProductService service = new ProductServiceImpl();
		List<Product> productList  = null;
		if(cid == "") {
			try {
				productList = service.orderByPriceOrAmount(price,amount);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			productList = service.orderBy(cid,price,amount);
		}
		if(productList != null) {
			System.out.println("aaaachengggonga ");
			request.setAttribute("productList", productList);
			System.out.println(productList);
			request.getRequestDispatcher("/admin/newProductManage.jsp").forward(request, response);
			
		}else{
			System.out.println("aaashibai a !");
		}
	}
	
	public void orderManage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		ProductService service = new ProductServiceImpl();
		List<Order> orderList = service.findOrders();
		if (orderList != null) {
			for (Order order : orderList) {
				String oid = order.getOid();
				List<Map<String, Object>> mapList = service.findOrderItemsByOid(oid);
				List<Map<String, Object>> addMapList = service.findAdressUserByOid(oid);
				for(Map<String, Object> map : addMapList){
					try {
						Address address = new  Address();
						User user = new User();
						BeanUtils.populate(address, map);
						BeanUtils.populate(user, map);
						
						address.setUser(user);
						order.setAddress(address);
						
					} catch (IllegalAccessException | InvocationTargetException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
//				Address address = service.findAddressByOid(oid);
//				order.setAddress(address);
				for (Map<String, Object> map : mapList) {
					System.out.println("jinlailemaaaaa?");

					try {
						OrderItem item = new OrderItem();
						BeanUtils.populate(item, map);

						Product product = new Product();
						BeanUtils.populate(product, map);

						item.setProduct(product);

						order.getOrderItems().add(item);
					} catch (IllegalAccessException | InvocationTargetException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}

			}
		}
		
		Gson gson = new Gson();
		String json = gson.toJson(orderList);
		request.setAttribute("orderList", orderList);
		request.setAttribute("json", json);
		request.getRequestDispatcher("/admin/orderManage.jsp").forward(request, response);
	}
	
	public void setdelivery(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String oid = request.getParameter("oid");
		
		ProductService service = new ProductServiceImpl();
		int setSuc = 0;
		setSuc = service.setdelivery(oid);
		
		if(setSuc != 0) {
			request.getRequestDispatcher("/admin?method=orderManage").forward(request, response);
		}
	}
	
	public void userManage(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		UserService service = new UserServiceImpl();
		List<User> userList = null;
		userList = service.showAddList();
		
		if(userList != null) {
			request.setAttribute("userList", userList);
			request.getRequestDispatcher("/admin/userManage.jsp").forward(request, response);
		}
	}
	
	public void showAddressList(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String uid = request.getParameter("uid");
		UserService service = new UserServiceImpl();
		List<Address> addList = null;
		try {
			addList = service.showAdd(uid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Gson gson = new Gson();
		String json = null;
		json = gson.toJson(addList);
		if(json != null) {
			response.getWriter().write(json);
			
		}
		
	}
	
	public void showMoney(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String money = request.getParameter("money");
		UserService service = new UserServiceImpl();
		List<User> userList = null;
		if(money != "") {
			userList = service.orderByMoney(money);
		}
		if(userList != null) {
			System.out.println(userList);
			request.setAttribute("userList", userList);
			request.getRequestDispatcher("/admin/newUser.jsp").forward(request, response);
		}else {
			System.out.println("没有uselist");
		}
	}
	public void showConsume(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String consume = request.getParameter("consume");
		UserService service = new UserServiceImpl();
		List<User> userList = null;
		if(consume != "") {
			userList = service.orderByConsume(consume);
		}
		if(userList != null) {
			System.out.println(userList);
			request.setAttribute("userList", userList);
			request.getRequestDispatcher("/admin/newUser.jsp").forward(request, response);
		}else {
			System.out.println("没有uselist");
		}
	}
	
	public void findAllCategory(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		ProductService service = new ProductServiceImpl();
		List<Category> categoryList = service.findAllCategory();
		
		Gson gson = new Gson();
		String json = gson.toJson(categoryList);
		
		response.setContentType("text/html;charset=UTF-8");
		
		response.getWriter().write(json);
	}
}
