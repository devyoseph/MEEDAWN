package com.meedawn.flower.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.meedawn.flower.model.MemberDto;
import com.meedawn.flower.model.service.JwtService;
import com.meedawn.flower.model.service.MemberService;

@Controller
@CrossOrigin("*")
@RequestMapping("/user") //Member 관련 작업을 처리해주기 위해 사용한다.
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JwtService jwtService;
	
	@GetMapping("/idcheck")
	public ResponseEntity<?> idCheck(@RequestParam("checkId") String id, Model model) throws Exception{
		logger.info("id_temporary : {}", id);
		int res = memberService.idCheck(id);
		return new ResponseEntity<Integer>(res, HttpStatus.OK);
	}
	
	
	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody String data, Model model, HttpSession session) throws Exception {
		//data 에는 json 포맷의 문자열이 전달
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(data);
		
		logger.info(" 아이디: {} , 비밀번호 {}",(String) jsonObj.get("userId"), (String) jsonObj.get("userPwd"));
		
		//MyBatis xml의 parameterType="map"을 활용하기 위해 다시 맵 안에 넣고 집어넣어주었다.
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", (String) jsonObj.get("userId"));
		map.put("userPwd", (String) jsonObj.get("userPwd"));
		
		MemberDto member = memberService.login(map);
		
		if(member == null) { // 값을 불러오지 못했다면 Model을 통해 파라미터로 메시지 전달 
			model.addAttribute("msg", "아이디와 비밀번호를 확인해주세요!");
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT); //없는 경우 NO_CONTENT로 보낸다
		}else { // 로그인에 성공했다면 ajax 입장에서 페이지를 리로드
			session.setAttribute("userInfo", member);
			String userToken = jwtService.createToken(member.getUserId()+"", (60*1000*15));
			logger.info("유저에게 토큰 발행: {} ", userToken);
			
			session.setAttribute("token", userToken); //세션으로 토큰을 저장해준다.
			return new ResponseEntity<Void>(HttpStatus.OK); //찾은 경우 OK로 보낸다.
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/sessionout") //세션만료와 로그아웃을 구분한다.
	public String sessionout(HttpSession session, HttpServletResponse response,Model model) {
		session.invalidate();
		response.setStatus(304);
		System.out.println("세션 종료 메서드");
		return "index";
	}
	
	
	@PostMapping("/register")
	public ResponseEntity<?> register(@RequestBody @Valid MemberDto member, Model model, BindingResult bindingResult) throws Exception{
		member.setPlatform("site");
		int res = memberService.register(member);
		logger.info("회원가입정보 : {}", member);
		
		if(bindingResult.hasErrors()) {
			//logger.info("회원가입정보 : {}", member); 내부에서 로거가 발동하지 않는다.
			List<ObjectError> errorList = bindingResult.getAllErrors();
			for(ObjectError error: errorList) {
				System.out.println(error.getDefaultMessage());
			}
			return new ResponseEntity<Void>(HttpStatus.NOT_ACCEPTABLE); //406을 던져준다.
		}
		
		if(res == 1) {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}else {
			return new ResponseEntity<Void>(HttpStatus.NOT_ACCEPTABLE); //406으로 반환한다
		}
		
	}
	
	@PostMapping("/resetpwd")
	public ResponseEntity<?> resetpwd(@RequestBody String data, Model model, HttpSession session) throws Exception {
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(data);
		
		logger.info(" 아이디: {} , 비밀번호 {}",(String) jsonObj.get("userId"), (String) jsonObj.get("userPwd"));
		
		//MyBatis xml의 parameterType="map"을 활용하기 위해 다시 맵 안에 넣고 집어넣어주었다.
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", (String) jsonObj.get("userId"));
		map.put("userPwd", (String) jsonObj.get("userPwd"));
		
		int res = memberService.pwdcheck(map);
		
		if(res == 0) { // 값을 불러오지 못했다면 현재비밀번호가 맞지 않다는 뜻
			
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT); //없는 경우 NO_CONTENT로 보낸다
			
		}else { // 현재 비밀번호가 일치한다면 비밀번호 변경을 진행
			map.put("userPwd", (String) jsonObj.get("newPwd")); //새로운 비밀번호로 변경
			res = memberService.pwdchange(map);
			
			if(res==0)return new ResponseEntity<Void>(HttpStatus.LOCKED);
		
			else return new ResponseEntity<Void>(HttpStatus.OK); //변경에 성공한 경우 OK로 보낸다
		}
	}
}
