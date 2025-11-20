package servlets;

import java.io.IOException;
import java.util.List;

import dao.FovoritesDAO;
import entity.Favorite;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/id-search")
public class FavoriteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.getRequestDispatcher("/views/id-search.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String userId = req.getParameter("id");

		FovoritesDAO dao = new FovoritesDAO(); // ❗ Tạo đối tượng DAO
		List<Favorite> favorites = null;

		try {
			favorites = dao.findFavoritesByUserIdJPQL(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// ❗ Kiểm tra null hoặc rỗng
		if (favorites == null || favorites.isEmpty()) {
			req.setAttribute("message", "Không tìm thấy yêu thích nào cho User ID: " + userId);
			req.getRequestDispatcher("/views/id-search.jsp").forward(req, resp);
			return;
		}

		// Lấy user từ favorite đầu tiên
		User user = favorites.get(0).getUser();

		req.setAttribute("user", user);
		req.setAttribute("favorite", favorites);

		req.getRequestDispatcher("/views/id-search.jsp").forward(req, resp);
	}

}
