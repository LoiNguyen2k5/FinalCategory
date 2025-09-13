<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.sitemesh.org/sitemesh-decorator" prefix="decorator" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><decorator:title default="Bảng điều khiển" /></title>
    
    <decorator:head />
    
    <style>
        /* CSS cho layout chung, bao gồm cả nền tím */
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            margin: 0;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header-admin.jsp" />
    <decorator:body />
</body>
</html>