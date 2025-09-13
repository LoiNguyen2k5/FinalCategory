
package Controllers;

import java.io.File;
import java.io.IOException;
import java.util.List;

import dao.CategoryDAO;
import entity.Category;
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

@WebServlet(urlPatterns = { "/admin/category/create", "/admin/category/edit", "/admin/category/update",
		"/admin/category/delete", "/manager/category/create", "/manager/category/edit", "/manager/category/update",
		"/manager/category/delete" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CategoryDAO categoryDAO = new CategoryDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String servletPath = req.getServletPath();

		if (servletPath.endsWith("/category/create")) {
			req.getRequestDispatcher("/WEB-INF/views/category-form.jsp").forward(req, resp);
		} else if (servletPath.endsWith("/category/edit")) {
			edit(req, resp);
		} else if (servletPath.endsWith("/category/delete")) {
			delete(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String servletPath = req.getServletPath();

		if (servletPath.endsWith("/category/create")) {
			create(req, resp);
		} else if (servletPath.endsWith("/category/update")) {
			update(req, resp);
		}
	}

	// Hiển thị form để chỉnh sửa
	private void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int cateId = Integer.parseInt(req.getParameter("id"));
			Category category = categoryDAO.findById(cateId);

			HttpSession session = req.getSession();
			User loggedInUser = (User) session.getAttribute("account");

			// KIỂM TRA QUYỀN: Admin hoặc chủ sở hữu mới được xem form edit
			if (loggedInUser.getRoleid() == 3 || category.getUser().getId() == loggedInUser.getId()) {
				req.setAttribute("category", category);
				req.getRequestDispatcher("/WEB-INF/views/category-form.jsp").forward(req, resp);
			} else {
				// Không có quyền, đẩy về trang chủ với thông báo lỗi
				session.setAttribute("error", "Bạn không có quyền chỉnh sửa danh mục này!");
				resp.sendRedirect(req.getContextPath() + "/admin/home");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath() + "/admin/home");
		}
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		try {
			int cateId = Integer.parseInt(req.getParameter("id"));
			Category categoryToDelete = categoryDAO.findById(cateId);
			User loggedInUser = (User) session.getAttribute("account");

			if (loggedInUser.getRoleid() == 3 || categoryToDelete.getUser().getId() == loggedInUser.getId()) {
				categoryDAO.delete(cateId);
				session.setAttribute("message", "Xóa danh mục thành công!");
			} else {
				session.setAttribute("error", "Bạn không có quyền xóa danh mục này!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("error", "Xóa danh mục thất bại!");
		}
		resp.sendRedirect(req.getContextPath() + "/admin/home");
	}

	private void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		req.setCharacterEncoding("UTF-8");

		try {
			Category category = new Category();
			category.setCateName(req.getParameter("catename"));

			// Lấy file từ request
			Part filePart = req.getPart("icon"); // Sửa dấu '.' thành ';'

			// BỔ SUNG LẠI LOGIC XỬ LÝ FILE BỊ MẤT
			if (filePart != null && filePart.getSize() > 0) {
				String fileName = getFileName(filePart);
				if (fileName != null && !fileName.isEmpty()) {
					String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
					String uploadPath = Constant.DIR;
					File uploadDir = new File(uploadPath);
					if (!uploadDir.exists()) {
						uploadDir.mkdirs();
					}
					String filePath = uploadPath + File.separator + uniqueFileName;
					filePart.write(filePath);
					category.setIcon(uniqueFileName); // Gán tên file vào đối tượng
				}
			}

			// Gán quyền sở hữu
			User loggedInUser = (User) session.getAttribute("account");
			category.setUser(loggedInUser);

			// Lưu vào database
			categoryDAO.create(category);
			session.setAttribute("message", "Thêm danh mục mới thành công!");
			resp.sendRedirect(req.getContextPath() + "/admin/home");

		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("error", "Có lỗi xảy ra khi tạo danh mục: " + e.getMessage());
			req.getRequestDispatcher("/WEB-INF/views/category-form.jsp").forward(req, resp);
		}
	}

	private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		req.setCharacterEncoding("UTF-8");

		int cateId = Integer.parseInt(req.getParameter("cateid"));

		try {

			Category categoryToUpdate = categoryDAO.findById(cateId);

			if (categoryToUpdate == null) {
				session.setAttribute("error", "Không tìm thấy danh mục để cập nhật!");
				resp.sendRedirect(req.getContextPath() + "/admin/home");
				return;
			}

			User loggedInUser = (User) session.getAttribute("account");

			if (loggedInUser.getRoleid() == 3 || categoryToUpdate.getUser().getId() == loggedInUser.getId()) {

				categoryToUpdate.setCateName(req.getParameter("catename"));

				Part filePart = req.getPart("icon");
				if (filePart != null && filePart.getSize() > 0) {

					String fileName = getFileName(filePart);
					if (fileName != null && !fileName.isEmpty()) {

						String uploadPath = Constant.DIR;

						String oldIcon = categoryToUpdate.getIcon();
						if (oldIcon != null && !oldIcon.isEmpty()) {
							File oldFile = new File(uploadPath + File.separator + oldIcon);
							if (oldFile.exists()) {
								oldFile.delete();
							}
						}

						String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
						String filePath = uploadPath + File.separator + uniqueFileName;
						filePart.write(filePath);

						categoryToUpdate.setIcon(uniqueFileName);
					}
				}

				categoryDAO.update(categoryToUpdate);

				session.setAttribute("message", "Cập nhật danh mục thành công!");
				resp.sendRedirect(req.getContextPath() + "/admin/home");

			} else {
				session.setAttribute("error", "Bạn không có quyền cập nhật danh mục này!");
				resp.sendRedirect(req.getContextPath() + "/admin/home");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("error", "Có lỗi xảy ra khi cập nhật danh mục!");
			// Chuyển hướng về form edit nếu có lỗi
			resp.sendRedirect(req.getContextPath() + "/admin/category/edit?id=" + cateId);
		}
	}

	private String getFileName(Part part) {
		String contentDisposition = part.getHeader("content-disposition");
		if (contentDisposition == null) {
			return "";
		}

		String[] tokens = contentDisposition.split(";");
		for (String token : tokens) {
			if (token.trim().startsWith("filename")) {
				return token.substring(token.indexOf("=") + 2, token.length() - 1);
			}
		}
		return "";
	}
}