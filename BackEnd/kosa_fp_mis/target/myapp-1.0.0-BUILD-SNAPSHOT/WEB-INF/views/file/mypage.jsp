<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <!-- CSS 파일을 불러오는 부분 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/mypage.css">
    <script>
        function confirmDelete() {
            if(confirm("회원 탈퇴를 하시겠습니까?")) {
                document.getElementById("deletePwContainer").style.display = "block";
            }
        }

        function deleteUser() {
            var deletePw = document.getElementById("deletePwInput").value;
            if(deletePw) {
                document.getElementById("deletePw").value = deletePw; // 비밀번호를 hidden input에 설정
                document.getElementById("deleteForm").submit();
            } else {
                alert("비밀번호를 입력하세요.");
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="form_area">
        <p class="title">My Page</p>
        <form action="/user/update" method="post" style="display:inline;">
            <div class="form_group">
                <label class="sub_title" for="userPw">New Password</label>
                <input placeholder="Enter your new password" id="userPw" name="userPw" class="form_style" type="password" required>
            </div>
            <div class="form_group">
                <label class="sub_title" for="prefType">Preferred Type</label>
                <input placeholder="Enter your preferred type" id="prefType" name="prefType" class="form_style" type="text" required>
            </div>
            <div>
                <button type="submit" class="btn update-btn">Update</button>
            </div>
        </form>
        <form id="deleteForm" action="/user/delete" method="post" style="display:inline;">
            <input type="hidden" id="deletePw" name="userPw">
            <button type="button" class="btn delete-btn" onclick="confirmDelete()">Delete</button>
        </form>
    </div>
</div>

<!-- 비밀번호 입력 후 탈퇴 처리 -->
<div id="deletePwContainer" class="modal">
    <div class="modal-content">
        <span class="close" onclick="document.getElementById('deletePwContainer').style.display='none'">&times;</span>
        <p>비밀번호를 입력하여 회원 탈퇴를 진행하세요.</p>
        <input type="password" id="deletePwInput" class="form_style" placeholder="비밀번호 입력">
        <button type="button" class="btn confirm-btn" onclick="deleteUser()">확인</button>
    </div>
</div>

</body>
</html>