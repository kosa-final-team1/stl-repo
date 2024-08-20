<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleSync - 회원가입</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/signup.css?v=1.0">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">StyleSync</div>
    </div>
</header>

<main>
    <div class="container">
        <form:form modelAttribute="user" action="${pageContext.request.contextPath}/user/signup" method="post" class="signup-form">
            <h2 class="form-title">회원가입</h2>
            <div class="form-group">
                <label for="userId">아이디</label>
                <form:input path="userId" id="userId" required="required"/>
                <form:errors path="userId" cssClass="error"/>
            </div>
            <div class="form-group">
                <label for="userPw">비밀번호</label>
                <form:password path="userPw" id="userPw" required="required"/>
                <form:errors path="userPw" cssClass="error"/>
            </div>
            <div class="form-group">
                <label for="gender">성별</label>
                <form:select path="gender" id="gender" required="required">
                    <form:option value="">선택하세요</form:option>
                    <form:option value="Male">남성</form:option>
                    <form:option value="Female">여성</form:option>
                </form:select>
                <form:errors path="gender" cssClass="error"/>
            </div>
            <div class="form-group">
                <label for="age">나이</label>
                <form:input path="age" id="age" type="number" required="required" min="1" max="120"/>
                <form:errors path="age" cssClass="error"/>
            </div>
            <div class="form-group">
                <label>선호 패션 타입 | 복수 선택 가능</label>
                <div class="fashion-types">
                    <button type="button" class="fashion-type-btn" data-value="1" <c:if test="${fn:contains(user.styleNo, '1')}">class="selected"</c:if>>걸리쉬</button>
                    <button type="button" class="fashion-type-btn" data-value="2" <c:if test="${fn:contains(user.styleNo, '2')}">class="selected"</c:if>>고프코어</button>
                    <button type="button" class="fashion-type-btn" data-value="3" <c:if test="${fn:contains(user.styleNo, '3')}">class="selected"</c:if>>레트로</button>
                    <button type="button" class="fashion-type-btn" data-value="4" <c:if test="${fn:contains(user.styleNo, '4')}">class="selected"</c:if>>미니멀</button>
                    <button type="button" class="fashion-type-btn" data-value="5" <c:if test="${fn:contains(user.styleNo, '5')}">class="selected"</c:if>>비즈니스캐주얼</button>
                    <button type="button" class="fashion-type-btn" data-value="6" <c:if test="${fn:contains(user.styleNo, '6')}">class="selected"</c:if>>스트릿</button>
                    <button type="button" class="fashion-type-btn" data-value="7" <c:if test="${fn:contains(user.styleNo, '7')}">class="selected"</c:if>>스포티</button>
                    <button type="button" class="fashion-type-btn" data-value="8" <c:if test="${fn:contains(user.styleNo, '8')}">class="selected"</c:if>>시크</button>
                    <button type="button" class="fashion-type-btn" data-value="9" <c:if test="${fn:contains(user.styleNo, '9')}">class="selected"</c:if>>아메카지</button>
                    <button type="button" class="fashion-type-btn" data-value="10" <c:if test="${fn:contains(user.styleNo, '10')}">class="selected"</c:if>>캐주얼</button>
                </div>
                <form:errors path="styleNo" cssClass="error"/>
            </div>
            <!-- 선택된 스타일 값을 저장할 숨겨진 입력 필드 -->
            <input type="hidden" id="styleNo" name="styleNo" />
            <button type="submit" class="submit-btn">가입하기</button>
        </form:form>
    </div>
</main>

<script>
    document.querySelectorAll('.fashion-type-btn').forEach(button => {
        button.addEventListener('click', function() {
            this.classList.toggle('selected');
            updateSelectedStyles();  // 선택된 스타일 값 업데이트
        });
    });

    // 선택된 스타일을 업데이트하여 숨겨진 필드에 설정
    function updateSelectedStyles() {
        const selectedStyles = Array.from(document.querySelectorAll('.fashion-type-btn.selected'))
            .map(button => button.getAttribute('data-value'));
        document.getElementById('styleNo').value = selectedStyles.join(',');
    }

    // 페이지 로드 시, 초기 선택된 스타일들을 hidden 필드에 설정
    updateSelectedStyles();
</script>
</body>
</html>