package com.meedawn.flower.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

/* 소켓 열기/닫기, 메세지 발송 */
@Component
public class SocketHandler extends TextWebSocketHandler {

	//HashMap<String, WebSocketSession> sessionMap = new HashMap<>();
	
	//Map: 원래는 웹소캣 세션만 담았지만 리스트 안에 방 정보를 같이 담는다.
	List<HashMap<String, Object>> sessionInfo = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		//메시지 발송
		String msg = message.getPayload();
		JSONObject obj = JsonToObjectParser(msg);
		
		String client_roomNumber = (String) obj.get("roomNumber");
		HashMap<String, Object> temp = new HashMap<String, Object>();
		System.out.println("sessionInfo의 사이즈 : "+sessionInfo.size()+" 메시지: "+msg);
		if(sessionInfo.size() > 0) {
			for(int i=0; i<sessionInfo.size(); i++) { //세션리스트의 저장된 방번호를 검색
				String roomNumber = (String) sessionInfo.get(i).get("roomNumber"); //같은 방을 탐색해서
				if(roomNumber.equals(client_roomNumber)) {
					temp = sessionInfo.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
					break;
				}
			}
			
			//해당 방의 세션들만 찾아서 메시지를 발송해준다.
			for(String k : temp.keySet()) { 
				if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
					continue;
				}
				
				WebSocketSession wss = (WebSocketSession) temp.get(k);
				if(wss != null) {
					try {
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//소켓 연결
		super.afterConnectionEstablished(session);
		boolean flag = false;
		
		String url = session.getUri().toString();
		System.out.println(url);
		String roomNumber = url.split("/chatting/")[1];
		
		int room_idx = -1;
		for(int i=0; i<sessionInfo.size(); i++) {
			String rN = (String) sessionInfo.get(i).get("roomNumber");
			if(rN.equals(roomNumber)) {
				flag = true;
				room_idx = i;
				break;
			}
		}
		
		if(flag) { //객체는 주소로 연결: 존재하는 방이라면 세션만 추가한다.
			HashMap<String, Object> map = sessionInfo.get(room_idx);
			map.put(session.getId(), session);
		}else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("roomNumber", roomNumber);
			map.put(session.getId(), session);
			sessionInfo.add(map);
		}
		
		
		JSONObject obj = new JSONObject();
		obj.put("type", "getId"); // 클라이언트로 보내는 데이터에 데이터 타입을 알려주는 기능
		obj.put("sessionId", session.getId()); // 세션 ID 값을 보내준다.
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//소켓 종료
		if(sessionInfo.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			for(int i=0; i<sessionInfo.size(); i++) {
				sessionInfo.get(i).remove(session.getId());
			}
		}
		super.afterConnectionClosed(session, status);
	}
	
	// Json 형식의 문자열을 Json Object로 생성
	private JSONObject JsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
}
