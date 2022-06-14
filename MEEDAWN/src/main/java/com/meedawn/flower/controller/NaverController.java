package com.meedawn.flower.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.meedawn.flower.model.MemberDto;
import com.meedawn.flower.model.service.JwtService;
import com.meedawn.flower.model.service.MemberService;

@Controller
@RequestMapping("/naver")
public class NaverController {
	
	/* 네이버 토큰 관련 정보
	 * access_token은 발급 받은 후 12시간-24시간(정책에 따라 변동 가능)동안 유효합니다. refresh token은 한달간 유효하며, refresh token 만료가 1주일 이내로 남은 시점에서 사용자 토큰 갱신 요청을 하면 갱신된 access token과 갱신된 refresh token이 함께 반환됩니다.
	 */
	
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	private JwtService jwtService; //내부적으로 토큰을 발행
	
	private static final Logger logger = LoggerFactory.getLogger(NaverController.class);
	
	//모든 변수를 private final: 값이 변경되지 않고 숨김
	private final String NAVER_BASE_URL = "https://nid.naver.com/oauth2.0/authorize";
	private final String NAVER_GET_TOKEN_URL = "https://nid.naver.com/oauth2.0/token";
	private final String NAVER_PROFILE_URL = "https://openapi.naver.com/v1/nid/me";
	private final String NAVER_CLIENT_ID = "I6HyiFGFQqiSHkfzOQ67";
	private final String NAVER_CLIENT_SECRET = "sQJcLMyPpf";
	private final String REDIRECT_URI = "http://localhost:8080/meedawn/naver/callBack";
	
	@GetMapping("/register")
	public void register(HttpServletResponse response) {
		try {
			redirectAuthUri(response);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//세션 회원가입을 할 때 이미 refresh_token이 있는지 확인한다.
	}
	
	//콜백으로 토큰 받아주기
	@GetMapping("/callBack")
	//@ResponseBody 
	public String callBack(@RequestParam("code") String code,
							@RequestParam("state") String state,
							HttpSession session) throws Exception {
		
		ResponseEntity<?> responseEntity = requestToken(code, state);
		Object responseMessage = responseEntity.getBody();

		Map<String, String> map = (Map<String, String>) responseMessage;
		session.setAttribute("userInfo", getNaverProfile(map, session));
		return "redirect:/";
	}
	
	
//	private ResponseEntity<?> requestToken(String code, String state) {
		
	private ResponseEntity<?> requestToken(String code, String state) {
		MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<>();
		
		requestBody.add("grant_type", "authorization_code");
		requestBody.add("client_id", NAVER_CLIENT_ID);
		requestBody.add("client_secret", NAVER_CLIENT_SECRET);
		requestBody.add("code", code);
		requestBody.add("state", state);
		
		return new RestTemplate().postForEntity(NAVER_GET_TOKEN_URL, requestBody, Map.class);
		//new RestTemplate().postForEntity(NAVER_GET_TOKEN_URL, requestBody, Map.class);
	}

	//인증 URI 생성기
	private void redirectAuthUri(HttpServletResponse httpServletResponse) throws IOException {
		
		final String state = new BigInteger(130, new SecureRandom()).toString();
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.scheme("https")
				.host("nid.naver.com")
				.path("/oauth2.0/authorize")
				.queryParam("response_type", "code")
				.queryParam("client_id", NAVER_CLIENT_ID)
				.queryParam("redirect_uri", REDIRECT_URI)
				.queryParam("state", state)
				.build();
		
		httpServletResponse.sendRedirect(uriComponents.toString());
	}	
	
	//네이버 공식 문서 예시
		private MemberDto getNaverProfile(Map<String, String> map, HttpSession session) throws Exception {
			String token = map.get("access_token"); // 네이버 로그인 접근 토큰;
	        String header = "Bearer " + token; // Bearer 다음에 공백 추가
	        System.out.println("토큰 확인 : "+token);
	        
	        boolean changeRefreshToken = false; //이미 회원인데 refreshToken이 같이 온 경우
	        
	        System.out.println("/** map 정보 **/");
	        for(String key : map.keySet()){
	            String value = map.get(key).toString();
	            System.out.println(key+" : "+value);
	        }
	        
	        System.out.println("/** ===== **/");
	        if(map.get("refresh_token") != null) {
	        	changeRefreshToken = true;
	        }
	        
	        Map<String, String> requestHeaders = new HashMap<>();
	        requestHeaders.put("Authorization", header);
	        String responseBody = get(NAVER_PROFILE_URL, requestHeaders);
	        
	        System.out.println("네이버 접속 정보 : " + responseBody);
	        
	        
	        JSONParser parser = new JSONParser();
    		JSONObject jsonObj = (JSONObject) parser.parse(responseBody);
    		JSONObject jsonObj2 =  (JSONObject) jsonObj.get("response"); //2차로 가져오기 위해 재진행
    		
    		int naverRigistered = memberService.naverIdCheck((String)jsonObj2.get("id"));
	        //네이버 id 이외의 값이 존재하지 않는다면 자동회원가입
	        if(jsonObj2.get("gender")!=null && naverRigistered == 0) {
	        	logger.info("네이버 회원가입 진행: {}", responseBody);
	        	
	        	memberService.naverRegister(jsonObj2, map.get("refresh_token"));
	        	
	        	System.out.println("네이버 회원가입 완료");
	        }
	        
	        //이미 회원인데 refresh_token이 전달된 경우(만료된 경우): 갱신해주기
	        if(naverRigistered == 1 && changeRefreshToken) {
	        	memberService.changeRefreshToken((String)jsonObj2.get("id"), map.get("refresh_token"));
	        }
	        	
	        logger.info("네이버 로그인 진행: {}", responseBody);
	        
	        MemberDto member = memberService.naverLogin((String)jsonObj2.get("id"), (String)jsonObj2.get("email"));
	        
	        if(member != null) { //로그인 성공시
	        	String userToken = jwtService.createToken(member.getUserId()+"", (60*1000*15));
				logger.info("네이버 유저에게 내부 토큰 발행: {} ", userToken);
		
				session.setAttribute("token", userToken); //세션으로 토큰을 저장해준다.
	        }
	        
	        System.out.println(jsonObj2);
	        return member;
		}

		 private static String get(String apiUrl, Map<String, String> requestHeaders){
		        HttpURLConnection con = connect(apiUrl);
		        try {
		            con.setRequestMethod("GET");
		            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
		                con.setRequestProperty(header.getKey(), header.getValue());
		            }


		            int responseCode = con.getResponseCode();
		            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
		                return readBody(con.getInputStream());
		            } else { // 에러 발생
		                return readBody(con.getErrorStream());
		            }
		        } catch (IOException e) {
		            throw new RuntimeException("API 요청과 응답 실패", e);
		        } finally {
		            con.disconnect();
		        }
		 }
		 private static HttpURLConnection connect(String apiUrl){
		        try {
		            URL url = new URL(apiUrl);
		            return (HttpURLConnection)url.openConnection();
		        } catch (MalformedURLException e) {
		            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		        } catch (IOException e) {
		            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		        }
		    }


		    private static String readBody(InputStream body){
		        InputStreamReader streamReader = new InputStreamReader(body);


		        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
		            StringBuilder responseBody = new StringBuilder();


		            String line;
		            while ((line = lineReader.readLine()) != null) {
		                responseBody.append(line);
		            }


		            return responseBody.toString();
		        } catch (IOException e) {
		            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		        }
		    } 
}
