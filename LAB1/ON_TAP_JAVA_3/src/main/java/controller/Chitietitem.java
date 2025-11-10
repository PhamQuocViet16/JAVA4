package controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Item;
@WebServlet("/ProductDetailServlet")
public class Chitietitem extends HttpServlet
{
	@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// TODO Auto-generated method stub
		 String name = req.getParameter("id");
		 selectById(name, req);
		 req.getRequestDispatcher("/detailtu.jsp").forward(req, resp);
		}
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	// TODO Auto-generated method stub
	 String name = req.getParameter("id");
	 selectById(name, req);
	 req.getRequestDispatcher("/detailtu.jsp").forward(req, resp);
	 
}

public void selectById(String name, HttpServletRequest request) throws ServletException, IOException 
{
{
    ArrayList<Item> items = new ArrayList<>();
    items.add(new Item("Nokia 2020", "at.jpg", 500, 0.1));
    items.add(new Item("Samsung Xyz", "at1.jpg", 700, 0.15));
    items.add(new Item("iPhone Xy", "fpoly1.jpg", 900, 0.25));
    items.add(new Item("Sony Erricson", "fpoly.jpg", 55, 0.3));

    ArrayList<Item> selectedItems = new ArrayList<>();
    for (Item item : items) {
        if (item.getName().equalsIgnoreCase(name)) {
            selectedItems.add(item); //1 sản phẩm
            
        }
    }

    // Lưu danh sách sản phẩm đã chọn vào request để chuyển tiếp tới trang JSP
    request.setAttribute("selectedItems", selectedItems);
}

}


}


