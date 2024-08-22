<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleSync - 당신만의 패션 큐레이터</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/home.css">
</head>
<body>
<header>
    <div class="container">
        <nav>
            <div class="logo">StyleSync</div>
            <ul>
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <!-- 로그인 상태: 로그아웃 버튼을 상단 네비게이션 바의 홈 버튼 왼쪽에 위치 -->
                        <li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/mypage">마이페이지</a></li>
                    </c:when>
                </c:choose>
                <li><a href="#home">홈</a></li>
                <li><a href="#features">기능</a></li>
                <li><a href="#contact">문의</a></li>
            </ul>
        </nav>
    </div>
</header>

<main>
    <section id="home" class="hero">
        <div class="hero-content">
            <h1>당신만의 스타일을<br>발견하세요</h1>
            <p>개인 맞춤 패션 큐레이션으로 당신의 스타일을 한 단계 업그레이드하세요.</p>
            <!-- 로그인 상태에 따라 다른 버튼 표시 -->
            <c:choose>
                <c:when test="${empty sessionScope.userId}">
                    <!-- 비로그인 상태: 시작하기와 로그인 버튼 표시 -->
                    <a href="${pageContext.request.contextPath}/user/signup" class="cta-button">시작하기</a>
                    <a href="${pageContext.request.contextPath}/user/login" class="cta-button">로그인</a>
                </c:when>
                <c:when test="${not empty sessionScope.userId}">
                    <!-- 로그인 상태: 챗봇 페이지로 연결되는 버튼 -->
                    <a href="${pageContext.request.contextPath}/chatbot" class="cta-button">패션 물어보기</a>
                </c:when>
            </c:choose>
        </div>
    </section>

    <section id="outfit-section">
        <h2 class="section-title">StyleSync가 추천하는 코디</h2>
        <div class="outfit-grid">
            <c:forEach var="outfit" items="${outfits}">
                <div class="outfit-item">
                    <a href="${pageContext.request.contextPath}/outfitdetail?weatherNo=${outfit.weatherNo}&styleNo=${outfit.styleNo}&styleIdx=${outfit.styleIdx}">
                        <img src="${outfit.outfitUrl}" alt="Outfit Image">
                    </a>
                </div>
            </c:forEach>
        </div>
    </section>

    <section id="features" class="section">
        <div class="container">
            <h2 class="section-title">StyleSync의 특별한 기능</h2>
            <div class="feature-grid">
                <div class="feature-card">
                    <div class="feature-icon">🎨</div>
                    <h3 class="feature-title">코디 추천</h3>
                    <p>당신의 취향을 분석하여 최적의 코디를 추천해드립니다.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔍</div>
                    <h3 class="feature-title">실시간 트렌드 분석</h3>
                    <p>글로벌 패션 트렌드를 분석하여 알맞는 스타일을 제안합니다.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🛍️</div>
                    <h3 class="feature-title">스마트 쇼핑</h3>
                    <p>추천 아이템을 바로 구매할 수 있는 편리한 쇼핑 경험을 제공합니다.</p>
                </div>
            </div>
        </div>
    </section>
</main>

<footer>
    <div class="container">
        <p>&copy; 2024 StyleSync. All rights reserved.</p>
    </div>
</footer>

<script>
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        header.classList.toggle('scrolled', window.scrollY > 50);
    });
</script>
</body>
</html>