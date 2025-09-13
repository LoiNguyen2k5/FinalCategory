<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<head>
    <title>Thông tin cá nhân</title>
    <style>
        .profile-container { max-width: 800px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); }
        .profile-header { text-align: center; margin-bottom: 30px; }
        .profile-avatar { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; margin-bottom: 15px; border: 4px solid #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .form-row { display: flex; gap: 20px; }
        .form-group { flex: 1; margin-bottom: 15px; }
        /* Thêm các CSS cần thiết khác */
    </style>
</head>

<div class="container">
    <div class="profile-container">
        <div class="profile-header">
             <c:url value="/image" var="imgUrl">
                <c:param name="fname" value="${sessionScope.account.images}" />
            </c:url>
            <img src="${not empty sessionScope.account.images ? imgUrl : 'https://via.placeholder.com/120'}" alt="Avatar" class="profile-avatar">
            <h3>${sessionScope.account.username}</h3>
        </div>

        <form action="${pageContext.request.contextPath}/profile/update" method="post" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-group">
                    <label for="fullname">Họ và tên:</label>
                    <input type="text" id="fullname" name="fullname" class="form-control" value="${sessionScope.account.fullname}">
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại:</label>
                    <input type="text" id="phone" name="phone" class="form-control" value="${sessionScope.account.phone}">
                </div>
            </div>
            <div class="form-group">
                <label for="images">Thay đổi ảnh đại diện:</label>
                <input type="file" id="images" name="images" class="form-control-file">
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật</button>
        </form>
    </div>
</div>