package com.kh.devrun.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.chat.model.dao.ChatDao;
import com.kh.devrun.chat.model.vo.ChatMember;
import com.kh.devrun.member.model.vo.Member;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;

	@Override
	public List<Member> selectAllMemberByNickname(Map<String, Object> param) {
		return chatDao.selectAllMemberByNickname(param);
	}

	@Override
	public ChatMember findChatMemberByMemberNo(Map<String, Object> param) {
		return chatDao.findChatMemberByMemberNo(param);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertChatMembers(List<ChatMember> chatMembers) {
		int result = 0;
		for(ChatMember chatMember : chatMembers) {
			result = chatDao.insertChatMember(chatMember);
		}
		return result;
	}
}
