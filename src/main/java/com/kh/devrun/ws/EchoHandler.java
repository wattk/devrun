package com.kh.devrun.ws;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class EchoHandler extends TextWebSocketHandler {

	// * 접속한 웹소켓 세션 관리하겠다.
	// * 동기화 지원이란 - 누가 작업할 때 다른애들은 접근하지 못하게 보장한다는 것.
	/**
	 * ThreadSafe한 ArrayList
	 * - 동기화지원
	 */
	List<WebSocketSession> sessionList = new CopyOnWriteArrayList<>();
	
	// 웹소켓 연결 직후에 이루어지는 것.
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.debug("[현재 세션수 {}] {} 연결!",sessionList.size(), session.getId());
	}

	// 메세지가 왔다의 부분.
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 누가 뭘 보냈다를 체킹하고 싶다.
		String sessionId = session.getId();
		// data속성에 있는 값이 getPayload() 하면 나온다.
		String payload = message.getPayload(); // 실제내용
		
		// 다른 세션들에게 전달하겠다.
		for(WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(sessionId + " : " + payload)); // 전달된 메세지를 바로 전달하겠다.
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.debug("[현재 세션수 {}] {} 연결해제!",sessionList.size(), session.getId());
	}
	
	

}
