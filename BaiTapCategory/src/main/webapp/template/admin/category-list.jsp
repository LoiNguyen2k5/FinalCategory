/* Enhanced Empty State */
.empty-state {
    text-align: center;
    padding: 80px 30px;
    color: #6c757d;
}

.empty-state i {
    font-size: 80px;
    color: #dee2e6;
    margin-bottom: 30px;
    animation: bounce 2s infinite;
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
    40% { transform: translateY(-20px); }
    60% { transform: translateY(-10px); }
}

.empty-state h3 {
    margin-bottom: 15px;
    color: #495057;
    font-size: 24px;
    font-weight: 600;
}

.empty-state p {
    font-size: 16px;
    color: #6c757d;
}

/* Enhanced Responsive Design */
@media (max-width: 768px) {
    body {
        padding: 30px 10px 10px 10px;
    }
    
    .header {
        margin: -30px -10px 20px -10px;
        padding: 20px 0;
    }
    
    .header-content {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    .page-header {
        padding: 25px 20px;
    }
    
    .page-title {
        font-size: 24px;
    }
    
    .action-bar {
        flex-direction: column;
        gap: 20px;
        text-align: center;
        padding: 20px;
    }
    
    .table-container {
        padding: 20px;
    }
    
    table {
        font-size: 13px;
    }
    
    th, td {
        padding: 12px 10px;
    }
    
    .action-links {
        flex-direction: column;
        gap: 8px;
    }
    
    .action-links a {
        padding: 8px 12px;
        font-size: 12px;
    }
    
    img.category-icon {
        width: 50px;
        height: 50px;
    }
}

/* Enhanced Animation for table rows */
tbody tr {
    animation: fadeInUp 0.8s cubic-bezier(0.4, 0, 0.2, 1) forwards;
    opacity: 0;
}

tbody tr:nth-child(1) { animation-delay: 0.1s; }
tbody tr:nth-child(2) { animation-delay: 0.2s; }
tbody tr:nth-child(3) { animation-delay: 0.3s; }
tbody tr:nth-child(4) { animation-delay: 0.4s; }
tbody tr:nth-child(5) { animation-delay: 0.5s; }
tbody tr:nth-child(6) { animation-delay: 0.6s; }
tbody tr:nth-child(7) { animation-delay: 0.7s; }
tbody tr:nth-child(8) { animation-delay: 0.8s; }

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Loading Animation */
@keyframes shimmer {
    0% { background-position: -468px 0; }
    100% { background-position: 468px 0; }
}

/* Success notification auto-hide */
@media (prefers-reduced-motion: no-preference) {
    body::before {
        animation: slideDown 0.5s ease, fadeOut 0.5s ease 3s forwards;
    }
}

@keyframes fadeOut {
    to {
        opacity:<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý Danh mục</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
/* Reset và Base Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
}

/* Header Section */
.header {
    background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
    color: white;
    padding: 20px 0;
    margin: -20px -20px 30px -20px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.header-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.welcome-text {
    font-size: 18px;
}

.logout-btn {
    background: rgba(255,255,255,0.2);
    color: white;
    padding: 8px 16px;
    border: 1px solid rgba(255,255,255,0.3);
    border-radius: 5px;
    text-decoration: none;
    transition: all 0.3s ease;
}

.logout-btn:hover {
    background: rgba(255,255,255,0.3);
    transform: translateY(-2px);
}

/* Container */
.container {
    max-width: 1200px;
    margin: 0 auto;
    background: white;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    overflow: hidden;
    animation: slideUp 0.6s ease;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Page Header */
.page-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    padding: 30px;
    border-bottom: 1px solid #dee2e6;
}

.page-title {
    font-size: 28px;
    color: #2c3e50;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
}

.page-title i {
    margin-right: 10px;
    color: #3498db;
}

.page-subtitle {
    color: #6c757d;
    font-size: 14px;
}

/* Action Bar */
.action-bar {
    padding: 20px 30px;
    background: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.btn-add {
    display: inline-flex;
    align-items: center;
    padding: 12px 20px;
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 500;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
}

.btn-add:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
    color: white;
    text-decoration: none;
}

.btn-add i {
    margin-right: 8px;
}

.stats {
    color: #6c757d;
    font-size: 14px;
}

/* Table Styles */
.table-container {
    padding: 30px;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

thead {
    background: linear-gradient(135deg, #495057 0%, #6c757d 100%);
    color: white;
}

th {
    padding: 18px 15px;
    text-align: left;
    font-weight: 600;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

tbody tr {
    transition: all 0.3s ease;
    border-bottom: 1px solid #f1f3f4;
}

tbody tr:hover {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    transform: scale(1.02);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

tbody tr:nth-child(even) {
    background: #f8f9fa;
}

tbody tr:nth-child(even):hover {
    background: linear-gradient(135deg, #e9ecef 0%, #dee2e6 100%);
}

td {
    padding: 15px;
    vertical-align: middle;
    font-size: 14px;
}

.id-cell {
    font-weight: 600;
    color: #495057;
    font-family: 'Courier New', monospace;
}

.name-cell {
    font-weight: 500;
    color: #2c3e50;
}

/* Icon Styles */
.icon-cell {
    text-align: center;
}

img.category-icon {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 10px;
    border: 3px solid #e9ecef;
    transition: all 0.3s ease;
    cursor: pointer;
}

img.category-icon:hover {
    transform: scale(1.1);
    border-color: #3498db;
    box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
}

/* Action Links */
.action-links {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.action-links a {
    display: inline-flex;
    align-items: center;
    padding: 8px 12px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 12px;
    font-weight: 500;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.edit-btn {
    background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
    color: white;
    box-shadow: 0 2px 8px rgba(255, 193, 7, 0.3);
}

.edit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(255, 193, 7, 0.4);
    color: white;
}

.delete-btn {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    color: white;
    box-shadow: 0 2px 8px rgba(220, 53, 69, 0.3);
}

.delete-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(220, 53, 69, 0.4);
    color: white;
}

.action-links a i {
    margin-right: 4px;
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: 60px 30px;
    color: #6c757d;
}

.empty-state i {
    font-size: 64px;
    color: #dee2e6;
    margin-bottom: 20px;
}

.empty-state h3 {
    margin-bottom: 10px;
    color: #495057;
}

/* Responsive Design */
@media (max-width: 768px) {
    body {
        padding: 10px;
    }
    
    .header-content {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    .page-header {
        padding: 20px;
    }
    
    .action-bar {
        flex-direction: column;
        gap: 15px;
        text-align: center;
    }
    
    .table-container {
        padding: 15px;
    }
    
    table {
        font-size: 12px;
    }
    
    th, td {
        padding: 10px 8px;
    }
    
    .action-links {
        flex-direction: column;
    }
}

/* Animation for table rows */
tbody tr {
    animation: fadeInUp 0.6s ease forwards;
    opacity: 0;
}

tbody tr:nth-child(1) { animation-delay: 0.1s; }
tbody tr:nth-child(2) { animation-delay: 0.2s; }
tbody tr:nth-child(3) { animation-delay: 0.3s; }
tbody tr:nth-child(4) { animation-delay: 0.4s; }
tbody tr:nth-child(5) { animation-delay: 0.5s; }

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <div class="welcome-text">
                <i class="fas fa-user-shield"></i>
                Xin chào, <strong>admin</strong>! (Vai trò: Admin)
            </div>
            <a href="#" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Đăng xuất
            </a>
        </div>
    </div>

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-list"></i>
                Quản lý tất cả Danh mục (Admin)
            </h1>
            <p class="page-subtitle">Quản lý và tổ chức các danh mục sản phẩm trong hệ thống</p>
        </div>

        <!-- Action Bar -->
        <div class="action-bar">
            <a href="${pageContext.request.contextPath}/admin/category/create" class="btn-add">
                <i class="fas fa-plus"></i>
                Thêm Danh mục mới
            </a>
            <div class="stats">
                <i class="fas fa-chart-bar"></i>
                Tổng số: <strong><c:out value="${categories.size()}" default="0"/></strong> danh mục
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <c:choose>
                <c:when test="${empty categories}">
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>Chưa có danh mục nào</h3>
                        <p>Hãy thêm danh mục đầu tiên để bắt đầu</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i> ID</th>
                                <th><i class="fas fa-tag"></i> Tên Danh mục</th>
                                <th><i class="fas fa-image"></i> Icon</th>
                                <th><i class="fas fa-user"></i> Người tạo</th>
                                <th><i class="fas fa-cogs"></i> Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${categories}" var="cat">
                                <tr>
                                    <td class="id-cell">${cat.cateId}</td>
                                    <td class="name-cell">${cat.cateName}</td>
                                    <td class="icon-cell">
                                        <c:if test="${not empty cat.icon}">
                                            <c:url value="/image" var="imgUrl">
                                                <c:param name="fname" value="${cat.icon}" />
                                            </c:url>
                                            <img src="${imgUrl}" class="category-icon" alt="Icon" title="${cat.cateName}" />
                                        </c:if>
                                        <c:if test="${empty cat.icon}">
                                            <i class="fas fa-image" style="color: #dee2e6; font-size: 24px;"></i>
                                        </c:if>
                                    </td>
                                    <td>
                                        <i class="fas fa-user"></i>
                                        admin
                                    </td>
                                    <td class="action-links">
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cat.cateId}" class="edit-btn">
                                            <i class="fas fa-edit"></i>
                                            Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cat.cateId}" 
                                           class="delete-btn"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này không?');">
                                            <i class="fas fa-trash"></i>
                                            Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add ripple effect to buttons
            const buttons = document.querySelectorAll('.btn-add, .edit-btn, .delete-btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    let ripple = document.createElement('span');
                    ripple.classList.add('ripple');
                    this.appendChild(ripple);
                    
                    let x = e.clientX - e.target.offsetLeft;
                    let y = e.clientY - e.target.offsetTop;
                    
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        });
    </script>
</body>
</html>