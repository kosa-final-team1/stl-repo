package com.example.myapp.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        try {
            // 세션에 사용자 ID가 있는지 확인한 후, 없으면 로그인 페이지로 Redirect
            String userId = (String) session.getAttribute("userId");
            if (userId == null || userId.equals("")) {
                response.sendRedirect(request.getContextPath() + "/user/login"); // 로그인 페이지로 리다이렉트
                return false;
            } else {
                return true; // 로그인된 경우 요청을 계속 처리
            }
        } catch (Exception e) {
            e.printStackTrace(); // 예외 발생 경로 추적하여 보여줌
            logger.error("인터셉터 에러: " + e.getMessage());
        }

        return false; // 예외 발생 시 요청을 처리하지 않음
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    }
}