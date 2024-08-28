<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>셋 더 룩스 - 마이페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/mypage.css?v=1.0">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">셋 더 룩스</div>
    </div>
</header>

<main>
    <div class="container">
        <!-- 정보 수정 및 회원 탈퇴 폼 -->
        <form:form modelAttribute="user" action="${pageContext.request.contextPath}/user/update" method="post" class="mypage-form" id="userForm">
            <h2 class="form-title">마이페이지</h2>
            <div class="form-group">
                <label for="userId">아이디</label>
                <form:input path="userId" id="userId" readonly="true" autocomplete="username"/>
            </div>
            <div class="form-group">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" id="currentPassword" name="currentPassword" required autocomplete="current-password" value="${user.userPw}"/>
            </div>
            <div class="form-group">
                <label for="newPassword">새 비밀번호 (변경시에만 입력)</label>
                <input type="password" id="newPassword" name="newPassword" autocomplete="new-password"/>
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
                <label>선호 패션 타입 (최대 3개 선택 가능)</label>
                <div class="fashion-types">
                    <!-- 패션 타입 선택 버튼들 -->
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '1') ? 'selected' : ''}" data-value="1">걸리쉬</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '2') ? 'selected' : ''}" data-value="2">고프코어</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '3') ? 'selected' : ''}" data-value="3">레트로</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '4') ? 'selected' : ''}" data-value="4">미니멀</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '5') ? 'selected' : ''}" data-value="5">비즈니스캐주얼</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '6') ? 'selected' : ''}" data-value="6">스트릿</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '7') ? 'selected' : ''}" data-value="7">스포티</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '8') ? 'selected' : ''}" data-value="8">시크</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '9') ? 'selected' : ''}" data-value="9">아메카지</button>
                    <button type="button" class="fashion-type-btn ${fn:contains(user.styleNo, '10') ? 'selected' : ''}" data-value="10">캐주얼</button>
                </div>
            </div>
            <input type="hidden" id="styleNo" name="styleNo" value="${user.styleNo}" />
            <input type="hidden" id="userPwForDelete" name="userPw" />
            <button type="button" class="submit-btn" onclick="showUpdateModal()">정보 수정</button>
            <button type="button" class="delete-btn" onclick="showDeleteModal()">회원 탈퇴</button>
        </form:form>
    </div>
</main>

<!-- 정보 수정 모달 -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="modal-close">&times;</span>
        <h2>정보 수정</h2>
        <p>변경 사항을 저장 하시겠습니까?</p>
        <button id="confirmUpdate" class="submit-btn">확인</button>
        <button id="cancelUpdate" class="delete-btn">취소</button>
    </div>
</div>

<!-- 회원 탈퇴 모달 -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="modal-close">&times;</span>
        <h2>회원 탈퇴</h2>
        <p>회원 탈퇴를 진행하시겠습니까?</p>
        <input type="password" id="passwordForDelete" placeholder="기존 비밀번호를 입력하세요" required class="modal-input" autocomplete="current-password"/>
        <button id="confirmDelete" class="submit-btn">확인</button>
        <button id="cancelDelete" class="delete-btn">취소</button>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.fashion-type-btn').forEach(button => {
            button.addEventListener('click', function() {
                // 이미 선택된 버튼을 다시 클릭하면 선택 해제
                if (this.classList.contains('selected')) {
                    this.classList.remove('selected');
                } else {
                    const selectedCount = document.querySelectorAll('.fashion-type-btn.selected').length;
                    // 최대 3개까지 선택 가능
                    if (selectedCount < 3) {
                        this.classList.add('selected');
                    } else {
                        alert("최대 3가지의 패션 타입만 선택할 수 있습니다.");
                    }
                }
                updateSelectedStyles(); // 선택된 스타일 업데이트
            });
        });

        function updateSelectedStyles() {
            // 선택된 스타일들의 data-value 값을 가져와서 콤마로 구분된 문자열로 생성
            const selectedStyles = Array.from(document.querySelectorAll('.fashion-type-btn.selected'))
                .map(btn => btn.getAttribute('data-value'));
            document.getElementById('styleNo').value = selectedStyles.join(','); // 숨겨진 필드에 저장
        }

        updateSelectedStyles(); // 페이지 로드 시 초기 스타일 업데이트

        // 모달 관련 스크립트
        const updateModal = document.getElementById('updateModal');
        const deleteModal = document.getElementById('deleteModal');
        const closeModalButtons = document.querySelectorAll('.modal-close');
        const confirmUpdate = document.getElementById('confirmUpdate');
        const confirmDelete = document.getElementById('confirmDelete');
        const cancelUpdate = document.getElementById('cancelUpdate');
        const cancelDelete = document.getElementById('cancelDelete');

        window.showUpdateModal = function() {
            updateModal.style.display = 'flex';
        }

        window.showDeleteModal = function() {
            deleteModal.style.display = 'flex';
        }

        closeModalButtons.forEach(button => {
            button.addEventListener('click', function() {
                updateModal.style.display = 'none';
                deleteModal.style.display = 'none';
            });
        });

        confirmUpdate.addEventListener('click', function() {
            document.getElementById('userForm').submit();
        });

        confirmDelete.addEventListener('click', function() {
            const passwordForDelete = document.getElementById('passwordForDelete').value;
            if (passwordForDelete) {
                document.getElementById('userPwForDelete').value = passwordForDelete;
                document.getElementById('userForm').action = '${pageContext.request.contextPath}/user/delete';
                document.getElementById('userForm').submit();
            } else {
                alert('기존 비밀번호를 입력하세요.');
            }
        });

        cancelUpdate.addEventListener('click', function() {
            updateModal.style.display = 'none';
        });

        cancelDelete.addEventListener('click', function() {
            deleteModal.style.display = 'none';
        });

        window.addEventListener('click', function(event) {
            if (event.target === updateModal) {
                updateModal.style.display = 'none';
            }
            if (event.target === deleteModal) {
                deleteModal.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>