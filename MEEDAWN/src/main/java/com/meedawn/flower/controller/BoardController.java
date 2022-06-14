package com.meedawn.flower.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.meedawn.flower.model.BoardDto;
import com.meedawn.flower.model.service.BoardService;

@RestController
@RequestMapping("/board")
@CrossOrigin(origins = { "*" }, maxAge = 6000)
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardService boardService;
	
	@GetMapping("/list/{pageNo}")
	public ResponseEntity<?> list(@PathVariable("pageNo") int pageNo, HttpSession session,Model model) throws Exception{
		List<BoardDto> boardList = null;
		logger.info("page : {}", pageNo);
		int item = 7;
		//시작과 끝 페이지 입력
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", pageNo*item);
		map.put("last", (pageNo+1)*item);
		
		boardList = boardService.list(map);
		
		if(boardList == null) return new ResponseEntity<Void>(HttpStatus.ACCEPTED);
		
		return new ResponseEntity<List<BoardDto>>(boardList, HttpStatus.OK);
	}
	
	@PostMapping("/write")
	public ResponseEntity<?> write(@RequestBody @Valid BoardDto boardDto, BindingResult bindingResult, Model model) throws Exception{
		logger.info("boardDto : {} ", boardDto.toString());

		if(bindingResult.hasErrors()) {
			List<ObjectError> errorList = bindingResult.getAllErrors();
			for(ObjectError error: errorList) {
				System.out.println(error.getDefaultMessage());
			}
			return new ResponseEntity<Void>(HttpStatus.NOT_MODIFIED); //406을 던져준다.
		}
		
		int res = boardService.write(boardDto);
		if(res == 1) {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}else {
			return new ResponseEntity<Void>(HttpStatus.NOT_MODIFIED);
		}
	}
	
	
	@RequestMapping(value = "/edit", method= {RequestMethod.POST, RequestMethod.PUT})
	public ResponseEntity<?> edit(@RequestBody @Valid BoardDto boardDto, BindingResult bindingResult,Model model) throws Exception{
		logger.info("boardDto : {} ", boardDto.toString());
		
		if(bindingResult.hasErrors()) {
			List<ObjectError> errorList = bindingResult.getAllErrors();
			for(ObjectError error: errorList) {
				System.out.println(error.getDefaultMessage());
			}
			return new ResponseEntity<Void>(HttpStatus.NOT_MODIFIED); //406을 던져준다.
		}
		
		int res = boardService.edit(boardDto);
		System.out.println(res);
		if(res == 1) {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}else {
			return new ResponseEntity<Void>(HttpStatus.NOT_MODIFIED);
		}
	}
	
	@RequestMapping(value = "/delete/{id}", method= {RequestMethod.POST, RequestMethod.DELETE})
	public ResponseEntity<?> delete(@PathVariable("id") int id, Model model) throws Exception{
		logger.info("id : {} ", id);
		int res = boardService.delete(id);
		System.out.println("res : "+ res);
		if(res == 1) {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}else {
			return new ResponseEntity<Void>(HttpStatus.NOT_MODIFIED);
		}
	}
}
