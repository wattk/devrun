package com.kh.devrun.chat.model.service;

import java.util.List;

import com.kh.devrun.member.model.vo.Member;

public interface ChatService {

	List<Member> selectAllMemberByNickname(String searchNickname);

}
