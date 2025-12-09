package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.FavoriteDAO;
import dao.FavoriteDAOImpl;
import dao.ShareDAO;
import dao.ShareDAOImpl;
import dao.VideoDAO;
import dao.VideoDAOImpl;

/**
 * Servlet implementation class ReportsServlet
 */
@WebServlet("/Reports")
public class ReportsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReportsServlet() {
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
		String action = request.getParameter("action");
		String title = request.getParameter("title");
		FavoriteDAO favDAO = new FavoriteDAOImpl();
		ShareDAO shareDAO = new ShareDAOImpl();
		VideoDAO videoDAO = new VideoDAOImpl();
		// 1) Thống kê số người yêu thích
		List<Object[]> reportFavorites = favDAO.countFavoriteByVideo();
		request.setAttribute("reportFavorites", reportFavorites);

		// 2) Lọc người yêu thích
		if ("favoriteUsers".equals(action) && title != null) {
			request.setAttribute("favoriteUsers", favDAO.findUsersByVideo(title));
		}

		// 3) Lọc người chia sẻ
		if ("shareUsers".equals(action) && title != null) {
			request.setAttribute("shareUsers", shareDAO.findSharesByVideo(title));
		}

		// list video đổ vào dropdown nếu cần
		request.setAttribute("videos", videoDAO.findAll());

		request.getRequestDispatcher("/views/Admin/reports.jsp").forward(request, response);
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
