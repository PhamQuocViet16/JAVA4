package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import dao.FavoriteDAO;
import dao.FavoriteDAOImpl;
import dao.VideoDAO;
import dao.VideoDAOImpl;
import entity.Favorite;
import entity.User;
import entity.Video;

@WebServlet("/Favorite")
public class FavoriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
		VideoDAO videoDAO = new VideoDAOImpl();
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/Login");
			return;
		}

		// Lấy tham số videoId và action (add hoặc delete)
		String videoIdParam = request.getParameter("videoId");
		String action = request.getParameter("action"); // add = like, delete = unlike

		if (videoIdParam != null && action != null) {
			Video video = videoDAO.findById(videoIdParam);
			if (video != null) {
				if ("add".equals(action) && !favoriteDAO.exists(user, video)) {
					Favorite favorite = new Favorite();
					favorite.setUser(user);
					favorite.setVideo(video);
					favorite.setLikeDate(new Date());
					favoriteDAO.save(favorite);
				} else if ("delete".equals(action) && favoriteDAO.exists(user, video)) {
					favoriteDAO.delete(user, video);
				}
			}

			// Lấy redirect và page từ request
			String redirectPage = request.getParameter("redirect");
			if (redirectPage == null || redirectPage.isEmpty()) {
				redirectPage = "Home"; // mặc định
			}

			String pageParam = request.getParameter("page");
			if (pageParam != null) {
				redirectPage += "?page=" + pageParam;
			}

			response.sendRedirect(request.getContextPath() + "/" + redirectPage);
			return;
		}

		// Hiển thị danh sách favorite
		List<Favorite> favorites = favoriteDAO.findByUser(user);
		request.setAttribute("favorites", favorites);
		request.getRequestDispatcher("/views/Customer/favorite.jsp").forward(request, response);
	}
}
