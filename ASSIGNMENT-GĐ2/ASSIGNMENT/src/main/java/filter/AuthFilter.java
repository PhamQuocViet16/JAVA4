package filter;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import entity.User;

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/User/*","/Video/*", "/Favorite/*", "/AccountUpdate/*","/Reports/*"})
public class AuthFilter extends HttpFilter {

	@Override
	public void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain)
			throws IOException, ServletException {

		String uri = req.getRequestURI();
		User user = (User) req.getSession().getAttribute("user");
		String error = "";

		if (user == null) {
			error = "Vui lòng đăng nhập để sử dụng chức năng này!";
		} else if (!user.isAdmin() && (uri.contains("/User") || uri.contains("/Video"))) {
			error = "Chỉ admin mới được truy cập!";
		}

		if (!error.isEmpty()) {
			req.getSession().setAttribute("securi", error);

			// ✔ Redirect về đúng Servlet Login
			resp.sendRedirect(req.getContextPath() + "/Login?error=" + URLEncoder.encode(error, "UTF-8"));
		} else {
			chain.doFilter(req, resp);
			req.getSession().setMaxInactiveInterval(240);
		}
	}
}
