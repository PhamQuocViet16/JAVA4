package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Item;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class Bai_4
 */
@WebServlet("/bai4")
public class Bai_4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bai_4() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setAttribute("lan", 10000000);
		
		ArrayList<String> danhsach= new ArrayList<String>();
		danhsach.add("Cần");
		danhsach.add("Cù");
		danhsach.add("Siêng");
		danhsach.add("Năng");
		request.setAttribute("ds", danhsach);
		
		
		ArrayList<Item> items = new ArrayList();
		items.add(new Item("Nokia 2020", "at.jpg", 500, 0.1));
		items.add(new Item("Samsung Xyz", "at1.jpg", 700, 0.15));
	    items.add(new Item("iPhone Xy", "fpoly1.jpg", 900, 0.25));
		items.add(new Item("Sony Erricson", "fpoly.jpg", 55, 0.3));
		 
		request.setAttribute("items", items);
		request.getRequestDispatcher("listproducts.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
