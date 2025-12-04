//package filter;
//
//import java.io.IOException;
//import java.util.Date;
//
//import jakarta.servlet.Filter;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.FilterConfig;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import entity.User;
//
//@WebFilter(filterName = "LoggerFilter", urlPatterns = { "/accountBai3/sign-in" })
//public class LoggerFilter implements Filter {
//
//	@Override
//	public void init(FilterConfig filterConfig) throws ServletException {
//		// Optional: code khởi tạo filter
//	}
//
//	@Override
//	public void doFilter(jakarta.servlet.ServletRequest request, jakarta.servlet.ServletResponse response,
//			FilterChain chain) throws IOException, ServletException {
//
//		HttpServletRequest req = (HttpServletRequest) request;
//		HttpServletResponse resp = (HttpServletResponse) response;
//		HttpSession session = req.getSession();
//
//		String uri = req.getRequestURI();
//		Date time = new Date();
//
//		// Log trước khi servlet xử lý
//		User userBefore = (User) session.getAttribute("user");
//		String userInfoBefore = (userBefore != null) ? userBefore.getId() + " | " + userBefore.getFullname() : "guest";
//		System.out.println("[Before Servlet] Access URI: " + uri + " | User: " + userInfoBefore + " | Time: " + time);
//
//		// Chuyển tiếp request xuống servlet
//		chain.doFilter(req, resp);
//
//		// Log sau khi servlet xử lý
//		User userAfter = (User) session.getAttribute("user");
//		if (userAfter != null && (userBefore == null || !userBefore.getId().equals(userAfter.getId()))) {
//			// User vừa login thành công
//			System.out.println("[Login Success] User logged in: " + userAfter.getId() + " | " + userAfter.getFullname()
//					+ " | Time: " + new Date());
//		}
//	}
//
//	@Override
//	public void destroy() {
//		// Optional: giải phóng tài nguyên
//	}
//}
