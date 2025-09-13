<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
    .header-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 20px;
        margin-bottom: 25px;
    }
    .user-info {
        display: flex;
        align-items: center;
        gap: 15px;
        background: rgba(255, 255, 255, 0.9);
        padding: 8px 15px;
        border-radius: 25px;
        font-size: 14px;
        color: #343a40;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    }
    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #fff;
    }
    .user-info strong {
        color: #667eea;
        font-weight: 600;
    }
    .header-actions {
        display: flex;
        gap: 15px;
    }
    .btn-header {
        display: inline-flex;
        align-items: center;
        padding: 12px 25px; 
        color: white; 
        text-decoration: none; 
        border-radius: 25px; 
        font-weight: 500;
        font-size: 14px;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
    }
    .btn-header:hover {
        transform: translateY(-2px);
    }
    
    .btn-users { 
        background: linear-gradient(135deg, #17a2b8 0%, #117a8b 100%);
        box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
    }
    .btn-users:hover {
        box-shadow: 0 8px 25px rgba(23, 162, 184, 0.4);
    }

    /* === CSS CHO NÚT MỚI: QUẢN LÝ VIDEOS === */
    .btn-videos {
        background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
        box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
    }
    .btn-videos:hover {
        box-shadow: 0 8px 25px rgba(255, 193, 7, 0.4);
    }

    .btn-profile { 
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
    }
    .btn-profile:hover {
        box-shadow: 0 8px 25px rgba(0, 123, 255, 0.4);
    }
    .btn-logout { 
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
    }
    .btn-logout:hover {
        box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
    }
</style>

<div class="header-bar">
    <div class="user-info">
        <c:if test="${not empty sessionScope.account}">
            <c:if test="${not empty sessionScope.account.images}">
                <c:url value="/image" var="avatarUrl">
                    <c:param name="fname" value="${sessionScope.account.images}" />
                </c:url>
                <img src="${avatarUrl}" alt="Avatar" class="user-avatar">
            </c:if>
            <c:if test="${empty sessionScope.account.images}">
                <img src="https://i.pravatar.cc/40?u=${sessionScope.account.username}" alt="Avatar" class="user-avatar">
            </c:if>
            <div>
                Xin chào, <strong>${sessionScope.account.username}</strong>!
                (Vai trò: 
                <c:choose>
                    <c:when test="${sessionScope.account.roleid == 1}">User</c:when>
                    <c:when test="${sessionScope.account.roleid == 2}">Manager</c:when>
                    <c:when test="${sessionScope.account.roleid == 3}">Admin</c:when>
                </c:choose>
                )
            </div>
        </c:if>
    </div>
    
    <div class="header-actions">
        <c:if test="${sessionScope.account.roleid == 3}">
            <a href="${pageContext.request.contextPath}/admin/users" class="btn-header btn-users">Quản lý Users</a>
            
            <%-- =================================================================== --%>
            <%-- THÊM NÚT QUẢN LÝ VIDEOS VÀO ĐÂY --%>
            <%-- =================================================================== --%>
            <a href="${pageContext.request.contextPath}/admin/videos" class="btn-header btn-videos">Quản lý Videos</a>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/profile" class="btn-header btn-profile">Hồ sơ</a>
        <a href="${pageContext.request.contextPath}/logout" class="btn-header btn-logout">Đăng xuất</a>
    </div>
</div>