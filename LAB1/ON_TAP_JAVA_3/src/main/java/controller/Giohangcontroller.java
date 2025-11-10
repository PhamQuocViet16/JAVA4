package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Item;
@WebServlet("/giohang")
public class Giohangcontroller extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 HttpSession session = req.getSession(); // Lấy session
	        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems"); // Lấy giỏ hàng từ session

	        // Nếu giỏ hàng chưa có, khởi tạo mới
	        if (cartItems == null) {
	            cartItems = new ArrayList<>();
	        }

	        // Tạo danh sách sản phẩm
	        List<Item> items = new ArrayList<>();
	        items.add(new Item("Nokia 2020", "at.jpg", 500, 0.1));
	        items.add(new Item("Samsung Xyz", "at1.jpg", 700, 0.15));
	        items.add(new Item("iPhone Xy", "fpoly1.jpg", 900, 0.25));
	        items.add(new Item("Sony Erricson", "fpoly.jpg", 55, 0.3));

	        req.setAttribute("items", items);
		req.getRequestDispatcher("cart.jsp").forward(req, resp);
	}

}
