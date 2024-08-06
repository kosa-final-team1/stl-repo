<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- CSS 파일을 불러오는 부분 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/login.css">
</head>
<body>
<div class="container">
    <div class="form_area">
        <p class="title">LOGIN</p>
        <form action="/user/login" method="post">
            <div class="form_group">
                <label class="sub_title" for="userId">User ID</label>
                <input placeholder="Enter your User ID" id="userId" name="userId" class="form_style" type="text" required>
            </div>
            <div class="form_group">
                <label class="sub_title" for="userPw">Password</label>
                <input placeholder="Enter your password" id="userPw" name="userPw" class="form_style" type="password" required>
            </div>
            <div>
                <button type="submit" class="btn">LOGIN</button>
                <p>Don't have an Account? <a class="link" href="/user/signup">Sign Up Here!</a></p>
            </div>
        </form>
    </div>
</div>
</body>
</html>