package cn.fpshop.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSpinnerUI;

import org.apache.commons.beanutils.BeanUtils;

import cn.fpshop.domain.Address;
import cn.fpshop.domain.Cart;
import cn.fpshop.domain.CartItem;
import cn.fpshop.domain.Category;
import cn.fpshop.domain.Order;
import cn.fpshop.domain.OrderItem;
import cn.fpshop.domain.PageBean;
import cn.fpshop.domain.Product;
import cn.fpshop.domain.User;
import cn.fpshop.service.ProductService;
import cn.fpshop.service.UserService;
import cn.fpshop.service.impl.ProductServiceImpl;
import cn.fpshop.service.impl.UserServiceImpl;
import cn.fpshop.utils.CommonsUtils;

public class ProductServlet extends BaseServlet {
	public void findAllOrders(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		ProductService service = new ProductServiceImpl();
		List<Order> orderList = service.findAllOrders(user.getUid());
		if (orderList != null) {
			for (Order order : orderList) {
				String oid = order.getOid();
				List<Map<String, Object>> mapList = service.findOrderItemsByOid(oid);
				Address address = service.findAddressByOid(oid);
				order.setAddress(address);
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

		request.setAttribute("orderList", orderList);
		request.getRequestDispatcher("/privilege/userOrder.jsp").forward(request, response);
	}

	// ��ʾ��ҳ
	public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductService service = new ProductServiceImpl();
		// ׼��������Ʒ---List<Product>
		List<Product> hotProductList = service.findHotProductList();

		// ׼��������Ʒ---List<Product>
		List<Product> newProductList = service.findNewProductList();

		request.setAttribute("hotProductList", hotProductList);
		request.setAttribute("newProductList", newProductList);

		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	public void findCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ProductService service = new ProductServiceImpl();
		// ׼����������
		List<Category> categoryList = service.findAllCategory();
		System.out.println(categoryList);
		request.setAttribute("categoryList", categoryList);
		request.getRequestDispatcher("/header.jsp").forward(request, response);
	}

	public void findProductListByCid(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cid = request.getParameter("cid");
		String currentPageStr = request.getParameter("currentPage"); // ��ǰҳ
		if (currentPageStr == null)
			currentPageStr = "1";
		int currentPage = Integer.parseInt(currentPageStr);
		int currentCount = 10;

		ProductService service = new ProductServiceImpl();
		PageBean pageBean = service.findProductListByCid(cid, currentPage, currentCount);

		request.setAttribute("pageBean", pageBean);
		request.setAttribute("cid", cid);
		request.getRequestDispatcher("/productList.jsp").forward(request, response);
	}

	public void productInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pid = request.getParameter("pid");
		String currentPage = request.getParameter("currentPage");
		String cid = request.getParameter("cid");
		ProductService service = new ProductServiceImpl();
		Product product = service.productInfo(pid);

		request.setAttribute("product", product);
		System.out.println(product);
		request.setAttribute("current", currentPage);
		request.setAttribute("cid", cid);
		request.getRequestDispatcher("/productInfo.jsp").forward(request, response);

	}

	public void addCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid = request.getParameter("pid");
		int buyNum = Integer.parseInt(request.getParameter("buyNum"));
		HttpSession session = request.getSession();

		CartItem item = new CartItem();
		ProductService service = new ProductServiceImpl();
		Product product = service.productInfo(pid);
		item.setProduct(product);
		item.setBuyNum(buyNum);
		double subtotal = product.getPrice() * buyNum;
		item.setSubtotal(subtotal);

		Cart cart = (Cart) session.getAttribute("cart");
		if (cart == null) {
			cart = new Cart();
		}
		Map<String, CartItem> cartItems = cart.getCartItems();

		double newsubtotal = 0.0d;

		if (cartItems.containsKey(pid)) {
			// ȡ��ԭ����Ʒ������
			CartItem cartItem = cartItems.get(pid);
			int oldBuyNum = cartItem.getBuyNum();
			oldBuyNum += buyNum;
			cartItem.setBuyNum(oldBuyNum);
			cart.setCartItems(cartItems);
			// �޸�С��
			// ԭ������Ʒ��С��
			double oldsubtotal = cartItem.getSubtotal();
			// �������Ʒ��С��
			newsubtotal = buyNum * product.getPrice();
			cartItem.setSubtotal(oldsubtotal + newsubtotal);

		} else {
			// �������û�и���Ʒ
			cart.getCartItems().put(product.getPid(), item);
			newsubtotal = buyNum * product.getPrice();
		}

		// �����ܼ�
		double total = cart.getTotal() + newsubtotal;
		cart.setTotal(total);

		// �����ٴη���session
		session.setAttribute("cart", cart);

		// ֱ����ת�����ﳵҳ��
		response.sendRedirect(request.getContextPath() + "/cart.jsp");

	}

	// ɾ�����ﳵ��
	public void delCartItem(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ���Ҫɾ����item��pid
		String pid = request.getParameter("pid");
		// ɾ��session�еĹ��ﳵ�еĹ�������е�item
		HttpSession session = request.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart != null) {
			Map<String, CartItem> cartItems = cart.getCartItems();
			// ��Ҫ�޸��ܼ�
			double  newTotal = cart.getTotal() - cartItems.get(pid).getSubtotal();
			cart.setTotal(newTotal);
			// ɾ��
			cartItems.remove(pid);
			cart.setCartItems(cartItems);

		}

		session.setAttribute("cart", cart);

		// ��ת��cart.jsp
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}

	// ��չ��ﳵ
	public void clearCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("cart");

		// ��ת��cart.jsp
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}

	// ��Ӷ���
	public void addOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		Order order = new Order();
		
		order.setOid(UUID.randomUUID().toString());
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String fmt = format.format(new Date());
		System.out.println("fmt:"+fmt);
		Date date = null;
		try {
			date = format.parse(fmt);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("date:"+date);
		order.setOrder_time(date);

		order.setState(0);

		Cart cart = (Cart) session.getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
		}
		order.setTotal(cart.getTotal());

		UserService service = new UserServiceImpl();

		Address address = service.showDefaultAdd(user.getUid());
		order.setAddress(address);

		Map<String, CartItem> cartItems = cart.getCartItems();
		for (Map.Entry<String, CartItem> entry : cartItems.entrySet()) {
			// ȡ��ÿһ��������
			CartItem cartItem = entry.getValue();
			// �����µĶ�����
			OrderItem orderItem = new OrderItem();
			// 1)private String itemid;//�������id
			orderItem.setItemid(null);
			// 2)private int count;//����������Ʒ�Ĺ�������
			orderItem.setCount(cartItem.getBuyNum());
			// 3)private double subtotal;//������С��
			orderItem.setSubtotal(cartItem.getSubtotal());
			// 4)private Product product;//�������ڲ�����Ʒ
			orderItem.setProduct(cartItem.getProduct());
			// 5)private Order order;//�ö����������ĸ�����
			orderItem.setOrder(order);

			// ���ö�������ӵ������Ķ��������
			order.getOrderItems().add(orderItem);
		}

		// order�����װ���
		// �������ݵ�service��
		ProductService pro_service = new ProductServiceImpl();
		int subSuc = pro_service.submitOrder(order);

		if(subSuc != 0) {
			session.setAttribute("order", order);
			session.removeAttribute("cart");
			// ҳ����ת
			response.sendRedirect(request.getContextPath() + "/privilege/orderInfo.jsp");
		}
	}
	
	//֧������
	public void pay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Order order = (Order) session.getAttribute("order");
		String mode = request.getParameter("mode");
		
		double money = order.getTotal();
		List<OrderItem> orderItems = order.getOrderItems();
		
		User user = (User) session.getAttribute("user");
		String uid = user.getUid();
		UserService userservice = new UserServiceImpl();
		
		ProductService service = new ProductServiceImpl();
		
		//�޸���Ʒ����
		for(OrderItem item : orderItems) {
			service.soldoutProduct(item.getProduct().getPid(),item.getCount());
		}
		System.out.println(mode);
		if(mode.equals("money")) {
			System.out.println("mode1:"+mode);
			//�ж�����Ƿ��㹻
			if(money>user.getMoney()) {
				System.out.println("cnm!");
				response.sendRedirect(request.getContextPath()+"/failToPay.jsp");
				return;
			}else {
				System.out.println("cnmaaaa");
				double newmoney = user.getMoney()-money;
				userservice.changeMoney(newmoney,uid);
			}
			UserServlet servlet = new UserServlet();
			User newSession = servlet.updateSession(uid); //����user��
			session.setAttribute("user", newSession);
			
			int setSuc = 0;
			setSuc = service.setPayed(order.getOid());
			if(setSuc != 0) {
				System.out.println("setsuc:"+setSuc);
				response.sendRedirect(request.getContextPath()+"/privilege/user.jsp");
			}
			
		}else{
			System.out.println("mode2:"+mode);
			int setSuc = 0;
			setSuc = service.setPayed(order.getOid());
			if(setSuc != 0) {
				response.sendRedirect(request.getContextPath()+"/privilege/recharge.jsp");
			}
		}
	}
	
	//ȷ���ջ�
	public void confirmRec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oid = request.getParameter("oid");
		ProductService service = new ProductServiceImpl();
		
		int suc = 0;
		
		suc = service.confirmOrder(oid);
		if(suc != 0) {
			response.sendRedirect(request.getContextPath()+"/productservlet?method=findAllOrders");
		}else {
			System.out.println("�ջ�ʧ�ܰ���������");
		}
		
		
	}
}
