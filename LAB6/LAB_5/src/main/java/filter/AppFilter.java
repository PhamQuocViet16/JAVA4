package filter;

import java.io.IOException;


import jakarta.servlet.DispatcherType;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebFilter(filterName = "appFilter",urlPatterns = {"/*","/Bai3_LoginServlet"},dispatcherTypes = DispatcherType.REQUEST)
public class AppFilter implements HttpFilter{

	@Override
	public void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("app filter running");
		resp.setCharacterEncoding("utf-8");
		req.setCharacterEncoding("utf-8");
		chain.doFilter(req, resp);
		
	}

}
