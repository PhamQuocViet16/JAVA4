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

	// ========================= GET =========================
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String path = req.getPathInfo();

		// /api/users → lấy tất cả
		if (path == null || path.equals("/")) {
			List<User> list = dao.findAll();
			RestIO.writeObject(resp, list);
			return;
		}

		// /api/users/{id} → lấy theo ID
		String id = path.substring(1).trim();
		System.out.println("GET User ID = " + id);

		User user = dao.findById(id);
		if (user != null) {
			RestIO.writeObject(resp, user);
		} else {
			resp.sendError(404, "User not found");
		}
	}

	// ========================= POST =========================
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User user = RestIO.readObject(req, User.class);

		// Kiểm tra ID hoặc email đã tồn tại
		if (dao.findByIdOrEmail(user.getId(), user.getEmail()) != null) {
			resp.sendError(400, "User ID or Email already exists");
			return;
		}

		dao.create(user);
		RestIO.writeObject(resp, user);
	}

	// ========================= PUT =========================
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String path = req.getPathInfo();
		if (path == null || path.equals("/")) {
			resp.sendError(400, "Missing ID in URL");
			return;
		}

		String id = path.substring(1).trim();
		User user = RestIO.readObject(req, User.class);
		user.setId(id); // ép ID theo URL

		if (dao.findById(id) == null) {
			resp.sendError(404, "User not found");
			return;
		}

		dao.update(user);
		RestIO.writeEmptyObject(resp);
	}

	// ========================= DELETE =========================
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
