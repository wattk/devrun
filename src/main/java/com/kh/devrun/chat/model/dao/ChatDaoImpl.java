package com.kh.devrun.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.chat.model.vo.ChatLog;
import com.kh.devrun.chat.model.vo.ChatMember;
import com.kh.devrun.member.model.vo.Member;

@Repository
public class ChatDaoImpl implements ChatDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<Member> selectAllMemberByNickname(Map<String, Object> param) {
		return session.selectList("chat.selectAllMemberByNickname", param);
	}

	@Override
	public ChatMember findChatMemberByMemberNo(Map<String, Object> param) {
		return session.selectOne("chat.findChatMemberByMemberNo", param);
	}

	@Override
	public int insertChatMember(ChatMember chatMember) {
		return session.insert("chat.insertChatMember", chatMember);
	}

	@Override
	public int insertChatLog(ChatLog chatLog) {
		return session.insert("chat.insertChatLog", chatLog);
	}

	@Override
	public List<ChatLog> findChatLogByChatId(String chatId) {
		return session.selectList("chat.findChatLogByChatId", chatId);
	}

	@Override
	public List<ChatLog> findChatLog(int memberNo) {
		return session.selectList("chat.findChatLog", memberNo);
	}

	@Override
	public Member selectOneReceiver(Map<String, Object> param) {
		return session.selectOne("chat.selectOneReceiver", param);
	}

	@Override
	public int updateLastCheck(Map<String, Object> fromMessage) {
		return session.update("chat.updateLastCheck", fromMessage);
	}

	@Override
	public List<String> searchChatRoom(Map<String, Object> param) {
		return session.selectList("chat.searchChatRoom", param);
	}

	@Override
	public long findEndDate(Map<String, Object> param) {
		return session.selectOne("chat.findEndDate", param);
	}

	@Override
	public int exitChatRoom(Map<String, Object> param) {
		return session.update("chat.exitChatRoom", param);
	}

	@Override
	public int selectMessageTotalUnreadCount(int memberNo) {
		return session.selectOne("chat.selectMessageTotalUnreadCount", memberNo);
	}
}
