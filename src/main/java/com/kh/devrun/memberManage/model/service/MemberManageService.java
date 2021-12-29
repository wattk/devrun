package com.kh.devrun.memberManage.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.member.model.vo.Member;

public interface MemberManageService {

	List<Member> searchMemberList(Map<String, Object> param);

	List<Member> selectAllMember(int offset, int limit);

	// 전체 회원수
	int selectTotalMemberCount();

	// 멤버 권한 수정
	int updateAuthority(Map<String, Object> param);

}
