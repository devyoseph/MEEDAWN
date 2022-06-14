package com.meedawn.flower.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.meedawn.flower.controller.MemberController;
import com.meedawn.flower.model.service.JwtService;

public class JwtInterceptor implements HandlerInterceptor{
	private static final String HEADER_AUTH = "authorization";
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
    @Autowired
    private JwtService jwtService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //final String token = request.getHeader(HEADER_AUTH);
    	final String token = (String) request.getSession().getAttribute("token");
        logger.info("JWT Interceptor Operate: {}", token);
        if(token != null && jwtService.isUsable(token)){
            return true;
        }else{
        	System.out.println("토큰이 만료되어 세션정보를 초기화합니다.");
        	response.sendRedirect(request.getContextPath()+"/user/sessionout");
            return false;
        }
    }
}
