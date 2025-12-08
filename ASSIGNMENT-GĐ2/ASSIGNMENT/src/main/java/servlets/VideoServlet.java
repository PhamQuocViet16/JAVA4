package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import dao.VideoDAO;
import dao.VideoDAOImpl;
import entity.Video;

/**
 * Servlet implementation class VideoServlet
 */
@WebServlet({ "/Video", "/Video/edit/*", "/Video/create", "/Video/update", "/Video/delete", "/Video/reset",
		"/Video/search" })
public class VideoServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Video form = new Video();
		VideoDAO dao = new VideoDAOImpl();
		List<Video> list = dao.findAll();
		String path = request.getServletPath();

		try {
			// --------------------- EDIT -----------------------
			if (path.contains("edit")) {
//				String id = request.getPathInfo() != null ? request.getPathInfo().substring(1) : null;
				String id = request.getParameter("id"); // Lấy query string
				if (id != null) {
					form = dao.findById(id);
				}
				list = dao.findAll();
				// --------------------- CREATE -----------------------
			} else if (path.contains("create")) {
				BeanUtils.populate(form, request.getParameterMap());

				// ✅ Kiểm tra rỗng khi thêm
				if (form.getId() == null || form.getId().trim().isEmpty() || form.getTitle() == null
						|| form.getTitle().trim().isEmpty() || form.getPoster() == null
						|| form.getPoster().trim().isEmpty() || form.getDescription() == null
						|| form.getDescription().trim().isEmpty() || form.getCategory() == null
						|| form.getCategory().trim().isEmpty()) {

					request.setAttribute("message", "Vui lòng nhập đầy đủ thông tin trước khi thêm!");
				} else {
					dao.create(form);
					request.setAttribute("message", "Thêm video thành công.");
					form = new Video(); // Reset form sau khi thêm
				}
				list = dao.findAll();
				// --------------------- UPDATE -----------------------
			} else if (path.contains("update")) {
				BeanUtils.populate(form, request.getParameterMap());

				// ✅ Kiểm tra rỗng khi cập nhật
				if (form.getId() == null || form.getId().trim().isEmpty()) {
					request.setAttribute("message", "Vui lòng chọn video để cập nhật!");
				} else if (form.getTitle() == null || form.getTitle().trim().isEmpty() || form.getPoster() == null
						|| form.getPoster().trim().isEmpty() || form.getDescription() == null
						|| form.getDescription().trim().isEmpty() || form.getCategory() == null
						|| form.getCategory().trim().isEmpty()) {

					request.setAttribute("message", "Vui lòng nhập đầy đủ các trường trước khi cập nhật!");
				} else {
					dao.update(form);
					request.setAttribute("message", "Cập nhật video thành công.");
				}
				list = dao.findAll();
				// --------------------- DELETE -----------------------
			} else if (path.contains("delete")) {
				String id = request.getParameter("id");

				// ✅ Kiểm tra rỗng khi xóa
				if (id == null || id.trim().isEmpty()) {
					request.setAttribute("message", "Vui lòng chọn video để xóa!");
				} else {
					dao.deleteById(id);
					request.setAttribute("message", "Xóa video thành công.");
				}
				form = new Video();
				list = dao.findAll();

				// --------------------- RESET -----------------------
			} else if (path.contains("reset")) {
				form = new Video();
				list = dao.findAll();

				// --------------------- SEARCH -----------------------
			} else if (path.contains("search")) {
				String keyword = request.getParameter("keyword");
				if (keyword == null || keyword.trim().isEmpty()) {
					list = dao.findAll();
					request.setAttribute("message", "Vui lòng nhập video tìm kiếm.");
				} else {
					list = dao.findByKeyword(keyword.trim());
					if (list.isEmpty()) {
						request.setAttribute("message", "Không tìm thấy video nào với từ khóa '" + keyword + "'!");
					} else {
						request.setAttribute("message",
								"Tìm thấy " + list.size() + " video với từ khóa '" + keyword + "'.");
					}
				}
			} else {
				list = dao.findAll();
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "Lỗi: " + e.getMessage());
		}

		request.setAttribute("item", form);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/views/Admin/video.jsp").forward(request, response);
	}
}
