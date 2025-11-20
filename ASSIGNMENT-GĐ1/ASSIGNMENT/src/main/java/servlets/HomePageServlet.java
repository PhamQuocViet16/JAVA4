package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.VideoDAO;
import dao.VideoDAOImpl;
import entity.Video;

/**
 * Servlet implementation class HomePageServlet
 */
@WebServlet({ "/Home", 
	"/QuenMatKhau", 
	"/DangKy", 
	"/DangXuat", 
	"/DoiMatKhau",
	"/ChinhSuaTaiKhoan"})
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
		    List<Video> videos = videoDAO.findAll();
		    int pageNumber = 1;          // Trang mặc định
		    int pageSize = 6;            // Số video mỗi trang
		    
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
			page = "homepage.jsp";
		}
		
		if (uri.contains("Login")) {
			page = "login.jsp";
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
