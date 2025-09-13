package Controllers;

import java.io.IOException;
import java.util.List;

import dao.CategoryDAO;
import entity.Category;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/manager/home")
public class ManagerHomeController extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User manager = (User) session.getAttribute("account");
        
        if (manager != null) {
            // Manager chỉ thấy category do chính mình tạo
            List<Category> list = categoryDAO.findByUserId(manager.getId());
            req.setAttribute("categories", list);
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
        } else {
            // Nếu không có session, chuyển về trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}