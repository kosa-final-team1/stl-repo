<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>셋 더 룩스 - 코디 상세</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/outfitdetail.css?v=1.0">
</head>
<body>
<header>
    <div class="container">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">셋 더 룩스</div>
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
        <div class="outfit-detail">
            <div class="outfit-image">
                <img src="${outfit.outfitUrl}" alt="코디 이미지">
            </div>
            <div class="outfit-info">
                <h2 class="outfit-title">${outfit.outfitInfo}</h2>
                <p class="outfit-description">
                    <strong>스타일 태그:</strong> ${outfit.styleTags}<br>
                </p>
                <div class="product-list">
                    <c:forEach var="product" items="${products}">
                        <div class="product-item">
                            <a href="javascript:void(0);" onclick="redirectToProductPage('${fn:escapeXml(product.productUrl)}', '${fn:escapeXml(product.productName)}', '${fn:escapeXml(product.productBrand)}', '${fn:escapeXml(product.productPrice)}')">
                                <img src="${product.productUrl}" alt="${product.productName}">
                                <div class="product-details">
                                    <h3 class="product-name">${product.productName}</h3>
                                    <p class="product-brand">${product.productBrand}</p>
                                    <p class="product-price">${product.productPrice}</p>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</main>

<footer>
    <div class="container">
        <p>&copy; 2024 StyleSync. All rights reserved.</p>
    </div>
</footer>

<script>
    function redirectToProductPage(productUrl, productName, productBrand, productPrice) {
        var encodedProductUrl = encodeURIComponent(productUrl);
        var encodedProductName = encodeURIComponent(productName);
        var encodedProductBrand = encodeURIComponent(productBrand);
        var encodedProductPrice = encodeURIComponent(productPrice);

        var url = '${pageContext.request.contextPath}/productbuy?productUrl=' + encodedProductUrl +
            '&productName=' + encodedProductName +
            '&productBrand=' + encodedProductBrand +
            '&productPrice=' + encodedProductPrice;

        window.location.href = url;
    }
</script>
</body>
</html>