package com.meedawn.flower.model.service;

public interface JwtService {
	public String createToken(String subject, long time);
	public String getSubject(String token);
	public boolean isUsable(String jwt);
}
