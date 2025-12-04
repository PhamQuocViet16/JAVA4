//package filter;
//
//import java.io.IOException;
//import java.net.URLEncoder;
//
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import entity.User;
//
//@WebFilter(filterName = "AuthFilter", urlPatterns = { "/User/*", "/User" })
//public class AuthFilter extends HttpFilter {
//
//    @Override
//    public void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain)
//            throws IOException, ServletException {
//
//        String uri = req.getRequestURI();
//        User user = (User) req.getSession().getAttribute("user"); // Lấy user từ session
//        String error = "";
//
//        System.out.println("AuthFilter running");
//
//        // Kiểm tra đăng nhập
//        if (user == null) {
//            error = resp.encodeURL("Please login to use this function!");
//            System.out.println("Vui lòng đăng nhập!");
//        }
//        // Kiểm tra quyền admin
//        else if (!Boolean.TRUE.equals(user.isAdmin()) && uri.contains("/User")) {
//            error = resp.encodeURL("Please login with admin role");
//            System.out.println("Chỉ admin mới được truy cập!");
//        }
//
//        // Nếu có lỗi -> lưu session và redirect
//        if (!error.isEmpty()) {
//            req.getSession().setAttribute("securi", error);
//            resp.sendRedirect(req.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
//            System.out.println("Error!");
//        } 
//        // Nếu hợp lệ -> cho qua
//        else {
//            System.out.println("No Error!");
//            chain.doFilter(req, resp);
//            req.getSession().setMaxInactiveInterval(40); // giống file mẫu: 40 giây
//        }
//    }
//}
