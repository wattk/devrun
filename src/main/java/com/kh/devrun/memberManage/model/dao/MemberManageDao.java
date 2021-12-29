package com.kh.devrun.memberManage.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.member.model.vo.Member;

public interface MemberManageDao {

	List<Member> searchMemberList(Map<String, Object> param);

	List<Member> selectAllMember(int offset, int limit);

	// 권한으로 검색할 시 분기처리
	List<Member> seachMemberListByAuthority(Map<String, Object> param);
	
	// 전체 회원 수 검색
	int selectTotalMemberCount();

	// 멤버 권한 수정
	int updateAuthority(Map<String, Object> param);

}
