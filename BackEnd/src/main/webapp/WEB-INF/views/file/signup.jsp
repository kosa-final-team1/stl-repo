<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/signup.css">
</head>
<body>
<div class="container">
    <div class="form_area">
        <p class="title">SIGN UP</p>
        <!-- 메시지를 표시하는 부분 -->
        <c:if test="${not empty message}">
            <div class="alert alert-danger">
                    ${message}
            </div>
        </c:if>
        <form action="/user/signup" method="post">
            <div class="form_group">
                <label class="sub_title" for="userId">User ID</label>
                <input placeholder="Enter your User ID" id="userId" name="userId" class="form_style" type="text" required>
            </div>
            <div class="form_group">
                <label class="sub_title" for="userPw">Password</label>
                <input placeholder="Enter your password" id="userPw" name="userPw" class="form_style" type="password" required>
            </div>
            <div class="form_group">
                <label class="sub_title" for="gender">Gender</label>
                <select id="gender" name="gender" class="form_style" required>
                    <option value="">Select your gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form_group">
                <label class="sub_title" for="age">Age</label>
                <input placeholder="Enter your age" id="age" name="age" class="form_style" type="number" required>
            </div>
            <div class="form_group">
                <label class="sub_title" for="prefType">Preferred Fashion Style</label>
                <input placeholder="Enter your preferred fashion style" id="prefType" name="prefType" class="form_style" type="text">
            </div>
            <div>
                <button type="submit" class="btn">SIGN UP</button>
                <p>Have an Account? <a class="link" href="/user/login">Login Here!</a></p>
            </div>
        </form>
    </div>
</div>
</body>
</html>