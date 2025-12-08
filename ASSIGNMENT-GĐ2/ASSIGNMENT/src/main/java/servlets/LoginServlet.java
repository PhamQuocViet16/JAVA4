package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;
import utils.CookieUtils;

@WebServlet({ "/Login", "/Logout" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String uri = request.getRequestURI();

		// ===== Xử lý logout =====
		if (uri.contains("/Logout")) {
			// Xóa session khi logout
			request.getSession().invalidate(); // clear session
			// Redirect về trang login
			response.sendRedirect(request.getContextPath() + "/Home");
			return;
		}

		// Xử lý login page
		Cookie cUser = CookieUtils.get(request, "userID");
		Cookie cPass = CookieUtils.get(request, "passwordID");
		Cookie cRem = CookieUtils.get(request, "remember");

		if (cUser != null)
			request.setAttribute("username", cUser.getValue());
		if (cPass != null)
			request.setAttribute("password", cPass.getValue());
		if (cRem != null)
			request.setAttribute("remember", "checked");

		request.getRequestDispatcher("/views/Customer/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String username = request.getParameter("username");
		String pw = request.getParameter("password");
		String remember = request.getParameter("remember-me");

		UserDAO dao = new UserDAOImpl();
		User user = dao.findByUsernameOrEmail(username);

		// ===== Kiểm tra tài khoản =====
		if (user == null) {
			request.setAttribute("message", "Tài khoản không tồn tại!");
			request.getRequestDispatcher("/views/Customer/login.jsp").forward(request, response);
			return;
		}

		if (!user.getPassword().equals(pw)) {
			request.setAttribute("message", "Sai mật khẩu!");
			request.getRequestDispatcher("/views/Customer/login.jsp").forward(request, response);
			return;
		}

		// ===== Đăng nhập thành công =====
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		session.setAttribute("messageHomePage", "Đăng nhập thành công");

		// ===== Lưu hoặc xóa cookie =====
		if (remember != null) {
			// Lưu cookie 30 ngày
			CookieUtils.add(response, "userID", username, 24 * 30);
			CookieUtils.add(response, "passwordID", pw, 24 * 30);
			CookieUtils.add(response, "remember", "true", 24 * 30);
		} else {
			// Xóa cookie nếu không chọn Remember Me
			CookieUtils.remove(request, response, "userID");
			CookieUtils.remove(request, response, "passwordID");
			CookieUtils.remove(request, response, "remember");
		}

		// Chuyển sang homepage
		response.sendRedirect(request.getContextPath() + "/Home");
	}
}
