package com.meedawn.flower.model.service;

import java.util.Map;

import org.json.simple.JSONObject;

import com.meedawn.flower.model.MemberDto;

public interface MemberService {
	MemberDto login(Map<String, String> map) throws Exception;
	int idCheck(String id) throws Exception;
	int register(MemberDto member) throws Exception;
	int	pwdcheck(Map<String, String> map) throws Exception;
	int pwdchange(Map<String, String> map) throws Exception;
	
	//네이버 관련
	int naverIdCheck(String naverId) throws Exception;
	int naverRegister(JSONObject data, String refresh_token) throws Exception;
	MemberDto naverLogin(String userId, String email) throws Exception;
	int changeRefreshToken(String naverId, String refresh_token) throws Exception;
	
	//카카오 관련
	int kakaoIdCheck(String email) throws Exception;
	int kakaoRegister(MemberDto member) throws Exception;
	MemberDto kakaoLogin(String userId, String email) throws Exception;
}
