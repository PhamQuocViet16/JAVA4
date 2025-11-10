package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class Bai_1
 */
@WebServlet({"/bai1","/bai1/insert","/bai1/update","/bai1/delete"})
public class Bai_1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bai_1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.getRequestDispatcher("bai1.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String uri = request.getRequestURI();
		
		if (uri.contains("bai1/insert")){
			response.getWriter().println("<h1> Creating a Insert record...</h1>");
		}else if (uri.contains("bai1/update")){
			response.getWriter().println("<h1> Dang cap nhat du lieu...</h1>");
		}else if (uri.contains("bai1/delete")){
			response.getWriter().println("<h1> Dang xoa nhat du lieu...</h1>");
		}
	}

}
