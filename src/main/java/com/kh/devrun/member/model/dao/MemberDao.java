package com.kh.devrun.member.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.kh.devrun.address.model.vo.Address;
import com.kh.devrun.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(Map<String, Object> param);

	int insertMember(Member member);

	String findId(Map<String, Object> param);

	Member selectOneMemberByIdEmail(Map<String, Object> param);

	int updateMemberPassword(Member member);

	List<Map<String, Object>> selectWithdrawalReasonCategory();

	int updateMemberProfile(Member member);

	Member selectOneMemberById(String id);

	List<Address> selectAddressListByMemberNo(int memberNo);
	
	Member selectOneMemberByCheckKeyword(Map<String, Object> param);
	
	int memberWithdrawal(String id);
	
	int memberWithdrawalReason(Map<String, Object> param);

	Member selectOneMemberByMemberNo(int memberNo);

}
