package Controllers;

import java.io.IOException;
import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        
        User account = userDAO.findByUsernameAndPassword(user, pass);
        
        if (account != null) {
            // Đăng nhập thành công, lưu user vào session
            HttpSession session = req.getSession();
            session.setAttribute("account", account);
            
            // Chuyển hướng theo roleId
            switch (account.getRoleid()) {
                case 1: // user
                    resp.sendRedirect(req.getContextPath() + "/user/home");
                    break;
                case 2: // manager
                    resp.sendRedirect(req.getContextPath() + "/manager/home");
                    break;
                case 3: // admin
                    resp.sendRedirect(req.getContextPath() + "/admin/home");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/login.jsp"); // Hoặc trang lỗi
                    break;
            }
        } else {
            // Đăng nhập thất bại
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}