<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Videos</title>
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
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            backdrop-filter: blur(20px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-title-bar {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            padding: 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .page-title-bar h2 {
            font-size: 2.5em;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .actions-group {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .btn-add {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 12px 24px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            border: 2px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .btn-add:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .total-count-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .count {
            background: rgba(255, 255, 255, 0.3);
            padding: 4px 12px;
            border-radius: 15px;
            margin-left: 8px;
            font-weight: 700;
        }

        .search-bar {
            padding: 30px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }

        .search-form {
            display: flex;
            max-width: 500px;
            margin: 0 auto;
            gap: 15px;
        }

        .search-form input {
            flex: 1;
            padding: 15px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 50px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: white;
        }

        .search-form input:focus {
            outline: none;
            border-color: #4facfe;
            box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
            transform: translateY(-2px);
        }

        .search-form button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .table-container {
            padding: 30px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        thead th {
            color: white;
            padding: 20px 15px;
            font-weight: 600;
            text-align: left;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #f1f5f9;
        }

        tbody tr:hover {
            background: linear-gradient(135deg, rgba(79, 172, 254, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        tbody td {
            padding: 20px 15px;
            vertical-align: middle;
            color: #334155;
            font-size: 14px;
        }

        .status-indicator {
            width: 8px;
            height: 8px;
            background: #10b981;
            border-radius: 50%;
            display: inline-block;
            margin-right: 10px;
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

        .action-links {
            display: flex;
            gap: 10px;
        }

        .action-links a {
            padding: 8px 16px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .action-links a:first-child {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .action-links a:last-child {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
        }

        .action-links a:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        tbody td a {
            color: #4facfe;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            word-break: break-all;
        }

        tbody td a:hover {
            color: #667eea;
            text-decoration: underline;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #64748b;
        }

        .empty-state img {
            width: 120px;
            height: 120px;
            opacity: 0.5;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #475569;
        }

        .empty-state p {
            font-size: 1.1em;
            margin-bottom: 30px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .page-title-bar {
                padding: 20px;
                text-align: center;
            }

            .page-title-bar h2 {
                font-size: 2em;
                margin-bottom: 15px;
            }

            .actions-group {
                justify-content: center;
                width: 100%;
            }

            .search-bar {
                padding: 20px;
            }

            .search-form {
                flex-direction: column;
            }

            .table-container {
                padding: 15px;
            }

            table {
                font-size: 12px;
            }

            thead th,
            tbody td {
                padding: 12px 8px;
            }

            .action-links {
                flex-direction: column;
                gap: 5px;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Scroll Enhancement */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f5f9;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        /* Ripple effect */
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.4);
            transform: scale(0);
            animation: ripple-animation 0.6s linear;
            pointer-events: none;
        }

        @keyframes ripple-animation {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-title-bar">
            <h2>Quản lý Videos</h2>
            <div class="actions-group">
                <a href="${pageContext.request.contextPath}/admin/videos/create" class="btn-add">+ Thêm Video mới</a>
                <div class="total-count-badge">Tổng số <span class="count">${fn:length(videos)}</span></div>
            </div>
        </div>

        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/admin/videos" method="get" class="search-form">
                <input type="text" name="keyword" placeholder="Tìm kiếm theo tiêu đề..." value="${keyword}">
                <button type="submit">Tìm kiếm</button>
            </form>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${not empty videos}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tiêu đề</th>
                                <th>URL</th>
                                <th>Người tạo</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${videos}" var="v">
                                <tr>
                                    <td><span class="status-indicator"></span>${v.id}</td>
                                    <td>${v.title}</td>
                                    <td><a href="${v.url}" target="_blank">${v.url}</a></td>
                                    <td>${v.user.username}</td>
                                    <td class="action-links">
                                        <a href="${pageContext.request.contextPath}/admin/videos/edit?id=${v.id}">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/videos/delete?id=${v.id}" 
                                           onclick="return confirm('Bạn chắc chắn muốn xóa video: ${v.title}?');">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div style="font-size: 80px; color: #cbd5e1; margin-bottom: 20px;">📹</div>
                        <h3>Không có video nào</h3>
                        <p>
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    Không tìm thấy video nào với từ khóa "<strong>${keyword}</strong>"
                                </c:when>
                                <c:otherwise>
                                    Hãy thêm video đầu tiên của bạn
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/admin/videos/create" class="btn-add">+ Thêm Video mới</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate count numbers
            const countElement = document.querySelector('.count');
            if (countElement) {
                const targetCount = parseInt(countElement.textContent) || 0;
                let currentCount = 0;
                const increment = targetCount / 20;
                
                if (targetCount > 0) {
                    const countAnimation = setInterval(() => {
                        currentCount += increment;
                        if (currentCount >= targetCount) {
                            currentCount = targetCount;
                            clearInterval(countAnimation);
                        }
                        countElement.textContent = Math.floor(currentCount);
                    }, 50);
                }
            }

            // Add ripple effect to buttons
            document.querySelectorAll('.btn-add, .search-form button, .action-links a').forEach(button => {
                button.addEventListener('click', function(e) {
                    // Skip ripple for delete links with confirm
                    if (this.getAttribute('onclick')) return;
                    
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.width = ripple.style.height = size + 'px';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.style.position = 'absolute';
                    ripple.classList.add('ripple');
                    
                    // Make button position relative if not already
                    if (getComputedStyle(this).position === 'static') {
                        this.style.position = 'relative';
                    }
                    
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });

            // Enhanced search functionality
            const searchInput = document.querySelector('input[name="keyword"]');
            if (searchInput) {
                searchInput.addEventListener('keyup', function(e) {
                    if (e.key === 'Enter') {
                        this.closest('form').submit();
                    }
                });
            }

            // Add smooth scroll to top after actions
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('success')) {
                // You can add success message handling here
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        });
    </script>
</body>
</html>