package Controllers;

import java.io.IOException;
import java.util.List;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// Không cần import CategoryDAO và Category nữa

@WebServlet(urlPatterns = {
    "/admin/users", 
    "/admin/users/edit", 
    "/admin/users/create", 
    "/admin/users/update", 
    "/admin/users/delete"
})
public class AdminUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.equals("/admin/users")) {
            showUserList(req, resp);
        } else if (path.equals("/admin/users/edit")) {
            showEditForm(req, resp);
        } else if (path.equals("/admin/users/create")) {
             // Chuyển đến trang form để tạo mới, không cần dữ liệu ban đầu
             req.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(req, resp);
        } else if (path.equals("/admin/users/delete")) {
            deleteUser(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8"); // Đặt encoding cho doPost
        String path = req.getServletPath();
        if (path.equals("/admin/users/create")) {
            createUser(req, resp);
        } else if (path.equals("/admin/users/update")) {
            updateUser(req, resp);
        }
    }

    // Hiển thị danh sách người dùng (có tích hợp tìm kiếm)
    private void showUserList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<User> users;
        if (keyword != null && !keyword.trim().isEmpty()) {
            users = userDAO.searchByUsername(keyword);
            req.setAttribute("keyword", keyword);
        } else {
            users = userDAO.findAll();
        }
        req.setAttribute("users", users);
        req.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp").forward(req, resp);
    }
    
    // === PHẦN CODE BỊ THIẾU TRƯỚC ĐÂY ===

    // Hiển thị form để chỉnh sửa thông tin một người dùng
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("id"));
            User user = userDAO.findById(userId);
            req.setAttribute("user", user); // Gửi đối tượng user đến form
            req.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }

    // Xóa một người dùng
    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("id"));
            userDAO.delete(userId);
            req.getSession().setAttribute("message", "Xóa người dùng thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Xóa người dùng thất bại!");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }

    // Tạo một người dùng mới
    private void createUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try {
            User user = new User();
            user.setUsername(req.getParameter("username"));
            user.setPassword(req.getParameter("password")); // Lưu ý: thực tế nên mã hóa mật khẩu
            user.setFullname(req.getParameter("fullname"));
            user.setPhone(req.getParameter("phone"));
            user.setRoleid(Integer.parseInt(req.getParameter("roleid")));
            
            // Logic upload ảnh có thể thêm ở đây nếu cần, tương tự ProfileController
            
            userDAO.create(user);
            req.getSession().setAttribute("message", "Thêm người dùng mới thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Thêm người dùng thất bại: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(req, resp);
        }
    }

    // Cập nhật thông tin một người dùng
    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try {
            int userId = Integer.parseInt(req.getParameter("id"));
            User user = userDAO.findById(userId);

            user.setUsername(req.getParameter("username"));
            
            // Không cập nhật mật khẩu trừ khi có ô nhập mật khẩu mới
            String newPassword = req.getParameter("password");
            if (newPassword != null && !newPassword.isEmpty()) {
                user.setPassword(newPassword);
            }
            
            user.setFullname(req.getParameter("fullname"));
            user.setPhone(req.getParameter("phone"));
            user.setRoleid(Integer.parseInt(req.getParameter("roleid")));
            
            // Logic upload ảnh có thể thêm ở đây (tương tự ProfileController)
            
            userDAO.update(user);
            req.getSession().setAttribute("message", "Cập nhật người dùng thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Cập nhật người dùng thất bại: " + e.getMessage());
            // Gửi lại đối tượng user để form hiển thị lại dữ liệu cũ
            int userId = Integer.parseInt(req.getParameter("id"));
            User user = userDAO.findById(userId);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(req, resp);
        }
    }
}