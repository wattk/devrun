package com.kh.devrun.member.model.service;

import java.util.Map;

import com.kh.devrun.member.model.vo.Member;

public interface MemberService {

	Member selectOneMember(Map<String, Object> param);

	int insertMember(Member member);

	String findId(Map<String, Object> param);

	Member selectOneMemberByIdEmail(Map<String, Object> param);
	
	int updateMemberPassword(Member member);


}
