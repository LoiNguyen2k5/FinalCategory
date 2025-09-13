package Controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // Lấy session hiện tại, không tạo mới nếu không có
        if (session != null) {
            session.invalidate(); // Hủy session
        }
        
        // Chuyển hướng người dùng về trang đăng nhập
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}