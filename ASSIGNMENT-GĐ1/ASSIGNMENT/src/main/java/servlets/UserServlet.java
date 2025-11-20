package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import org.apache.commons.beanutils.BeanUtils;
import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;

@WebServlet({ "/User", 
	"/User/edit/*", 
	"/User/create", 
	"/User/update", 
	"/User/delete", 
	"/User/reset" })
public class UserServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User form = new User();
		UserDAO dao = new UserDAOImpl();
		String path = request.getServletPath();

		try {
			if (path.contains("edit")) {
//				String id = request.getPathInfo() != null ? request.getPathInfo().substring(1) : null;
				 String id = request.getParameter("id");  // Lấy query string
				if (id != null) {
					form = dao.findById(id);
				}

			} else if (path.contains("create")) {
				BeanUtils.populate(form, request.getParameterMap());

				// ✅ Kiểm tra rỗng khi thêm
				if (form.getId() == null || form.getId().trim().isEmpty() || form.getPassword() == null
						|| form.getPassword().trim().isEmpty() || form.getFullname() == null
						|| form.getFullname().trim().isEmpty() || form.getEmail() == null
						|| form.getEmail().trim().isEmpty()) {

					request.setAttribute("message", "Vui lòng nhập đầy đủ thông tin trước khi thêm!");

				} else {
					dao.create(form);
					request.setAttribute("message", "Thêm người dùng thành công!");
					form = new User(); // reset form
				}

			} else if (path.contains("update")) {
				BeanUtils.populate(form, request.getParameterMap());

				// ✅ Kiểm tra rỗng khi cập nhật
				if (form.getId() == null || form.getId().trim().isEmpty()) {
					request.setAttribute("message", "Vui lòng chọn người dùng để cập nhật!");
				} else if (form.getPassword() == null || form.getPassword().trim().isEmpty()
						|| form.getFullname() == null || form.getFullname().trim().isEmpty() || form.getEmail() == null
						|| form.getEmail().trim().isEmpty()) {
					request.setAttribute("message", "Vui lòng nhập đầy đủ thông tin để cập nhật!");
				} else {
					dao.update(form);
					request.setAttribute("message", "Cập nhật người dùng thành công!");
				}

			} else if (path.contains("delete")) {
				String id = request.getParameter("id");

				// ✅ Kiểm tra rỗng khi xóa
				if (id == null || id.trim().isEmpty()) {
					request.setAttribute("message", "Vui lòng chọn người dùng để xóa!");
				} else {
					dao.deleteById(id);
					request.setAttribute("message", "Xóa người dùng thành công!");
				}

				form = new User();

			} else if (path.contains("reset")) {
				form = new User();
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "Lỗi: " + e.getMessage());
		}

		request.setAttribute("item", form);
		List<User> list = dao.findAll();
		request.setAttribute("list", list);
		request.getRequestDispatcher("/views/Admin/user.jsp").forward(request, response);
	}
}
