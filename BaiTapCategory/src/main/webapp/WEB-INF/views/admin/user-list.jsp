<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Vietnamese font optimization */
        html {
            font-feature-settings: "kern" 1;
            text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        body, input, button, textarea {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif !important;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            text-rendering: optimizeLegibility;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            overflow: hidden;
            animation: slideUp 0.8s ease-out;
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

        .page-title-bar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .page-title-bar h2 {
            font-size: 2.2rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .actions-group {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn-add {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-add:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-add::before {
            content: '\f067';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .total-count-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .total-count-badge .count {
            background: rgba(255, 255, 255, 0.9);
            color: #667eea;
            padding: 4px 12px;
            border-radius: 15px;
            margin-left: 8px;
            font-weight: 700;
        }

        .search-bar {
            padding: 30px 40px;
            background: linear-gradient(to right, #f8f9ff, #ffffff);
            border-bottom: 1px solid #e9ecef;
        }

        .search-form {
            display: flex;
            gap: 15px;
            max-width: 500px;
        }

        .search-form input {
            flex-grow: 1;
            padding: 15px 20px;
            border-radius: 25px;
            border: 2px solid #e9ecef;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .search-form input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: scale(1.02);
        }

        .search-form button {
            padding: 15px 30px;
            border-radius: 25px;
            border: none;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .search-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .search-form button::before {
            content: '\f002';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .alert {
            margin: 20px 40px;
            padding: 18px 25px;
            border-radius: 12px;
            font-weight: 500;
            animation: slideDown 0.5s ease-out;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert::before {
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 1.1rem;
        }

        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-success::before {
            content: '\f058';
            color: #28a745;
        }

        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-danger::before {
            content: '\f06a';
            color: #dc3545;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-container {
            padding: 0 40px 40px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        thead {
            background: linear-gradient(135deg, #f8f9ff 0%, #e9ecef 100%);
        }

        thead th {
            padding: 20px 15px;
            text-align: left;
            font-weight: 700;
            color: #495057;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #dee2e6;
        }

        tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #f8f9fa;
        }

        tbody tr:hover {
            background: linear-gradient(135deg, #f8f9ff 0%, #ffffff 100%);
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        tbody td {
            padding: 18px 15px;
            vertical-align: middle;
            font-size: 0.95rem;
            color: #495057;
        }

        .status-indicator {
            display: inline-block;
            width: 8px;
            height: 8px;
            background: #28a745;
            border-radius: 50%;
            margin-right: 8px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }

        .user-avatar-small {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
        }

        .user-avatar-small:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .role-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-user {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            color: #1976d2;
            border: 1px solid #bbdefb;
        }

        .role-manager {
            background: linear-gradient(135deg, #fff3e0 0%, #ffcc02 100%);
            color: #f57c00;
            border: 1px solid #ffcc02;
        }

        .role-admin {
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            color: #d32f2f;
            border: 1px solid #ffcdd2;
        }

        .action-links {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .action-links a {
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .action-links a:first-child {
            background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }

        .action-links a:first-child:hover {
            background: linear-gradient(135deg, #c8e6c9 0%, #a5d6a7 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(46, 125, 50, 0.2);
        }

        .action-links a:first-child::before {
            content: '\f044';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .action-links a:last-child {
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            color: #c62828;
            border: 1px solid #ffcdd2;
        }

        .action-links a:last-child:hover {
            background: linear-gradient(135deg, #ffcdd2 0%, #ef9a9a 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(198, 40, 40, 0.2);
        }

        .action-links a:last-child::before {
            content: '\f2ed';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .no-data {
            text-align: center;
            padding: 60px 20px !important;
            color: #6c757d;
            font-size: 1.1rem;
            font-style: italic;
        }

        .no-data::before {
            content: '\f119';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 3rem;
            color: #dee2e6;
            display: block;
            margin-bottom: 20px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .page-title-bar {
                padding: 20px 25px;
                flex-direction: column;
                align-items: flex-start;
            }

            .page-title-bar h2 {
                font-size: 1.8rem;
            }

            .search-bar,
            .table-container {
                padding: 20px 25px;
            }

            .search-form {
                flex-direction: column;
                max-width: none;
            }

            .search-form button {
                align-self: flex-start;
            }

            .action-links {
                flex-direction: column;
                align-items: flex-start;
            }

            .action-links a {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .page-title-bar h2 {
                font-size: 1.5rem;
            }

            .actions-group {
                flex-direction: column;
                align-items: flex-start;
                width: 100%;
            }

            .total-count-badge {
                align-self: flex-end;
            }

            thead th,
            tbody td {
                padding: 12px 8px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-title-bar">
            <h2>Quản lý Người dùng</h2>
            <div class="actions-group">
                <a href="${pageContext.request.contextPath}/admin/users/create" class="btn-add">Thêm Người dùng mới</a>
                <div class="total-count-badge">
                    Tổng số <span class="count">${fn:length(users)}</span>
                </div>
            </div>
        </div>
        
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/admin/users" method="get" class="search-form">
                <input type="text" name="keyword" placeholder="Tìm kiếm theo tên đăng nhập..." value="${keyword}">
                <button type="submit">Tìm kiếm</button>
            </form>
        </div>
        
        <!-- Display success/error messages -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">${sessionScope.error}</div>
            <c:remove var="error" scope="session" />
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Avatar</th>
                        <th>Tên đăng nhập</th>
                        <th>Họ và tên</th>
                        <th>Điện thoại</th>
                        <th>Vai trò</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop through users -->
                    <c:forEach items="${users}" var="u">
                        <tr>
                            <td><span class="status-indicator"></span>${u.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty u.images}">
                                        <c:url value="/image" var="avatarUrl">
                                            <c:param name="fname" value="${u.images}" />
                                        </c:url>
                                        <img src="${avatarUrl}" alt="Avatar" class="user-avatar-small">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://i.pravatar.cc/50?u=${u.username}" alt="Avatar" class="user-avatar-small">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${u.username}</td>
                            <td>${u.fullname}</td>
                            <td>${u.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.roleid == 1}">
                                        <span class="role-badge role-user">User</span>
                                    </c:when>
                                    <c:when test="${u.roleid == 2}">
                                        <span class="role-badge role-manager">Manager</span>
                                    </c:when>
                                    <c:when test="${u.roleid == 3}">
                                        <span class="role-badge role-admin">Admin</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td class="action-links">
                                <a href="${pageContext.request.contextPath}/admin/users/edit?id=${u.id}">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/users/delete?id=${u.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này không?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <!-- Empty message -->
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="7" class="no-data">Không tìm thấy người dùng nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 300);
            });
        }, 5000);

        // Add smooth animations
        document.querySelectorAll('button').forEach(button => {
            button.addEventListener('click', function() {
                this.style.opacity = '0.8';
                setTimeout(() => {
                    this.style.opacity = '1';
                }, 300);
            });
        });
    </script>
</body>
</html>