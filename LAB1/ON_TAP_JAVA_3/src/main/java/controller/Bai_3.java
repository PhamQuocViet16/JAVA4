package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class Bai_3
 */
@WebServlet("/bai3")
public class Bai_3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bai_3() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.getRequestDispatcher("bai3.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String gioiTinh = request.getParameter("gioiTinh");
		String married = request.getParameter("married");//married status
		String country = request.getParameter("country");
		String ghiChu = request.getParameter("ghiChu");
		String[] getSoThich = request.getParameterValues("soThich");
		
		StringBuilder sb = new StringBuilder();
		for (String item : getSoThich) {
			 {
				 sb.append(item).append(", ");
			 
			 }
		}
		
		String maritalStatus = "";
		if(married == null) {
			maritalStatus = "doc than";
		}else {
			maritalStatus = married;
		}
		
		String soThichConverted = "";
		if(sb.toString() != "") {
			soThichConverted = sb.toString().substring(0,sb.toString().lastIndexOf(","))+".";
		}
		
		request.setAttribute("username", username);
		request.setAttribute("password", password);
		request.setAttribute("gioiTinh", gioiTinh);
		request.setAttribute("married", maritalStatus);
		request.setAttribute("country", country);
		request.setAttribute("ghiChu", ghiChu);
		request.setAttribute("favourites", soThichConverted);
		
		request.getRequestDispatcher("hienthibai3.jsp").forward(request, response);
	}

}
