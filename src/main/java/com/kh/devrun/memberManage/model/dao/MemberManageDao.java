package com.kh.devrun.memberManage.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.member.model.vo.Member;

public interface MemberManageDao {

	List<Member> searchMemberList(Map<String, Object> param);

	List<Member> selectAllMember();

	// 권한으로 검색할 시 분기처리
	List<Member> seachMemberListByAuthority(Map<String, Object> param);

}
