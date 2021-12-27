package com.kh.devrun.chat.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.chat.model.vo.ChatLog;
import com.kh.devrun.chat.model.vo.ChatMember;
import com.kh.devrun.member.model.vo.Member;

public interface ChatDao {

	List<Member> selectAllMemberByNickname(Map<String, Object> param);

	ChatMember findChatMemberByMemberNo(Map<String, Object> param);

	int insertChatMember(ChatMember chatMember);

	int insertChatLog(ChatLog chatLog);

	List<ChatLog> findChatLogByChatId(String chatId);

	List<ChatLog> findChatLog(int memberNo);

	Member selectOneReceiver(Map<String, Object> param);

}
