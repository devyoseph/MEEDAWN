package com.meedawn.flower.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		RoomDto room = new RoomDto();
		for(int i=0; i<roomList.size(); i++) {
			if(roomNumber == roomList.get(i).getRoomNumber()) {
				int nowPerson = roomList.get(i).getParticipatePerson(); //채팅방 현재 인원수 파악
				System.out.println("goRoom :"+roomNumber+" nowPerson : "+nowPerson);
				if(nowPerson>=5) {
					return new ResponseEntity<List<RoomDto>>(roomList ,HttpStatus.NOT_ACCEPTABLE); //방이 꽉찼다면 406
				}
				
				roomList.get(i).setParticipatePerson(nowPerson+1); //백엔드: 1명 증가
				
				
				room.setParticipatePerson(nowPerson+1); // 줄 때도 한 명 증가
				room.setRoomName(roomList.get(i).getRoomName()); //방 정보 세팅
				room.setRoomNumber(roomNumber);
			}
		}
		if(room.getRoomName() != null) {
			return new ResponseEntity<RoomDto>(room ,HttpStatus.OK);
		}
		return new ResponseEntity<Void>(HttpStatus.CONFLICT); // 방에 참가하지못하면 409
	}
	
	
	@PostMapping("/exitRoom")
	public ResponseEntity<?> exitRoom(@RequestParam HashMap<Object, Object> params) {
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		System.out.println(roomNumber);
		for(int i=0; i<roomList.size(); i++) {
			if(roomNumber == roomList.get(i).getRoomNumber()) {
				int nowPerson = roomList.get(i).getParticipatePerson(); //채팅방 현재 인원수 파악
				System.out.println("exitRoom :"+roomNumber+" nowPerson : "+nowPerson);
				nowPerson--; //인원 1 감소
				
				if(nowPerson<=0) {
					roomList.remove(i); //해당 채팅방 삭제
				}else {
					roomList.get(i).setParticipatePerson(nowPerson); //백엔드: 1명 감소
				}
			}
		}
		return new ResponseEntity<Void>(HttpStatus.OK); // 방에 성공적으로 나감
	}
}
