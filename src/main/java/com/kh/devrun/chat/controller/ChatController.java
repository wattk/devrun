package com.kh.devrun.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.devrun.chat.model.service.ChatService;
import com.kh.devrun.member.model.vo.Member;

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
	
	/**
	 * 회원 닉네임 검색 - 채팅방 생성을 위한 전단계
	 */
	@ResponseBody
	@GetMapping("/searchNickname.do")
	public List<Member> searchNickname(@RequestParam(required = false) String searchNickname) {
		// required = false 하면 기본값으로 파라미터를 전달받을 때, 값이 없다면 Exception 없이 코드를 실행시킨다.
		log.debug("존재합니까? 검색? {}", searchNickname);
		List<Member> list = chatService.selectAllMemberByNickname(searchNickname);
		log.debug("list = {}", list);
		
		return list;
	}

}
