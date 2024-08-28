<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>셋 더 룩스 - 로그인</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/login.css">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">셋 더 룩스</div>
    </div>
</header>

<main>
    <div class="container">
        <form class="signup-form" action="${pageContext.request.contextPath}/user/login" method="post">
            <h2 class="form-title">로그인</h2>
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="userPw">비밀번호</label>
                <input type="password" id="userPw" name="userPw" required>
            </div>
            <button type="submit" class="submit-btn">로그인</button>
        </form>
    </div>
</main>

<!-- 오류 발생 시 표시할 모달 -->
<c:if test="${not empty message}">
    <div class="modal" style="display: flex;">
        <div class="modal-content">
            <span class="modal-close">&times;</span>
            <h2>로그인 오류</h2>
            <p>비밀번호가 틀렸습니다. <br>다시 시도해주세요.</p>
            <button id="closeModalBtn" class="submit-btn">확인</button>
        </div>
    </div>
</c:if>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const errorModal = document.querySelector('.modal');
        const closeModalButtons = document.querySelectorAll('.modal-close, #closeModalBtn');

        closeModalButtons.forEach(button => {
            button.addEventListener('click', function() {
                if (errorModal) {
                    errorModal.style.display = 'none';
                }
            });
        });

        window.addEventListener('click', function(event) {
            if (event.target === errorModal) {
                errorModal.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>