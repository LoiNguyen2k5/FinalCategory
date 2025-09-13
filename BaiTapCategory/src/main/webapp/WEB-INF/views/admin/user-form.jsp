<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- Xác định các biến động --%>
<c:set var="pageTitle" value="Thêm Người dùng mới" />
<c:set var="formAction" value="${pageContext.request.contextPath}/admin/users/create" />
<c:if test="${not empty user}">
    <c:set var="pageTitle" value="Chỉnh sửa Người dùng" />
    <c:set var="formAction" value="${pageContext.request.contextPath}/admin/users/update" />
</c:if>

<head>
    <title>${pageTitle}</title>
    <%-- Sử dụng lại CSS từ category-form --%>
    <style>
        .form-container { max-width: 600px; margin: 20px auto; padding: 30px 40px; background: rgba(255, 255, 255, 0.95); border-radius: 20px; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1); }
        .form-container h2 { text-align: center; color: #2c3e50; margin-bottom: 30px; font-size: 28px; font-weight: 600; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; color: #495057; }
        .form-group input, .form-group select { width: 100%; padding: 12px; box-sizing: border-box; border: 1px solid #ced4da; border-radius: 8px; }
        .btn-submit { padding: 12px 25px; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; border: none; border-radius: 25px; cursor: pointer; font-weight: 500; font-size: 16px; display: block; width: 100%; }
        .back-link { display: block; text-align: center; margin-top: 20px; text-decoration: none; color: #667eea; font-weight: 500; }
    </style>
</head>

<div class="form-container">
    <h2>${pageTitle}</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${formAction}" method="post">
        <%-- Gửi id đi khi ở chế độ update --%>
        <c:if test="${not empty user}">
            <input type="hidden" name="id" value="${user.id}" />
        </c:if>

        <div class="form-group">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" value="${user.username}" required />
        </div>
        
        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" placeholder="${not empty user ? 'Để trống nếu không muốn đổi' : ''}" ${empty user ? 'required' : ''} />
        </div>
        
        <div class="form-group">
            <label for="fullname">Họ và tên:</label>
            <input type="text" id="fullname" name="fullname" value="${user.fullname}" />
        </div>
        
        <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="text" id="phone" name="phone" value="${user.phone}" />
        </div>
        
        <div class="form-group">
            <label for="roleid">Vai trò:</label>
            <select id="roleid" name="roleid" required>
                <option value="1" ${user.roleid == 1 ? 'selected' : ''}>User</option>
                <option value="2" ${user.roleid == 2 ? 'selected' : ''}>Manager</option>
                <option value="3" ${user.roleid == 3 ? 'selected' : ''}>Admin</option>
            </select>
        </div>
        
        <button type="submit" class="btn-submit">
            ${empty user ? 'Thêm mới' : 'Cập nhật'}
        </button>
    </form>
        
    <a href="${pageContext.request.contextPath}/admin/users" class="back-link">Quay lại danh sách</a>
</div>