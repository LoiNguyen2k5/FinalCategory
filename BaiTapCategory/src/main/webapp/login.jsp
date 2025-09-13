<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- Phần <head> của trang con, chứa tiêu đề và CSS --%>
<head>
    <title>Đăng nhập hệ thống</title>
    <style>
        /* CSS cho trang đăng nhập */
        .login-body { 
            font-family: 'Segoe UI', sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            margin: 0;
        }
        .login-container { 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: 0 20px 40px rgba(0,0,0,0.1); 
            width: 360px; 
            text-align: center;
        }
        .login-container h2 { 
            color: #2c3e50;
            margin-bottom: 30px; 
            font-size: 28px;
            font-weight: 600;
        }
        .form-group { 
            margin-bottom: 20px; 
            text-align: left;
        }
        .form-group label { 
            display: block; 
            margin-bottom: 8px; 
            color: #495057;
            font-weight: 500;
        }
        .form-group input[type="text"], 
        .form-group input[type="password"] { 
            width: 100%; 
            padding: 12px; 
            border: 1px solid #ced4da; 
            border-radius: 8px; 
            box-sizing: border-box; 
            transition: all 0.2s ease;
        }
        .form-group input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
            outline: none;
        }
        .btn-login { 
            width: 100%; 
            padding: 12px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            border: none; 
            border-radius: 25px; 
            cursor: pointer; 
            font-size: 16px; 
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-login:hover { 
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        .error-message { 
            color: #c82333; 
            background-color: #fdd; 
            border: 1px solid #fbb; 
            padding: 10px; 
            border-radius: 8px; 
            text-align: center; 
            margin-top: 20px; 
            font-size: 14px;
        }
    </style>
</head>

<%-- Phần <body> của trang con, sẽ được SiteMesh bọc lại --%>
<body class="login-body">
    <div class="login-container">
        <h2>Đăng nhập</h2>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn-login">Đăng nhập</button>
        </form>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
    </div>
</body>