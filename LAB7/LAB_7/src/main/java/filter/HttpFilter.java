//package filter;
//
//
//import java.io.IOException;
//import jakarta.servlet.Filter;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.FilterConfig;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.ServletRequest;
//import jakarta.servlet.ServletResponse;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//public interface HttpFilter extends Filter{
//
//	@Override
//	default public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException,ServletException
//	{
//		HttpServletRequest request = (HttpServletRequest) req;
//		HttpServletResponse response = (HttpServletResponse) resp;
//		this.doFilter(request, response, chain);
//	}
//
//	void doFilter(HttpServletRequest req, HttpServletResponse resp,FilterChain chain)throws IOException,ServletException; 
//	
//	@Override
//	default void init(FilterConfig filterConfig) throws ServletException 
//	{
//		Filter.super.init(filterConfig);
//		
//	}
//	
//	@Override
//	default void destroy() {
//		Filter.super.destroy();
//	}
//
//}
