package com.kh.devrun.member.model.dao;

import java.util.List;
import java.util.Map;

import javax.mail.Address;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession session;

	/**
	 * 혜진 dao 시작
	 */

	@Override
	public Member selectOneMember(Map<String, Object> param) {
		return session.selectOne("member.selectOneMember", param);
	}

	@Override
	public int insertMember(Member member) {
		return session.insert("member.insertMember", member);
	}

	@Override
	public List<Address> selectAddressListByMemberNo(int memberNo) {
		return session.selectList("address.selectAddressListByMemberNo", memberNo);
	}

	/**
	 * 혜진 dao 끝
	 */

	/**
	 * 지영 dao 시작
	 */

	@Override
	public String findId(Map<String, Object> param) {
		return session.selectOne("member.findId", param);
	}

	@Override
	public Member selectOneMemberByIdEmail(Map<String, Object> param) {
		return session.selectOne("member.selectOneMemberByIdEmail", param);
	}

	@Override
	public int updateMemberPassword(Member member) {
		return session.update("member.updateMemberPassword", member);
	}

	/**
	 * 지영 dao 끝
	 */

	/**
	 * 지원 dao 시작
	 */

	@Override
	public int updateMemberProfile(Member member) {
		return session.update("member.updateMemberProfile", member);
	}

	@Override
	public Member selectOneMemberById(String id) {
		return session.selectOne("member.selectOneMemberById", id);
	}

	@Override
	public Member selectOneMemberByCheckKeyword(Map<String, Object> param) {
		return session.selectOne("member.selectOneMemberByCheckKeyword", param);
	}

	@Override
	public int memberWithdrawal(String id) {
		return session.delete("member.memberWithdrawal", id);
	}

	/**
	 * 지원 dao 끝
	 */

	@Override
	public Member selectOneMemberByMemberNo(int memberNo) {
		return session.selectOne("member.selectOneMemberByMemberNo", memberNo);
	}

}
