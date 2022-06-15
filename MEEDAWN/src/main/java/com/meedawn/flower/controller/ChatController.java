package com.meedawn.flower.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.meedawn.flower.model.RoomDto;

@RestController
@RequestMapping("/chat")
public class ChatController {
	
	private List<RoomDto> roomList = new ArrayList<RoomDto>();
	static int roomNumber = 0; // 방의 번호를 부여하는 변수
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@PostMapping("/createRoom") // List<Room> 
	public ResponseEntity<?> createRoom(@RequestParam String roomName){
		boolean[] check = new boolean[5]; //최대 방의 개수는 5개
		int roomNum = -1;
		//
		for(int i=0; i<roomList.size(); i++) {
			check[roomList.get(i).getRoomNumber()] = true;
		}
		
		for(int i=0; i<5; i++) {
			if(!check[i]) {
				roomNum = i;
				i=5; //만약 빈방이 있다면 기록 후 빠져나옴
			}
		}
		
		System.out.println("채팅방 생성 시도 : "+roomName+" "+roomNum);
		if(roomNum == -1) {
			return new ResponseEntity<Void>(HttpStatus.TOO_MANY_REQUESTS); // 방이 꽉찼다면 429 던짐
		}else if(roomName != null && !roomName.trim().equals("")) {
			RoomDto room = new RoomDto();
			room.setRoomNumber(roomNum); // 최대 방 번호 +1하기
			room.setRoomName(roomName);
			room.setParticipatePerson(1); //1명
			roomList.add(room);
			return new ResponseEntity<RoomDto>(room, HttpStatus.OK); // 방 생성 성공시 방 정보를 반환
		}
		return new ResponseEntity<Void>(HttpStatus.NOT_ACCEPTABLE); // 방생성 실패시 406 던짐
	}
	
	/**
	 * 방 정보가져오기
	 * @param params
	 * @return
	 */
	@PostMapping("/getRoom")
	public ResponseEntity<?> getRoom(@RequestParam HashMap<Object, Object> params){
		return new ResponseEntity<List<RoomDto>>(roomList ,HttpStatus.OK);
	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@PostMapping("/goRoom")
	public ResponseEntity<?> goRoom(@RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		
		List<RoomDto> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", params.get("roomName"));
			mv.addObject("roomNumber", params.get("roomNumber"));
			mv.setViewName("chat");
		}else {
			mv.setViewName("room");
		}
		return new ResponseEntity<ModelAndView>(mv ,HttpStatus.OK); //성공이면 chat, 실패면 room
	}
}
