package com.meedawn.flower.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.HttpResource;

import com.meedawn.flower.model.MemberDto;
import com.meedawn.flower.model.SnapshotDto;
import com.meedawn.flower.model.service.MemberService;
import com.meedawn.flower.model.service.SnapshotService;

@RestController
@RequestMapping("/snapshot")
public class SnapshotController {
	private static final Logger logger = LoggerFactory.getLogger(SnapshotController.class);
	
	@Autowired
	private SnapshotService snapshotService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ServletContext servletContext;
	
	@PostMapping("/basic")
	public ResponseEntity<?> getBasic() throws Exception{
		System.out.println("Snapshot : Basic 요청");
		ArrayList<SnapshotDto> list = snapshotService.getBasic();
		if(list == null) {
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT); //없으면 204
		}
		return new ResponseEntity<ArrayList<SnapshotDto>>(list, HttpStatus.OK);
	}
	
	@PostMapping("/user")
	public ResponseEntity<?> getUser(@RequestBody MemberDto memberDto) throws Exception{
		System.out.println("Snapshot : User 요청");
		
		
		SnapshotDto snapshotDto = new SnapshotDto();
		
		if(memberDto.getPlatform().equals("site")) {
			snapshotDto.setMember_userid(memberDto.getUserId());
		}else { //플랫폼이 소셜로그인이라면 따로 가져와야한다.
			snapshotDto.setMember_userid(memberService.getSocialId(memberDto.getUserId(), memberDto.getPlatform()));
		}
		
		ArrayList<SnapshotDto> list = snapshotService.getUser(snapshotDto);
		if(list == null) {
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT); //없으면 204
		}
		
		return new ResponseEntity<ArrayList<SnapshotDto>>(list, HttpStatus.OK);
	}
	
	//제목, 내용 = GuestBookDto로 들어감, 파일 = file로 받는다.
	@PostMapping(value = "/register")
	public ResponseEntity<?> register(@RequestPart(value = "key") SnapshotDto snapshotDto, @RequestPart(value = "file", required = false) MultipartFile file,
			HttpSession session) throws Exception {
		
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		System.out.println(memberDto.toString());
		
		if(memberDto.getPlatform().equals("site")) {
			snapshotDto.setMember_userid(memberDto.getUserId());
		}else { //플랫폼이 소셜로그인이라면 따로 가져와야한다.
			snapshotDto.setMember_userid(memberService.getSocialId(memberDto.getUserId(), memberDto.getPlatform()));
		}
		System.out.println("유저 : "+snapshotDto.getMember_userid()+" "+snapshotDto.toString());
		
		/*  FileUpload 관련 설정   */
		if (!file.isEmpty()) { // 빈 파일이 아닌 경우, upload하는 실제 경로를 얻어오기
			String realPath = "/Users/yang-yoseb/git/repository/MEEDAWN/src/main/webapp/resources/img/portfolio/user"; 

     
			
			//저장할 폴더명에 이메일을 붙인다. 
			String path = realPath + File.separator + memberDto.getEmail() + File.separator ;
				
	      
			System.out.println("저장 폴더 : {} "+ path);
				
			File folder = new File(path);
				//폴더 만든적이 없다면 폴더 만들기
			if (!folder.exists()) folder.mkdirs();
				
			
			String originalFileName = file.getOriginalFilename();
			String saveFileName = UUID.randomUUID().toString()
							+ originalFileName.substring(originalFileName.lastIndexOf('.'));
					
			snapshotDto.setOriginal_filename(saveFileName);
					
			System.out.println("원본 파일 이름 : "+ file.getOriginalFilename()+" 실제 저장 파일 이름 : " +saveFileName);
			
			file.transferTo(new File(folder, saveFileName)); //중요!!
			
			//DB상 경로 등록
			snapshotDto.setPath(path+saveFileName);
			
			if(memberDto.getUserId().equals("admin")) {
				snapshotDto.setHost("admin");
			}else {
				snapshotDto.setHost("user");
			}
			
			snapshotService.register(snapshotDto);
		}
		
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	@GetMapping("/download")
	public ModelAndView download(@RequestParam("userId") String userId, @RequestParam("platform") String platform, 
			@RequestParam("order") int order, HttpServletRequest request, HttpServletResponse response
			, ModelAndView mv) throws Exception {
		
		if(userId == null) {
			return null;
		}
		
		SnapshotDto snapshotDto = new SnapshotDto();
		snapshotDto.setOrder(order);
		
		if(platform.equals("site")) {
			snapshotDto.setMember_userid(userId);
		}else { //플랫폼이 소셜로그인이라면 따로 가져와야한다.
			snapshotDto.setMember_userid(memberService.getSocialId(userId, platform));
		}
		
		System.out.println(snapshotDto.toString());
		String pathAll = snapshotService.getPath(snapshotDto);
		System.out.println(pathAll);
		File file = new File(pathAll);
		
		mv.setViewName("downloadView");
		mv.addObject("downloadFile", file);
		return mv;
		
	}
}
