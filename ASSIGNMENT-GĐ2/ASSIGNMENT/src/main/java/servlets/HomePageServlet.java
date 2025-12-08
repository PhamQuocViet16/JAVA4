package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import dao.FavoriteDAO;
import dao.FavoriteDAOImpl;
import dao.VideoDAO;
import dao.VideoDAOImpl;
import entity.Favorite;
import entity.User;
import entity.Video;

/**
 * Servlet implementation class HomePageServlet
 */
@WebServlet("/Home")
public class HomePageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HomePageServlet() {
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
		String uri = request.getRequestURI();
		String page = "";

		if (uri.contains("Home")) {
			// Khởi tạo DAO và lấy danh sách video
			VideoDAO videoDAO = new VideoDAOImpl();
			List<Video> videos;
			// Lấy tham số tìm kiếm
			String keyword = request.getParameter("keyword");
			if (keyword != null && !keyword.trim().isEmpty()) {
				videos = videoDAO.findByKeyword(keyword.trim());
				if (videos == null || videos.isEmpty()) {
					request.setAttribute("message", "Không tìm thấy video với từ khóa: " + keyword);
					videos = List.of(); // tránh null
				} else {
					request.setAttribute("message", "Tìm thấy " + videos.size() + " video với từ khóa: " + keyword);
				}
			} else {
				videos = videoDAO.findAll(); // nếu không có từ khóa, lấy tất cả
			}

			int pageNumber = 1; // Trang mặc định
			int pageSize = 6; // Số video mỗi trang

			// Lấy tham số page trên URL
			String pageParam = request.getParameter("page");
			if (pageParam != null) {
				pageNumber = Integer.parseInt(pageParam);
			}

			// Tính tổng số trang
			int totalVideos = videos.size();
			int totalPages = (int) Math.ceil((double) totalVideos / pageSize);

			// Tính vị trí bắt đầu và kết thúc
			int fromIndex = (pageNumber - 1) * pageSize;
			int toIndex = Math.min(fromIndex + pageSize, totalVideos);

			// Lấy danh sách video cho trang hiện tại
			List<Video> pageVideos = videos.subList(fromIndex, toIndex);

			// Gửi danh sách video lên JSP
			request.setAttribute("videos", pageVideos);
			request.setAttribute("currentPage", pageNumber);
			request.setAttribute("totalPages", totalPages);

			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			if (user != null) {
				FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
				List<Favorite> likedVideos = favoriteDAO.findByUser(user);
				request.setAttribute("likedVideos", likedVideos);
			}

			page = "homepage.jsp";
		}

		if (uri.contains("Login")) {
			page = "login.jsp";
		}
		
		if (uri.contains("Register")) {
			page = "register.jsp";
		}

		request.getRequestDispatcher("/views/Customer/homepage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
	}

}
