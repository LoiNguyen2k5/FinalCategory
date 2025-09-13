package Controllers;

import java.io.File;
import java.io.IOException;
import dao.UserDAO;
import entity.User;
import util.Constant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(urlPatterns = {"/profile", "/profile/update"})
@MultipartConfig
public class ProfileController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Chỉ hiển thị trang profile
        req.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        updateProfile(req, resp);
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");

        try {
            // Cập nhật thông tin từ form
            currentUser.setFullname(req.getParameter("fullname"));
            currentUser.setPhone(req.getParameter("phone"));

            // Xử lý upload ảnh đại diện mới
            Part filePart = req.getPart("images");
            if (filePart != null && filePart.getSize() > 0) {
                String oldImage = currentUser.getImages();
                
                // Xóa ảnh cũ (nếu có)
                if (oldImage != null && !oldImage.isEmpty()) {
                    File oldFile = new File(Constant.DIR + File.separator + oldImage);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }

                // Lưu ảnh mới
                String fileName = getFileName(filePart);
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String filePath = Constant.DIR + File.separator + uniqueFileName;
                filePart.write(filePath);

                // Cập nhật tên file ảnh mới cho user
                currentUser.setImages(uniqueFileName);
            }
            
            // Lưu user đã cập nhật vào CSDL
            userDAO.update(currentUser);
            
            // Cập nhật lại session
            session.setAttribute("account", currentUser);
            
            // Chuyển hướng về trang profile
            resp.sendRedirect(req.getContextPath() + "/profile");

        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi
        }
    }
    
    // Copy phương thức getFileName từ CategoryController
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if(contentDisposition == null) return "";
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}