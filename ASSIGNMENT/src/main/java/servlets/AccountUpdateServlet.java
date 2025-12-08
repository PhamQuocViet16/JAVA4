package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;

/**
 * Servlet implementation class AccountUpdateServlet
 */
@WebServlet("/AccountUpdate")
public class AccountUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AccountUpdateServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	UserDAO userDAO = new UserDAOImpl();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user"); // lưu trong session khi login
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/Login");
			return;
		}

		request.setAttribute("user", user);
		request.getRequestDispatcher("/views/Customer/accountupdate.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/Login");
			return;
		}

		// Lấy dữ liệu từ form
		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		user.setFullname(fullname);
		user.setEmail(email);

		if (password != null && !password.isEmpty()) {
			user.setPassword(password);
		}

		userDAO.update(user);
		session.setAttribute("user", user); // cập nhật session

		request.setAttribute("message", "Cập nhật thông tin thành công!");
		request.setAttribute("user", user);
		request.getRequestDispatcher("/views/Customer/accountupdate.jsp").forward(request, response);
	}

}
