<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>셋 더 룩스 - 당신만의 패션 큐레이터</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/home.css">
</head>
<body>
<header>
    <div class="container">
        <nav>
            <div class="logo">셋 더 룩스</div>
            <ul>
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/mypage">마이페이지</a></li>
                    </c:when>
                </c:choose>
            </ul>
        </nav>
    </div>
</header>

<main>
    <section id="home" class="hero">
        <div class="hero-content">
            <h1>당신만의 스타일을<br>발견하세요</h1>
            <p>개인 맞춤 패션 큐레이션으로 당신의 스타일을 한 단계 업그레이드하세요.</p>
            <c:choose>
                <c:when test="${empty sessionScope.userId}">
                    <a href="${pageContext.request.contextPath}/user/signup" class="cta-button">시작하기</a>
                    <a href="${pageContext.request.contextPath}/user/login" class="cta-button">로그인</a>
                </c:when>
                <c:when test="${not empty sessionScope.userId}">
                    <a href="http://localhost:8501" class="cta-button">패션 물어보기</a>
                </c:when>
            </c:choose>
        </div>
    </section>

    <c:choose>
        <c:when test="${not empty sessionScope.userId}">
            <!-- 첫 번째 스타일 섹션 -->
            <c:if test="${not empty firstStyleOutfits}">
                <section id="outfit-section-1">
                    <h2 class="section-title">셋 더 룩스가 추천하는 코디 - ${firstStyleName}</h2>
                    <div class="outfit-grid">
                        <c:forEach var="outfit" items="${firstStyleOutfits}">
                            <div class="outfit-item">
                                <a href="${pageContext.request.contextPath}/outfitdetail?weatherNo=${outfit.weatherNo}&styleNo=${outfit.styleNo}&styleIdx=${outfit.styleIdx}">
                                    <img src="${outfit.outfitUrl}" alt="Outfit Image">
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </c:if>

            <!-- 두 번째 스타일 섹션 -->
            <c:if test="${not empty secondStyleOutfits}">
                <section id="outfit-section-2">
                    <h2 class="section-title">셋 더 룩스가 추천하는 코디 - ${secondStyleName}</h2>
                    <div class="outfit-grid">
                        <c:forEach var="outfit" items="${secondStyleOutfits}">
                            <div class="outfit-item">
                                <a href="${pageContext.request.contextPath}/outfitdetail?weatherNo=${outfit.weatherNo}&styleNo=${outfit.styleNo}&styleIdx=${outfit.styleIdx}">
                                    <img src="${outfit.outfitUrl}" alt="Outfit Image">
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </c:if>

            <!-- 세 번째 스타일 섹션 -->
            <c:if test="${not empty thirdStyleOutfits}">
                <section id="outfit-section-3">
                    <h2 class="section-title">셋 더 룩스가 추천하는 코디 - ${thirdStyleName}</h2>
                    <div class="outfit-grid">
                        <c:forEach var="outfit" items="${thirdStyleOutfits}">
                            <div class="outfit-item">
                                <a href="${pageContext.request.contextPath}/outfitdetail?weatherNo=${outfit.weatherNo}&styleNo=${outfit.styleNo}&styleIdx=${outfit.styleIdx}">
                                    <img src="${outfit.outfitUrl}" alt="Outfit Image">
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </c:if>
        </c:when>
        <c:otherwise>
            <!-- 로그인되지 않은 경우 랜덤 추천 -->
            <section id="outfit-section">
                <h2 class="section-title">셋 더 룩스가 추천하는 코디</h2>
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
        </c:otherwise>
    </c:choose>
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