<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bảng điều khiển</title>
<style>
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

    .container { 
        max-width: 1200px; 
        margin: auto; 
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        padding: 30px;
        transition: all 0.3s ease;
    }

    .container:hover {
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        transform: translateY(-2px);
    }

    .page-title-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        flex-wrap: wrap;
        gap: 15px;
    }

    h2 {
        color: #2c3e50;
        font-size: 28px;
        font-weight: 600;
        position: relative;
        padding-bottom: 15px;
        margin: 0;
    }

    h2::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 80px;
        height: 3px;
        background: linear-gradient(90deg, #667eea, #764ba2);
        border-radius: 2px;
    }

    .actions-group {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .btn-add { 
        display: inline-flex;
        align-items: center;
        padding: 12px 25px; 
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white; 
        text-decoration: none; 
        border-radius: 25px; 
        font-weight: 500;
        font-size: 14px;
        letter-spacing: 0.5px;
        box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
    }

    .btn-add::before {
        content: '+';
        margin-right: 8px;
        font-size: 18px;
        font-weight: bold;
    }

    .btn-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
        background: linear-gradient(135deg, #20c997 0%, #28a745 100%);
    }

    .total-count-badge {
        display: inline-flex;
        align-items: center;
        padding: 12px 25px; 
        background: linear-gradient(135deg, #6c5ce7 0%, #a29bfe 100%);
        color: white; 
        border-radius: 25px; 
        font-weight: 500;
        font-size: 14px;
        letter-spacing: 0.5px;
        box-shadow: 0 4px 15px rgba(108, 92, 231, 0.3);
    }
    
    .total-count-badge .count {
        font-weight: 700;
        margin-left: 8px;
        background: rgba(255, 255, 255, 0.2);
        padding: 2px 8px;
        border-radius: 10px;
        font-size: 15px;
    }

    .table-container {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(0, 0, 0, 0.05);
    }

    table { 
        width: 100%; 
        border-collapse: collapse;
    }

    thead {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    th { 
        padding: 18px 15px; 
        text-align: left;
        font-weight: 600;
        font-size: 14px;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        border: none;
    }

    td { 
        padding: 15px; 
        text-align: left;
        border-bottom: 1px solid #f1f3f4;
        font-size: 14px;
        color: #444;
        vertical-align: middle;
    }

    tbody tr:last-child td {
        border-bottom: none;
    }

    .action-links {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .action-links a { 
        padding: 8px 16px;
        text-decoration: none; 
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        text-transform: uppercase;
        transition: all 0.3s ease;
        min-width: 60px;
        text-align: center;
    }

    .action-links a:first-child {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        color: white;
        box-shadow: 0 2px 10px rgba(0, 123, 255, 0.3);
    }
    .action-links a:last-child {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        box-shadow: 0 2px 10px rgba(220, 53, 69, 0.3);
    }

    img.category-icon { 
        width: 60px; 
        height: 60px;
        object-fit: cover;
        border-radius: 50%;
        border: 3px solid #f8f9fa;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .no-data { 
        text-align: center; 
        padding: 40px 20px; 
        color: #6c757d;
        font-style: italic;
    }

    .status-indicator {
        display: inline-block;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        margin-right: 8px;
        background: #28a745;
    }

</style>
</head>
<body>
    <div class="container">
        
        <jsp:include page="common/header.jsp" />

        <div class="page-title-bar">
            <h2>
                <c:choose>
                    <c:when test="${sessionScope.account.roleid == 3}">Quản lý tất cả Danh mục</c:when>
                    <c:when test="${sessionScope.account.roleid == 2}">Danh mục của bạn</c:when>
                    <c:otherwise>Danh sách Danh mục</c:otherwise>
                </c:choose>
            </h2>

            <div class="actions-group">
                <c:if test="${sessionScope.account.roleid == 2 || sessionScope.account.roleid == 3}">
                    <c:set var="prefix" value="/user" />
                    <c:if test="${sessionScope.account.roleid == 2}"><c:set var="prefix" value="/manager" /></c:if>
                    <c:if test="${sessionScope.account.roleid == 3}"><c:set var="prefix" value="/admin" /></c:if>
                    <a href="${pageContext.request.contextPath}${prefix}/category/create" class="btn-add">Thêm Danh mục mới</a>
                </c:if>

                <div class="total-count-badge">
                    Tổng số <span class="count">${fn:length(categories)}</span>
                </div>
            </div>
        </div>
        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Danh mục</th>
                        <th>Icon</th>
                        <c:if test="${sessionScope.account.roleid == 3}">
                            <th>Người tạo</th>
                        </c:if>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categories}" var="cat">
                        <tr>
                            <td><span class="status-indicator"></span>${cat.cateId}</td>
                            <td>${cat.cateName}</td>
                            <td>
                                <c:if test="${not empty cat.icon}">
                                    <c:url value="/image" var="imgUrl">
                                        <c:param name="fname" value="${cat.icon}" />
                                    </c:url>
                                    <img src="${imgUrl}" class="category-icon" alt="Icon" />
                                </c:if>
                            </td>
                            
                            <c:if test="${sessionScope.account.roleid == 3}">
                                <td>${cat.user.username}</td>
                            </c:if>
                            
                            <td class="action-links">
                                <c:if test="${sessionScope.account.roleid == 3 || sessionScope.account.id == cat.user.id}">
                                    <c:set var="prefix" value="/user" />
                                    <c:if test="${sessionScope.account.roleid == 2}"><c:set var="prefix" value="/manager" /></c:if>
                                    <c:if test="${sessionScope.account.roleid == 3}"><c:set var="prefix" value="/admin" /></c:if>
                                    <a href="${pageContext.request.contextPath}${prefix}/category/edit?id=${cat.cateId}">Sửa</a>
                                    <a href="${pageContext.request.contextPath}${prefix}/category/delete?id=${cat.cateId}" onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty categories}">
                        <tr>
                            <td colspan="5" class="no-data">Chưa có danh mục nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>