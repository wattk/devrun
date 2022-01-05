package com.kh.devrun.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.address.model.vo.Address;

import com.kh.devrun.member.model.vo.Member;

public interface MemberService {

	Member selectOneMember(Map<String, Object> param);

	int insertMember(Member member);

	String findId(Map<String, Object> param);

	Member selectOneMemberByIdEmail(Map<String, Object> param);
	
	int updateMemberPassword(Member member);

	int updateMemberProfile(Member member);

	Member selectOneMemberById(String id);

	List<Address> selectAddressListByMemberNo(int memberNo);
	
	Member selectOneMemberByCheckKeyword(Map<String, Object> param);
	
	int memberWithdrawal(String id);

	//다현코드
	Member selectOneMemberByMemberNo(int memberNo);
	
}
