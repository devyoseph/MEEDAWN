package com.meedawn.flower.model.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.meedawn.flower.model.MemberDto;

@Mapper
public interface MemberMapper {
	MemberDto login(Map<String, String> map) throws Exception;
	int idCheck(String id) throws Exception;
	int register(MemberDto member) throws Exception;
	int	pwdcheck(Map<String, String> map) throws Exception;
	int pwdchange(Map<String, String> map) throws Exception;
	
	//네이버 관련
	int naverIdCheck(String naverId) throws Exception;
	int naverRegister(MemberDto member) throws Exception;
	MemberDto naverLogin(Map<String, String> map) throws Exception;
	int changeRefreshToken(Map<String, String> map) throws Exception;
	
	//카카오 관련
	int kakaoIdCheck(String email) throws Exception;
	int kakaoRegister(MemberDto member) throws Exception;
	MemberDto kakaoLogin(Map<String, String> map) throws Exception;
}
