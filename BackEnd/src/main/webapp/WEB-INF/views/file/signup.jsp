<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>셋 더 룩스 - 회원가입</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/signup.css?v=1.0">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">셋 더 룩스</div>
    </div>
</header>

<main>
    <div class="container">
        <form:form modelAttribute="user" action="${pageContext.request.contextPath}/user/signup" method="post" class="signup-form">
            <h2 class="form-title">회원가입</h2>

            <!-- 아이디 입력 필드 -->
            <div class="form-group">
                <label for="userId">아이디 <span class="form-text">| 아이디는 5자에서 15자 내로 설정해주세요.</span></label>
                <form:input path="userId" id="userId" required="required"/>
                <form:errors path="userId" cssClass="error"/>
            </div>

            <!-- 비밀번호 입력 필드 -->
            <div class="form-group">
                <label for="userPw">비밀번호 <span class="form-text">| 비밀번호는 8자에서 15자 내로 설정해주세요.</span></label>
                <form:password path="userPw" id="userPw" required="required"/>
                <form:errors path="userPw" cssClass="error"/>
            </div>

            <!-- 성별 선택 필드 -->
            <div class="form-group">
                <label for="gender">성별</label>
                <form:select path="gender" id="gender" required="required">
                    <form:option value="">선택하세요</form:option>
                    <form:option value="Male">남성</form:option>
                    <form:option value="Female">여성</form:option>
                </form:select>
                <form:errors path="gender" cssClass="error"/>
            </div>

            <!-- 나이 입력 필드 -->
            <div class="form-group">
                <label for="age">나이</label>
                <form:input path="age" id="age" type="number" required="required" min="1" max="120"/>
            </div>

            <!-- 선호 패션 타입 선택 필드 -->
            <div class="form-group">
                <label>선호 패션 타입 <span class="form-text">| 최대 3가지의 패션 타입을 선택할 수 있습니다.</span></label>
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
                <form:errors path="styleNo" cssClass="error"/>
            </div>

            <!-- 선택된 스타일 값을 저장할 숨겨진 입력 필드 -->
            <input type="hidden" id="styleNo" name="styleNo" />
            <button type="submit" class="submit-btn">가입하기</button>
        </form:form>
    </div>
</main>

<!-- 모달 -->
<div id="signupModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>회원가입 완료</h2>
        <p>회원가입이 성공적으로 완료되었습니다. <br>환영합니다!</p>
        <button id="modalCloseBtn">닫기</button>
    </div>
</div>

<script>
    document.querySelectorAll('.fashion-type-btn').forEach(button => {
        button.addEventListener('click', function() {
            if (this.classList.contains('selected')) {
                this.classList.remove('selected');
            } else {
                const selectedCount = document.querySelectorAll('.fashion-type-btn.selected').length;
                if (selectedCount < 3) {
                    this.classList.add('selected');
                } else {
                    alert("최대 3가지의 패션 타입만 선택할 수 있습니다.");
                }
            }
            updateSelectedStyles();
        });
    });

    function updateSelectedStyles() {
        const selectedStyles = Array.from(document.querySelectorAll('.fashion-type-btn.selected'))
            .map(btn => btn.getAttribute('data-value'));
        document.getElementById('styleNo').value = selectedStyles.join(',');
    }

    updateSelectedStyles();

    var modal = document.getElementById("signupModal");
    var closeBtn = document.querySelector(".close");
    var redirectButton = document.getElementById("modalCloseBtn");

    function openModal() {
        modal.style.display = "block";
    }

    function closeModal() {
        modal.style.display = "none";
        window.location.href = "${pageContext.request.contextPath}/user/login";
    }

    closeBtn.onclick = function() {
        closeModal();
    }

    redirectButton.onclick = function() {
        closeModal();
    }

    // 회원가입 완료 후 모달
    document.querySelector('.signup-form').addEventListener('submit', function(event) {
        event.preventDefault();

        fetch("${pageContext.request.contextPath}/user/signup", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams(new FormData(this))
        }).then(response => {
            if (response.ok) {
                openModal();
            } else {
                alert("회원가입 처리 중 오류가 발생했습니다.");
            }
        }).catch(error => {
            console.error('Error:', error);
            alert("회원가입 처리 중 오류가 발생했습니다.");
        });
    });
</script>
</body>
</html>