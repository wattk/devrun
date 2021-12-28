package com.kh.devrun.member.model.dao;

import java.util.List;
import java.util.Map;

import javax.mail.Address;

import com.kh.devrun.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(Map<String, Object> param);

	int insertMember(Member member);

	String findId(Map<String, Object> param);

	Member selectOneMemberByIdEmail(Map<String, Object> param);

	int updateMemberPassword(Member member);

	int updateMemberProfile(Member member);

	Member selectOneMemberById(String id);

	List<Address> selectAddressListByMemberNo(int memberNo);
	
}
