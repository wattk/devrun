package com.kh.devrun.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.chat.model.vo.ChatLog;
import com.kh.devrun.chat.model.vo.ChatMember;
import com.kh.devrun.member.model.vo.Member;

public interface ChatService {

	List<Member> selectAllMemberByNickname(Map<String, Object> param);

	ChatMember findChatMemberByMemberNo(Map<String, Object> param);

	int insertChatMembers(List<ChatMember> asList);

	int insertChatLog(ChatLog chatLog);

	List<ChatLog> findChatLogByChatId(String chatId);

	List<ChatLog> findChatLog(int memberNo);

	Member selectOneReceiver(Map<String, Object> param);

	int updateLastCheck(Map<String, Object> fromMessage);

	List<String> searchChatRoom(Map<String, Object> param);

	long findEndDate(Map<String, Object> param);

	int exitChatRoom(Map<String, Object> param);

	int selectMessageTotalUnreadCount(int memberNo);

	int blockExitChatRoom(Map<String, Object> param);

	List<Member> selectChatBlockMemberList(int memberNo);

	int unblockChatMember(Map<String, Object> param);

}
