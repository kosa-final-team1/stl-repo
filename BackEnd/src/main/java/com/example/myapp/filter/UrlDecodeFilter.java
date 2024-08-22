package com.example.myapp.filter;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

public class UrlDecodeFilter extends HttpFilter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 시 필요한 작업을 수행할 수 있습니다.
    }

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // 요청 URL을 디코딩
        String decodedUrl = URLDecoder.decode(request.getRequestURI(), StandardCharsets.UTF_8.name());

        // 디코딩된 URL을 사용해서 다음 필터로 넘어갑니다.
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 필터 종료 시 필요한 작업을 수행할 수 있습니다.
    }
}