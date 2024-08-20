<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleSync - 마이페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/mypage.css?v=1.0">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">StyleSync</div>
    </div>
</header>

<main>
    <div class="container">
        <c:if test="${not empty message}">
            <div class="alert alert-warning">
                    ${message}
            </div>
        </c:if>
        <form:form modelAttribute="user" action="${pageContext.request.contextPath}/user/update" method="post" class="mypage-form">
            <h2 class="form-title">마이페이지</h2>
            <div class="form-group">
                <label for="userId">아이디</label>
                <form:input path="userId" id="userId" readonly="true"/>
            </div>
            <div class="form-group">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" id="currentPassword" name="currentPassword" required/>
            </div>
            <div class="form-group">
                <label for="newPassword">새 비밀번호 (변경시에만 입력)</label>
                <input type="password" id="newPassword" name="newPassword"/>
            </div>
            <div class="form-group">
                <label for="gender">성별</label>
                <form:select path="gender" id="gender" required="required">
                    <form:option value="Male">남성</form:option>
                    <form:option value="Female">여성</form:option>
                </form:select>
            </div>
            <div class="form-group">
                <label for="age">나이</label>
                <form:input path="age" id="age" type="number" required="required" min="1" max="120"/>
            </div>
            <div class="form-group">
                <label>선호 패션 타입 | 복수 선택 가능</label>
                <div class="fashion-types">
                    <button type="button" class="fashion-type-btn" data-value="1">걸리쉬</button>
                    <button type="button" class="fashion-type-btn" data-value="2">고프코어</button>
                    <button type="button" class="fashion-type-btn" data-value="3">레트로</button>
                    <button type="button" class="fashion-type-btn" data-value="4">미니멀</button>
                    <button type="button" class="fashion-type-btn" data-value="5">비즈니스캐주얼</button>
                    <button type="button" class="fashion-type-btn" data-value="6">스트릿</button>
                    <button type="button" class="fashion-type-btn" data-value="7">스포티</button>
                    <button type="button" class="fashion-type-btn" data-value="8">시크</button>
                    <button type="button" class="fashion-type-btn" data-value="9">아메카지</button>
                    <button type="button" class="fashion-type-btn" data-value="10">캐주얼</button>
                </div>
            </div>
            <input type="hidden" id="styleNo" name="styleNo" />
            <button type="submit" class="submit-btn">정보 수정</button>
        </form:form>
        <form action="${pageContext.request.contextPath}/user/delete" method="post" class="delete-form">
            <button type="submit" class="delete-btn">회원 탈퇴</button>
        </form>
    </div>
</main>

<script>
    document.querySelectorAll('.fashion-type-btn').forEach(button => {
        button.addEventListener('click', function() {
            this.classList.toggle('selected');
            updateSelectedStyles();
        });
    });

    function updateSelectedStyles() {
        const selectedStyles = Array.from(document.querySelectorAll('.fashion-type-btn.selected'))
            .map(button => button.getAttribute('data-value'));
        document.getElementById('styleNo').value = selectedStyles.join(',');
    }

    // 페이지 로드 시 사용자의 현재 스타일 선택
    window.addEventListener('load', function() {
        const currentStyles = '${user.styleNo}'.split(',');
        currentStyles.forEach(style => {
            const button = document.querySelector(`.fashion-type-btn[data-value="${style}"]`);
            if (button) {
                button.classList.add('selected');
            }
        });
        updateSelectedStyles();
    });
</script>
</body>
</html>