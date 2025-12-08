package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.net.URLDecoder;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import dao.FavoriteDAO;
import dao.FavoriteDAOImpl;
import dao.VideoDAO;
import dao.VideoDAOImpl;
import entity.User;
import entity.Video;

/**
 * Servlet implementation class VideoDetailServlet
 */
@WebServlet("/VideoDetail")
public class VideoDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VideoDetailServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	VideoDAO videoDAO = new VideoDAOImpl();
	FavoriteDAO favDAO = new FavoriteDAOImpl();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		String id = request.getParameter("id");

		if (id == null || id.isBlank()) {
			response.sendRedirect("Home");
			return;
		}

		Video video = videoDAO.findById(id);

		if (video == null) {
			request.setAttribute("error", "Video không tồn tại!");
			request.getRequestDispatcher("/views/Customer/videodetail.jsp").forward(request, response);
			return;
		}

		// --- Tăng views ---
		video.setViews(video.getViews() + 1);
		videoDAO.update(video);

		// --- LẤY VÀ CẬP NHẬT COOKIE recentVideos ---
		Cookie[] cookies = request.getCookies();
		List<String> recentVideoIds = new ArrayList<>();
		if (cookies != null) {
			for (Cookie c : cookies) {
				if ("recentVideos".equals(c.getName())) {
					String value = URLDecoder.decode(c.getValue(), "UTF-8");
					if (!value.isBlank()) {
						recentVideoIds.addAll(Arrays.asList(value.split(",")));
					}
				}
			}
		}

		// Loại bỏ nếu trùng video hiện tại
		recentVideoIds.remove(video.getId());
		// Thêm video hiện tại lên đầu
		recentVideoIds.add(0, video.getId());
		// Giới hạn 5 video
		if (recentVideoIds.size() > 5) {
			recentVideoIds = recentVideoIds.subList(0, 5);
		}

		// Lưu lại vào cookie (7 ngày)
		Cookie cookie = new Cookie("recentVideos", URLEncoder.encode(String.join(",", recentVideoIds), "UTF-8"));
		cookie.setMaxAge(7 * 24 * 60 * 60);
		cookie.setPath(request.getContextPath());
		response.addCookie(cookie);

		// Chuyển ID sang đối tượng Video để hiển thị
		List<Video> recentVideos = new ArrayList<>();
		for (String vid : recentVideoIds) {
			Video v = videoDAO.findById(vid);
			if (v != null)
				recentVideos.add(v);
		}

		request.setAttribute("recentVideos", recentVideos);

		User user = (User) request.getSession().getAttribute("user");

		if (user != null) {
			request.setAttribute("favorites", favDAO.findByUser(user));
		}

		request.setAttribute("video", video);
		request.getRequestDispatcher("/views/Customer/videodetail.jsp").forward(request, response);
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
