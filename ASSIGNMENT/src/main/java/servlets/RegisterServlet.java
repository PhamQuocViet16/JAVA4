package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
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
		request.getRequestDispatcher("/views/Customer/register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		String id = request.getParameter("id");
	    String password = request.getParameter("password");
	    String fullname = request.getParameter("fullname");
	    String email = request.getParameter("email");

	    // Kiểm tra tồn tại user
	    User exist = userDAO.findByUsernameOrEmail(id);
	    if (exist != null) {
	        request.setAttribute("message", "Tài khoản hoặc email đã tồn tại!");
	        request.getRequestDispatcher("/views/Customer/register.jsp").forward(request, response);
	        return;
	    }

	    // Tạo user mới
	    User user = new User();
	    user.setId(id);
	    user.setPassword(password);
	    user.setFullname(fullname);
	    user.setEmail(email);
	    user.setAdmin(false); // MẶC ĐỊNH ROLE USER

	    userDAO.create(user);

	    // Đăng ký thành công → chuyển qua trang đăng nhập
	    response.sendRedirect(request.getContextPath() + "/Login");
	}
}
