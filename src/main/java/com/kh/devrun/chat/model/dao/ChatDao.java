package com.kh.devrun.chat.model.dao;

import java.util.List;

import com.kh.devrun.member.model.vo.Member;

public interface ChatDao {

	List<Member> selectAllMemberByNickname(String searchNickname);

}
