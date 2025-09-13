package Controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import util.Constant;

@WebServlet("/image")
public class ImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String fileName = req.getParameter("fname");
        
        if (fileName == null || fileName.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Tạo đường dẫn đầy đủ đến file
        String filePath = Constant.DIR + File.separator + fileName;
        File file = new File(filePath);
        
        // Kiểm tra file có tồn tại không
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Đặt content type dựa trên phần mở rộng file
        String contentType = getContentType(fileName);
        resp.setContentType(contentType);
        
        // Đặt content length
        resp.setContentLengthLong(file.length());
        
        // Đọc file và ghi ra response
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = fis.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    private String getContentType(String fileName) {
        String extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        
        switch (extension) {
            case "jpg":
            case "jpeg":
                return "image/jpeg";
            case "png":
                return "image/png";
            case "gif":
                return "image/gif";
            case "webp":
                return "image/webp";
            case "svg":
                return "image/svg+xml";
            default:
                return "application/octet-stream";
        }
    }
}