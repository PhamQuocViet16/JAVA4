package servlets;

import java.io.IOException;
import java.util.List;
import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.RestIO;

@WebServlet("/api/users/*")
public class UserServletAPI extends HttpServlet {
	private UserDAO dao = new UserDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getPathInfo();
		String accept = req.getHeader("Accept");

		// Nếu trình duyệt yêu cầu HTML, forward sang JSP
		if (accept != null && accept.contains("text/html")) {
			req.getRequestDispatcher("/views/user.jsp").forward(req, resp);
			return;
		}

		// Trả JSON cho fetch API
		if (path == null || path.equals("/")) {
			List<User> list = dao.findAll();
			RestIO.writeObject(resp, list);
		} else {
			String id = path.substring(1).trim();
			User user = dao.findById(id);
			if (user != null) {
				RestIO.writeObject(resp, user);
			} else {
				resp.sendError(404, "User not found");
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = RestIO.readObject(req, User.class);
		if (dao.findByIdOrEmail(user.getId(), user.getPassword()) != null) {
			resp.sendError(400, "User ID or Email already exists");
			return;
		}
		dao.create(user);
		RestIO.writeObject(resp, user);
	}

	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getPathInfo();
		if (path == null || path.equals("/")) {
			resp.sendError(400, "Missing ID in URL");
			return;
		}
		String id = path.substring(1).trim();
		User user = RestIO.readObject(req, User.class);
		user.setId(id);
		if (dao.findById(id) == null) {
			resp.sendError(404, "User not found");
			return;
		}
		dao.update(user);
		RestIO.writeEmptyObject(resp);
	}

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getPathInfo();
		if (path == null || path.equals("/")) {
			resp.sendError(400, "Missing ID in URL");
			return;
		}
		String id = path.substring(1).trim();
		if (dao.findById(id) == null) {
			resp.sendError(404, "User not found");
			return;
		}
		dao.deleteById(id);
		RestIO.writeEmptyObject(resp);
	}
}
