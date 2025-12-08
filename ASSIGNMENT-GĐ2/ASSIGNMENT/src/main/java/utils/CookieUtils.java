package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtils {

	// Thêm cookie
	public static Cookie add(HttpServletResponse response, String name, String value, int hours) {
		if (response == null)
			return null;

		Cookie cookie = new Cookie(name, value);
		cookie.setPath("/"); // Path mặc định
		cookie.setMaxAge(hours * 3600); // Thời gian sống tính bằng giây
		cookie.setHttpOnly(true); // Chỉ HTTP, không cho JS truy cập
		// cookie.setSecure(true); // Bật nếu dùng HTTPS

		response.addCookie(cookie);
		return cookie;
	}

	// Lấy cookie theo tên
	public static Cookie get(HttpServletRequest request, String name) {
		if (request == null || request.getCookies() == null)
			return null;

		for (Cookie cookie : request.getCookies()) {
			if (cookie.getName().equalsIgnoreCase(name)) {
				return cookie;
			}
		}
		return null;
	}

	// Xóa cookie
	public static void remove(HttpServletRequest request, HttpServletResponse response, String name) {
		if (response == null)
			return;

		Cookie cookie = new Cookie(name, "");
		cookie.setPath("/"); // Path phải giống cookie gốc
		cookie.setMaxAge(0); // Xóa cookie
		cookie.setHttpOnly(true);

		response.addCookie(cookie);
	}
}
