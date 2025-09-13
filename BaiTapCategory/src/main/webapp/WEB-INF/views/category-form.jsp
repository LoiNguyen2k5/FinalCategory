<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- Xác định các biến động ở đầu trang --%>
<c:set var="prefix" value="/user" />
<c:if test="${sessionScope.account.roleid == 2}"><c:set var="prefix" value="/manager" /></c:if>
<c:if test="${sessionScope.account.roleid == 3}"><c:set var="prefix" value="/admin" /></c:if>

<c:set var="pageTitle" value="Thêm Danh mục mới" />
<c:set var="formActionUrl" value="${pageContext.request.contextPath}${prefix}/category/create" />
<c:if test="${not empty category}">
    <c:set var="pageTitle" value="Chỉnh sửa Danh mục" />
    <c:set var="formActionUrl" value="${pageContext.request.contextPath}${prefix}/category/update" />
</c:if>

<%-- Phần <head> của trang con --%>
<head>
    <title>${pageTitle}</title>
    <style>
        .form-container { 
            max-width: 600px; 
            margin: 20px auto; 
            padding: 30px 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
        }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; color: #495057; }
        .form-group input[type="text"], .form-group input[type="file"] { 
            width: 100%; 
            padding: 12px; 
            box-sizing: border-box; 
            border: 1px solid #ced4da;
            border-radius: 8px;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }
        .form-group input[type="text"]:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
            outline: none;
        }
        .btn-submit { 
            padding: 12px 25px; 
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white; 
            border: none; 
            border-radius: 25px; 
            cursor: pointer;
            font-weight: 500;
            font-size: 16px;
            display: block;
            width: 100%;
            transition: all 0.3s ease;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
        }
        img.current-icon { max-width: 120px; height: auto; display: block; margin-top: 10px; border-radius: 10px; }
        .back-link { 
            display: block; 
            text-align: center; 
            margin-top: 20px; 
            text-decoration: none;
            color: #667eea;
            font-weight: 500;
        }
    </style>
</head>

<%-- Phần <body> của trang con --%>
<div class="form-container">
    <h2>${pageTitle}</h2>
    
    <form action="${formActionUrl}" method="post" enctype="multipart/form-data">
        <c:if test="${not empty category}">
            <input type="hidden" name="cateid" value="${category.cateId}" />
        </c:if>

        <div class="form-group">
            <label for="catename">Tên danh mục:</label>
            <input type="text" id="catename" name="catename" value="${category.cateName}" required />
        </div>
        
        <c:if test="${not empty category}">
            <div class="form-group">
                <label>Ảnh hiện tại:</label>
                <c:if test="${not empty category.icon}">
                    <c:url value="/image" var="imgUrl">
                        <c:param name="fname" value="${category.icon}" />
                    </c:url>
                    <img src="${imgUrl}" class="current-icon" />
                </c:if>
                <c:if test="${empty category.icon}">
                    <span>(Chưa có ảnh)</span>
                </c:if>
            </div>
        </c:if>
        
        <div class="form-group">
            <label for="icon">
                <c:choose>
                    <c:when test="${not empty category}">Chọn ảnh mới (nếu muốn thay đổi):</c:when>
                    <c:otherwise>Icon:</c:otherwise>
                </c:choose>
            </label>
            <input type="file" id="icon" name="icon" />
        </div>

        <button type="submit" class="btn-submit">
            <c:choose>
                <c:when test="${not empty category}">Cập nhật</c:when>
                <c:otherwise>Thêm</c:otherwise>
            </c:choose>
        </button>
    </form>
        
    <a href="${pageContext.request.contextPath}${prefix}/home" class="back-link">Quay lại danh sách</a>
</div>