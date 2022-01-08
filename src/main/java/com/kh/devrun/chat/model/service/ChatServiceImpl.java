package com.kh.devrun.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.chat.model.dao.ChatDao;
import com.kh.devrun.chat.model.vo.ChatLog;
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

	@Override
	public int insertChatLog(ChatLog chatLog) {
		return chatDao.insertChatLog(chatLog);
	}

	@Override
	public List<ChatLog> findChatLogByChatId(String chatId) {
		return chatDao.findChatLogByChatId(chatId);
	}

	@Override
	public List<ChatLog> findChatLog(int memberNo) {
		return chatDao.findChatLog(memberNo);
	}

	@Override
	public Member selectOneReceiver(Map<String, Object> param) {
		return chatDao.selectOneReceiver(param);
	}

	@Override
	public int updateLastCheck(Map<String, Object> fromMessage) {
		return chatDao.updateLastCheck(fromMessage);
	}

	@Override
	public List<String> searchChatRoom(Map<String, Object> param) {
		return chatDao.searchChatRoom(param);
	}

	@Override
	public long findEndDate(Map<String, Object> param) {
		return chatDao.findEndDate(param);
	}

	@Override
	public int exitChatRoom(Map<String, Object> param) {
		return chatDao.exitChatRoom(param);
	}

	@Override
	public int selectMessageTotalUnreadCount(int memberNo) {
		return chatDao.selectMessageTotalUnreadCount(memberNo);
	}

	@Override
	public int blockExitChatRoom(Map<String, Object> param) {
		return chatDao.blockExitChatRoom(param);
	}

	@Override
	public List<Member> selectChatBlockMemberList(int memberNo) {
		return chatDao.selectChatBlockMemberList(memberNo);
	}

	@Override
	public int unblockChatMember(Map<String, Object> param) {
		return chatDao.unblockChatMember(param);
	}
}
