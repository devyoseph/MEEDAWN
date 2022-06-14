package com.meedawn.flower.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.meedawn.flower.model.MemberDto;
import com.meedawn.flower.model.service.JwtService;
import com.meedawn.flower.model.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/kakao")
public class KakaoController {
	//모든 변수를 private final: 값이 변경되지 않고 숨김
	private final String KAKAO_BASE_URL = "https://kauth.kakao.com/oauth/authorize";
	private final String KAKAO_GET_TOKEN_URL = "https://kauth.kakao.com/oauth/token";
	private final String KAKAO_PROFILE_URL = "https://kapi.kakao.com/v2/user/me";
	private final String KAKAO_CLIENT_ID = "44d1290b7527908304b3cbfb945fc603";
	private final String REDIRECT_URI = "http://localhost:8080/meedawn/kakao/callBack"; //경로 확인할 것
	
	private static final Logger logger = LoggerFactory.getLogger(KakaoController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JwtService jwtService; //내부적으로 토큰을 발행
	
	@GetMapping("/register") // 1. 회원가입 + 로그인 동시 확인 서비스
	public void register(HttpServletResponse response) {
			try {
				getKakaoAuthUrl(response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	private void getKakaoAuthUrl(HttpServletResponse httpServletResponse) throws Exception {
		
		final String state = new BigInteger(130, new SecureRandom()).toString();
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.scheme("https")
				.host("kauth.kakao.com")
				.path("/oauth/authorize")
				.queryParam("response_type", "code")
				.queryParam("client_id", KAKAO_CLIENT_ID)
				.queryParam("redirect_uri", REDIRECT_URI)
				.queryParam("state", state)
				.build();
		
		httpServletResponse.sendRedirect(uriComponents.toString());
	}
	
	// 카카오 연동정보 조회
	@GetMapping("/callBack")
	public String callBack(@RequestParam("code") String code,
							@RequestParam("state") String state,
							HttpSession session) throws Exception {

		logger.info("code : {}, state: {}", code, state);
                
        MemberDto member = getUserInfo(getAccessToken(code));
        
        if(member != null) { //로그인 성공시
        	String userToken = jwtService.createToken(member.getUserId()+"", (60*1000*15));
			logger.info("카카오 유저에게 내부 토큰 발행: {} ", userToken);
			
			 logger.info("user id : {}", member.getUserId());
		     logger.info("user email : {}", member.getEmail());
			session.setAttribute("token", userToken); //세션으로 토큰을 저장해준다.
        }
        
        session.setAttribute("userInfo", member);
		return "redirect:/";
	}
	
    //토큰발급
	public Map<String, String> getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";

        try {
            URL url = new URL(KAKAO_GET_TOKEN_URL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id="+KAKAO_CLIENT_ID);  //본인이 발급받은 key
            sb.append("&redirect_uri="+REDIRECT_URI);     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            logger.info("responseCode(200이면 성공) : {}", conn.getResponseCode());

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            logger.info("response body : {}" + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            logger.info("access_token : {}" + access_Token);
            logger.info("refresh_token : {}" + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        	
        	Map<String, String> tokens = new HashMap<>();
        	tokens.put("access_token", access_Token);
        	tokens.put("refresh_token", refresh_Token);
        	
        return tokens;
    }
	
    //유저정보조회
    public MemberDto getUserInfo (Map<String, String> tokens) throws Exception {

        //  정보를 담아 리턴할 Dto 선언
    	MemberDto member = new MemberDto();
      
        try {
            URL url = new URL(KAKAO_PROFILE_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + tokens.get("access_token"));

            logger.info("responseCode(200이면 정상) : {}" + conn.getResponseCode());

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            String id = element.getAsJsonObject().get("id").getAsString();
            //JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
            
            //String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            String gender_origin = kakao_account.getAsJsonObject().get("gender").getAsString();
            char gender = 'M';
            
            if(gender_origin.equals("femail")) {
            	gender = 'F';
            }
            int account_exist = memberService.kakaoIdCheck(email);
            System.out.println(email+" 의 카카오 아이디 존재 여부: "+account_exist);
          //platform_id 값이 존재하지 않는다면 부분 정보를 가지고 회원가입으로 이동
            if(account_exist == 0) {
            	logger.info("카카오 회원가입 진행: {}", email); //userid를 비워서 보내기 때문에 프론트엔드단에서 회원가입으로 이동
            	
            	member.setUserId(id);
            	member.setPlatform("kakao");
            	member.setGender(gender);
            	member.setEmail(email);
            	member.setRefresh_token(tokens.get("refresh_token"));
            	
            	memberService.register(member);
            }
            
            	logger.info("카카오 로그인 진행: {}", email); 
            	member = memberService.kakaoLogin(id, email);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return member;
    }
 }