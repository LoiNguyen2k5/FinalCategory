<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- Phần <head> của trang con --%>
<head>
    <title>Lỗi Truy Cập</title>
    <style>
        .error-container { 
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-family: 'Segoe UI', sans-serif;
        }
        .error-container h1 { 
            font-size: 8rem;
            margin: 0;
            line-height: 1;
            text-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .error-container p { 
            font-size: 1.5rem; 
            margin-top: 0;
            margin-bottom: 30px;
        }
        .error-container a { 
            color: white; 
            text-decoration: none; 
            padding: 12px 25px;
            background: rgba(255,255,255,0.2);
            border-radius: 25px;
            transition: background 0.3s ease;
            font-weight: 500;
        }
        .error-container a:hover {
            background: rgba(255,255,255,0.3);
        }
    </style>
</head>

<%-- Phần <body> của trang con --%>
<div class="error-container">
    <h1>403</h1>
    <p>Truy cập bị từ chối! Bạn không có quyền truy cập trang này.</p>
    
    <c:set var="prefix" value="/user" />
    <c:if test="${sessionScope.account.roleid == 2}"><c:set var="prefix" value="/manager" /></c:if>
    <c:if test="${sessionScope.account.roleid == 3}"><c:set var="prefix" value="/admin" /></c:if>
    
    <c:if test="${not empty sessionScope.account}">
        <p><a href="${pageContext.request.contextPath}${prefix}/home">Quay về trang chủ</a></p>
    </c:if>
    <c:if test="${empty sessionScope.account}">
         <p><a href="${pageContext.request.contextPath}/login.jsp">Đi đến trang đăng nhập</a></p>
    </c:if>
</div>