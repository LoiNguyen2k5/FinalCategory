package Controllers;

import java.io.IOException;
import java.util.List;

import dao.CategoryDAO;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/user/home")
public class UserHomeController extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // User (và Admin) thấy tất cả category
        List<Category> list = categoryDAO.findAll();
        req.setAttribute("categories", list);
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}