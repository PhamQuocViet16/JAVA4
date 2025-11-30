package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import entity.User;

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/User/*", "/User"})
public class AuthFilter extends HttpFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession();

		User user = (User) session.getAttribute("user");
		String uri = req.getRequestURI();

		// Nếu chưa đăng nhập -> redirect login
		if (user == null) {
			session.setAttribute("securi", "Vui lòng đăng nhập để sử dụng chức năng này!");
			resp.sendRedirect(req.getContextPath() + "/Login");
			return; // bắt buộc return để ngăn chain.doFilter
		}

		// Nếu không phải admin nhưng truy cập /User* hoặc /Video* -> redirect login
		if ((uri.startsWith(req.getContextPath() + "/User")) && !user.isAdmin()) {
			session.setAttribute("securi", "Chỉ admin mới được truy cập!");
			resp.sendRedirect(req.getContextPath() + "/Login");
			return;
		}

		// Nếu hợp lệ -> cho qua
		session.setMaxInactiveInterval(30 * 60); // 30 phút
		chain.doFilter(request, response);
	}
}
