package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Base64;
import java.util.List;

import dao.ShareDAO;
import dao.ShareDAOImpl;
import dao.UserDAO;
import dao.UserDAOImpl;
import dao.VideoDAO;
import dao.VideoDAOImpl;
import entity.User;
import entity.Video;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user")) {
					String encoded = cookie.getValue();
					byte[] bytes = Base64.getDecoder().decode(encoded);
					String[] userInfo = new String(bytes).split(",");
					request.setAttribute("username", userInfo[0]);
					request.setAttribute("password", userInfo[1]);
				}
			}
		}
		request.getRequestDispatcher("/views/login.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String remember = request.getParameter("remember-me");

		UserDAO usersDAO = new UserDAOImpl();
		User user = usersDAO.findByIdOrEmail(username, password);

		if (user != null) {
			request.getSession().setAttribute("user", user); // Lưu Users vào session
			request.getSession().setAttribute("password", password);

			if (remember != null) {
				byte[] bytes = (username + "," + password).getBytes();
				String userInfo = Base64.getEncoder().encodeToString(bytes);
				Cookie cookie = new Cookie("user", userInfo);
				cookie.setMaxAge(30 * 24 * 60 * 60);
				cookie.setPath("/");
				response.addCookie(cookie);
			} else { // Xóa cookie nếu không chọn remember
				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if (cookie.getName().equals("user")) {
							cookie.setMaxAge(0);
							cookie.setPath("/");
							response.addCookie(cookie);
							break;
						}
					}
				}
			}
			response.sendRedirect(request.getContextPath() + "/Home");
		} else {
			request.setAttribute("message", "Đăng nhập thất bại!");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}

}
