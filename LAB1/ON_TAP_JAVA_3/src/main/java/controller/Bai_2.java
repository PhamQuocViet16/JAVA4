package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class Bai_2
 */
@WebServlet({"/bai2","/chuvi","/dientich","/tinhhieu"})
public class Bai_2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bai_2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.getRequestDispatcher("bai2.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String uri = request.getRequestURI();
		
		float a,b,cv,dt,hieu;
		a=Float.parseFloat(request.getParameter("canha"));
		b=Float.parseFloat(request.getParameter("canhb"));
		if (uri.contains("/chuvi")) {
			cv=(a+b)*2;
			request.setAttribute("cv", cv);
		}else if (uri.contains("/dientich")) {
			dt=a*b;
			request.setAttribute("dt", dt);
		}else {
			hieu=a-b;
			request.setAttribute("hieu", hieu);
		}
		request.getRequestDispatcher("bai2.jsp").forward(request, response);
	}

}
