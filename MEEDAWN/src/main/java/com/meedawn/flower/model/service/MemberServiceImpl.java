package com.meedawn.flower.model.service;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.meedawn.flower.model.MemberDto;
import com.meedawn.flower.model.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public MemberDto login(Map<String, String> map) throws Exception {
		return mapper.login(map);
	}

	@Override
	public int idCheck(String id) throws Exception {
		return mapper.idCheck(id);
	}

	@Override
	public int register(MemberDto member) throws Exception {
		return mapper.register(member);
	}

	@Override
	public int pwdcheck(Map<String, String> map) throws Exception {
		return mapper.pwdcheck(map);
	}

	@Override
	public int pwdchange(Map<String, String> map) throws Exception {
		return mapper.pwdchange(map);
	}

	@Override
	public int naverIdCheck(String naverId) throws Exception {
		return mapper.naverIdCheck(naverId);
	}

	@Override
	public int naverRegister(JSONObject data, String refresh_token) throws Exception {
		
		MemberDto member = new MemberDto();
		member.setUserId((String)data.get("id"));
		member.setUserName((String)data.get("nickname"));
		member.setEmail((String)data.get("email"));
		member.setGender(data.get("gender").toString().charAt(0));
		member.setRefresh_token(refresh_token);
		return mapper.naverRegister(member);
		
	}

	@Override
	public MemberDto naverLogin(String userId, String email) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("userId", userId);
		map.put("email", email);
		return mapper.naverLogin(map);
	}

	@Override
	public int changeRefreshToken(String naverId, String refresh_token) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("naverId", naverId);
		map.put("naverrefresh_tokenId", refresh_token);
		System.out.printf("%s 의 refresh 토큰 갱신: %s", naverId, refresh_token);
		return mapper.changeRefreshToken(map);
	}

	@Override
	public int kakaoIdCheck(String email) throws Exception {
		return mapper.kakaoIdCheck(email);
	}

	@Override
	public int kakaoRegister(MemberDto member) throws Exception {
		return mapper.kakaoRegister(member);
	}

	@Override
	public MemberDto kakaoLogin(String userId, String email) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("userId", userId);
		map.put("email", email);
		return mapper.kakaoLogin(map);
	}

}
