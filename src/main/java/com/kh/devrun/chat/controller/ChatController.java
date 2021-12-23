package com.kh.devrun.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.devrun.chat.model.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@GetMapping("/chatList.do")
	public String chatList() {
		return "chat/chatListPopup";
	}
	
	@GetMapping("/chatRoom.do")
	public String chatRoom() {
		return "chat/chatRoomPopup";
	}

}
