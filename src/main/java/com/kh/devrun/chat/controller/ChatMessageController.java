package com.kh.devrun.chat.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.kh.devrun.chat.model.service.ChatService;
import com.kh.devrun.chat.model.vo.ChatLog;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatMessageController {

	@Autowired
	private ChatService chatService;
	
	/**
	 * 	/app/chat/chat_1234
	 * 	-> @MessageMapping(/chat/chat_1234)
	 * 	-> @SendTo(/chat/chat_1234) : SimpleBroker에 전달
	 * 
	 * 	database chat_log 테이블에 insert처리
	 * 
	 * @param chatId
	 * @param chatLog
	 * @return
	 */
	@MessageMapping("/chat/{chatId}")
	@SendTo(value={"/chat/{chatId}", "/chat/chatList"})
	public ChatLog chatLog(@DestinationVariable String chatId, ChatLog chatLog) {
		// Web에서 사용할때는 @PathVariable을 사용하지만 @MessageMapping에서 추출할 때는 @DestinationVariable을 사용한다. - 출처 (https://sup2is.github.io/2019/06/21/websocket-2.html)
		log.debug("chatId = {}", chatId);
		log.debug("chatLog = {}", chatLog);
		
		int result = chatService.insertChatLog(chatLog);
		
		return chatLog;
	}

	@MessageMapping("/chat/readStatus/{chatId}")
	@SendTo(value={"/chat/readStatus/{chatId}", "/chat/chatList"})
	public Map<String, Object> readStatus(Map<String, Object> readStatus){
		//log.debug("readStatus = {}", readStatus);
		// 읽음 상태이므로 db chat_member.last_check update
		int result = chatService.updateLastCheck(readStatus);

		return readStatus;
	}
	
}
