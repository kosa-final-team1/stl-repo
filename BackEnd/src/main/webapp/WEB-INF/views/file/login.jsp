<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleSync - 로그인</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/login.css?v=1.0">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">StyleSync</div>
    </div>
</header>

<main>
    <div class="container">
        <form class="signup-form" action="${pageContext.request.contextPath}/user/login" method="post">
            <h2 class="form-title">로그인</h2>
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
                <c:if test="${not empty errors.userId}">
                    <div class="error">${errors.userId}</div>
                </c:if>
            </div>
            <div class="form-group">
                <label for="userPw">비밀번호</label>
                <input type="password" id="userPw" name="userPw" required>
                <c:if test="${not empty errors.userPw}">
                    <div class="error">${errors.userPw}</div>
                </c:if>
            </div>
            <button type="submit" class="submit-btn">로그인</button>
        </form>
    </div>
</main>

</body>
</html>