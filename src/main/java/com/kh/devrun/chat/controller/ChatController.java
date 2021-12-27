package com.kh.devrun.chat.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kh.devrun.chat.model.service.ChatService;
import com.kh.devrun.chat.model.vo.ChatLog;
import com.kh.devrun.chat.model.vo.ChatMember;
import com.kh.devrun.common.DevrunUtils;
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

	@GetMapping("/chatRoom.do/{chatId}")
	public String chatRoom(@PathVariable String chatId, Model model) {
		
		model.addAttribute("chatId", chatId); // 이부분 없어도 chatId jsp에서 사용 가능함.
		
		
		return "chat/chatRoomPopup";
	}
	
	/**
	 * 회원 닉네임 검색 - 채팅방 생성을 위한 전단계
	 */
	@ResponseBody
	@GetMapping("/searchNickname.do")
	public List<Member> searchNickname(Authentication authentication, @RequestParam(required = false) String searchNickname) {
		// required = false 하면 기본값으로 파라미터를 전달받을 때, 값이 없다면 Exception 없이 코드를 실행시킨다.
		
		// 본인 닉네임 제외한 리스트를 불러오기 위해 loginMember 호출
		Member loginMember = (Member) authentication.getPrincipal();
		String nickname = loginMember.getNickname();
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchNickname", searchNickname);
		param.put("nickname", nickname);
		
		log.debug("searchNickname = {}", searchNickname);
		List<Member> list = chatService.selectAllMemberByNickname(param);
		log.debug("list = {}", list);
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("/chat.do")
	public String chat(Authentication authentication, Model model, @RequestParam(required = false) int receiverNo) {
		Member loginMember = (Member) authentication.getPrincipal();
		log.debug("loginMember = {}", loginMember);
		String chatId = null;
		int memberNo = loginMember.getMemberNo();
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", memberNo);
		param.put("receiverNo", receiverNo);
		
		//log.debug("memberNo = {}", memberNo);
		// 1. 채팅방 조회 : chat_member테이블의 해당회원과 상대방 간의 레코드가 있는가
		ChatMember chatSender = chatService.findChatMemberByMemberNo(param);
		log.debug("chatSender = {}", chatSender);
		
		// 2. 첫 접속인 경우 : chat_member테이블에 insert작업
		if(chatSender == null) {
			chatId = DevrunUtils.getRandomChatId();
			log.debug("chatId = {}", chatId);
			chatSender = new ChatMember(chatId, memberNo, receiverNo, 0, null, null, "Y");
			ChatMember chatReceiver = new ChatMember(chatId, receiverNo, memberNo, 0, null, null, "Y");
			chatService.insertChatMembers(Arrays.asList(chatSender, chatReceiver));
		}
		// 3. 이미 접속한 경우 : chatId 조회
		else {
			chatId = chatSender.getChatId();
		}
		
		return chatId;
	}
	

}
