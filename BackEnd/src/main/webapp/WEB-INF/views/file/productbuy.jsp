<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleSync - 상품 구매</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/productbuy.css">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">StyleSync</div>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/">홈</a></li>
                <li><a href="${pageContext.request.contextPath}/chatbot">패션 물어보기</a></li>
                <li><a href="${pageContext.request.contextPath}/user/mypage">마이페이지</a></li>
            </ul>
        </nav>
    </div>
</header>

<main>
    <div class="container">
        <div class="product-detail">
            <div class="product-image">
                <img src="${productUrl}" alt="상품 이미지">
            </div>
            <div class="product-info">
                <h2 class="product-title">${productName}</h2>
                <p class="product-brand"><strong>브랜드:</strong> ${productBrand}</p>
                <p class="product-price"><strong>가격:</strong> ${productPrice}</p>
                <a href="#" class="buy-button">구매하기</a>
            </div>
        </div>
    </div>
</main>

<footer>
    <div class="container">
        <p>&copy; 2024 StyleSync. All rights reserved.</p>
    </div>
</footer>
</body>
</html>