package servlets;

import java.io.IOException;
import java.util.List;

import dao.FavoriteDAO;
import dao.FavoriteDAOImpl;
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/views/id-search.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userId = request.getParameter("id");

		FavoriteDAO dao = new FavoriteDAOImpl(); // ❗ Tạo đối tượng DAO
		List<Favorite> favorite = null;

		try {
			favorite = dao.findFavoritesByUserIdJPQL(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// ❗ Kiểm tra null hoặc rỗng
		if (favorite == null || favorite.isEmpty()) {
			request.setAttribute("message", "Không tìm thấy yêu thích nào cho User ID: " + userId);
			request.getRequestDispatcher("/views/id-search.jsp").forward(request, response);
			return;
		}

		// Lấy user từ favorite đầu tiên
		User user = favorite.get(0).getUser();

		request.setAttribute("user", user);
		request.setAttribute("favorite", favorite);

		request.getRequestDispatcher("/views/id-search.jsp").forward(request, response);
	}

}
