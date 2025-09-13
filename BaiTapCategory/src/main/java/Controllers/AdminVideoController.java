package Controllers;

import java.io.IOException;
import java.util.List;

import dao.VideoDAO;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {
    "/admin/videos", 
    "/admin/videos/edit", 
    "/admin/videos/create", 
    "/admin/videos/update", 
    "/admin/videos/delete"
})
public class AdminVideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VideoDAO videoDAO = new VideoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.equals("/admin/videos")) {
            showVideoList(req, resp);
        } else if (path.equals("/admin/videos/edit")) {
            showEditForm(req, resp);
        } else if (path.equals("/admin/videos/create")) {
             req.getRequestDispatcher("/WEB-INF/views/admin/video-form.jsp").forward(req, resp);
        } else if (path.equals("/admin/videos/delete")) {
            deleteVideo(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();
        if (path.equals("/admin/videos/create")) {
            createVideo(req, resp);
        } else if (path.equals("/admin/videos/update")) {
            updateVideo(req, resp);
        }
    }
    
    private void showVideoList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Video> videos;
        if (keyword != null && !keyword.trim().isEmpty()) {
            videos = videoDAO.searchByTitle(keyword);
            req.setAttribute("keyword", keyword);
        } else {
            videos = videoDAO.findAll();
        }
        req.setAttribute("videos", videos);
        req.getRequestDispatcher("/WEB-INF/views/admin/video-list.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int videoId = Integer.parseInt(req.getParameter("id"));
        Video video = videoDAO.findById(videoId);
        req.setAttribute("video", video);
        req.getRequestDispatcher("/WEB-INF/views/admin/video-form.jsp").forward(req, resp);
    }
    
    private void deleteVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int videoId = Integer.parseInt(req.getParameter("id"));
        videoDAO.delete(videoId);
        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }

    private void createVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Video video = new Video();
        video.setTitle(req.getParameter("title"));
        video.setDescription(req.getParameter("description"));
        video.setUrl(req.getParameter("url"));
        
        User currentUser = (User) req.getSession().getAttribute("account");
        video.setUser(currentUser);
        
        videoDAO.create(video);
        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }

    private void updateVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int videoId = Integer.parseInt(req.getParameter("id"));
        Video video = videoDAO.findById(videoId);
        video.setTitle(req.getParameter("title"));
        video.setDescription(req.getParameter("description"));
        video.setUrl(req.getParameter("url"));
        
        videoDAO.update(video);
        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }
}