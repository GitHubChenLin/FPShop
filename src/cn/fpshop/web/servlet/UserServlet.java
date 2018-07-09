package cn.fpshop.web.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.fpshop.domain.User;
import cn.fpshop.domain.Address;
import cn.fpshop.service.LoginService;
import cn.fpshop.service.RegisterSevice;
import cn.fpshop.service.UserService;
import cn.fpshop.service.impl.LoginServiceImpl;
import cn.fpshop.service.impl.RegisterServiceImpl;
import cn.fpshop.service.impl.UserServiceImpl;

/**
 * Servlet implementation class UserServlet
 */
public class UserServlet extends BaseServlet {
	public void checkSameUname(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String username = request.getParameter("username");
		
		System.out.println(username);
		UserService service = new UserServiceImpl();
		User checkUsername = null;
		try {
			checkUsername = service.checkUsername(username);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		boolean isSame = false;
		if(checkUsername != null) {
			isSame = true;
			response.getWriter().write("{\"isSame\":"+isSame+"}");
		}else {
			System.out.println("zhuce a!shadiao!");
		}
	}
	
	public void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String uname = request.getParameter("uname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String age  = request.getParameter("age") ;
		String sex = request.getParameter("sex");
		String telephone = request.getParameter("telephone");
		
		UserService service = new UserServiceImpl();
		int success = 0;
		try {
			success = service.register(uname, username,password,email,age,sex,telephone);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		boolean registerSuccess = false;
		if (success != 0) {
			registerSuccess = true;
			response.getWriter().write("{\"registerSuccess\":"+registerSuccess+"}");
		}else {
			response.getWriter().write("{\"registerSuccess\":"+registerSuccess+"}");
		}
		
	}
	public void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		String username = "";
		String email = "";
		
		HttpSession session  = request.getSession();
		boolean flag = false;
	    try{
	        String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
	        Pattern regex = Pattern.compile(check);
	        Matcher matcher = regex.matcher(account);
	            flag = matcher.matches();
	    }catch(Exception e){
	            flag = false;
	    }
		if(flag) {
			email = account;
		}else {
			username  = account;
		}
		System.out.println("email:"+email);
		System.out.println("username:"+username);
		UserService service = new UserServiceImpl();
		User user = null;
		try {
			user = service.login(username,email,password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(user);
		
		boolean isSuccess  = true;
		if(user != null) {
			System.out.println("aaaaaaacnm!");
			session.setAttribute("user", user);
			List<Address> addList = null;
			try {
				addList = service.showAdd(user.getUid());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("addListCart", addList );
			response.getWriter().write("{\"isSuccess\":"+isSuccess+"}");
			
		}else {
			isSuccess  = false;
			response.getWriter().write("{\"isSuccess\":"+isSuccess+"}");
		}
	}
	
	public User updateSession(String uid) throws ServletException, IOException  {
		UserService service = new UserServiceImpl();
		User newUser =  null;
		try {
			newUser = service.updateSession(uid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(newUser != null) {
			System.out.println("更新域成功");
		}
		return newUser;
		
	}
	
	public void modifyUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String uid= request.getParameter("uid");		
		String uname = request.getParameter("uname");
		String email = request.getParameter("email");
		String age  = request.getParameter("age") ;
		String sex = request.getParameter("sex");
		String telephone = request.getParameter("telephone");
		
		HttpSession session  = request.getSession();
		
		System.out.println("uid:"+uid);
		System.out.println(uname);
		System.out.println(telephone);
		
		UserService service = new UserServiceImpl(); 
		int modifySuccess = 0;
		try {
			modifySuccess = service.modifyUser(uid,uname,email,age,sex,telephone);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		boolean isSuccess = false;
		if(modifySuccess != 0) {
			isSuccess = true;
			response.getWriter().write("{\"isSuccess\":"+isSuccess+"}");
		}else {
			response.getWriter().write("{\"isSuccess\":"+isSuccess+"}");
		}
		User newUser = updateSession(uid);
		if(newUser != null) {
			session.setAttribute("user", newUser);
		}else {
			System.out.println("newUser为空啊傻雕！");
		}
		
	}
	
	public void recharge(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String pay = request.getParameter("pay");
		HttpSession session = request.getSession();
		double money = Double.parseDouble(pay);
		
		System.out.println("pay:"+pay);
		System.out.println("money"+money);
		
		User user = (User)session.getAttribute("user");
		String uid = user.getUid();
		System.out.println("uid"+uid);
		
		money = user.getMoney()+ money;
		System.out.println("newmoney"+money);
		
		UserService service = new UserServiceImpl();
		int rechargeSuc = 0;
		try {
			rechargeSuc = service.recharge(money,uid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		boolean isSuccess = false;
		if(rechargeSuc != 0) {
			isSuccess = true;
			response.getWriter().write("{\"isSuccess\":"+isSuccess+"}");
		}else {
			response.getWriter().write("{\"isSuccess\":"+isSuccess+"}");
		}
		
		User newUser = updateSession(uid);
		if(newUser != null) {
			session.setAttribute("user", newUser);
		}else {
			System.out.println("newUser为空啊傻雕！");
		}
	}
	
	public void showAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		String uid = user.getUid();
		UserService service = new UserServiceImpl();
		List<Address> addList =null;
		try {
			addList = service.showAdd(uid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(addList!=null) {
			request.setAttribute("addList", addList);
			request.getRequestDispatcher("/privilege/addManage.jsp").forward(request, response);
		}
		
	}
	
	
	
	public int changeDefault(String uid,String aid) {
		UserService service = new UserServiceImpl();
		int changeSuc = 0;
		try {
			changeSuc = service.changeDefault(uid,aid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return changeSuc;
	}
	
	public void setDefault(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String aid = request.getParameter("aid");
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String uid = user.getUid();
		changeDefault(uid,aid);
		
		UserService service = new UserServiceImpl();
		int setSuc = 0;
		setSuc = service.setDefault(aid);
		if(setSuc != 0) {
			response.sendRedirect(request.getContextPath()+"/addManage.jsp");
		}
		
	}
	
	public void addManage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String aid = request.getParameter("aid");
		String name = request.getParameter("name");
		String add = request.getParameter("add");
		String tel = request.getParameter("tel");
		String defaultAdd = request.getParameter("defaultAdd");
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		String uid = user.getUid();
		System.out.println(aid);
		System.out.println(name);
		
		UserService service = new UserServiceImpl();
		int success = 0;
		
		if(aid == "") {				//新增地址
			try {
				success = service.insertAdd(uid,name,add,tel);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {				//更改原有地址
			try {
				success = service.changeAdd(aid,uid,name,add,tel);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(success != 0) {
			showAdd(request, response);
		}else {
			System.out.println("失败了啊shadiao！");
		}
		
	}
	
	public void updateAddSession(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String uid = user.getUid();
		UserService service = new UserServiceImpl();
		List<Address> addList = null;
		try {
			addList = service.showAdd(uid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.setAttribute("addListCart", addList );
		
	}
	public void setDefaultCartAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String aid = request.getParameter("aid");
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String uid = user.getUid();
		changeDefault(uid,aid);
		
		UserService service = new UserServiceImpl();
		int setSuc = 0;
		setSuc = service.setDefault(aid);
		updateAddSession(request, response); //更新add域
		if(setSuc != 0) {
			request.getRequestDispatcher("/privilege/newAdd.jsp").forward(request, response);
		}
		
	}
	public void setDefaultCartUserAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String aid = request.getParameter("aid");
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String uid = user.getUid();
		changeDefault(uid,aid);
		
		UserService service = new UserServiceImpl();
		int setSuc = 0;
		setSuc = service.setDefault(aid);
		updateAddSession(request, response); //更新add域
		if(setSuc != 0) {
			request.getRequestDispatcher("/privilege/newAddManage.jsp").forward(request, response);
		}
		
	}

}
