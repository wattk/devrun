package com.kh.devrun.member.model.service;

import java.util.List;
import java.util.Map;

import javax.mail.Address;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.member.model.dao.MemberDao;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.security.model.dao.SecurityDao;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SecurityDao securityDao;

	
	/**
	 * 혜진 서비스 시작
	 */

	@Override
	public Member selectOneMember(Map<String, Object> param) {
		return memberDao.selectOneMember(param);
	}

	@Override
	@Transactional(
		propagation = Propagation.REQUIRED,
		isolation = Isolation.READ_COMMITTED,
		rollbackFor = Exception.class
	)
	public int insertMember(Member member) {
		int result = 0;
		try {
			result = memberDao.insertMember(member); 
			result = securityDao.insertAuthorities(member.getMemberNo());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public List<Address> selectAddressListByMemberNo(int memberNo) {
		return memberDao.selectAddressListByMemberNo(memberNo);
	}
	
	/**
	 * 혜진 서비스 끝
	 */
	
	
	/**
	 * 지영 서비스 시작
	 */
	

	/**
	 * 아이디 찾기
	 */
	@Override
	public String findId(Map<String, Object> param) {
		return memberDao.findId(param);
	}
	
	/**
	 * 비밀번호 찾기 - 아이디 이메일로 회원 조회
	 */
	@Override
	public Member selectOneMemberByIdEmail(Map<String, Object> param) {
		return memberDao.selectOneMemberByIdEmail(param);
	}

	/**
	 * 비밀번호 찾기 - 임시 비밀번호로 변경
	 */
	@Override
	public int updateMemberPassword(Member member) {
		return memberDao.updateMemberPassword(member);
	}

	/**
	 * 지영 서비스 끝
	 */
	
	/**
	 * 지원 서비스 시작
	 */
	
	/**
	 * 프로필 수정(회원정보 수정)
	 */
	@Override
	public int updateMemberProfile(Member member) {
		return memberDao.updateMemberProfile(member);
	}
	
	/**
	 * 회원 한명 조회(by id)
	 */
	@Override
	public Member selectOneMemberById(String id) {
		return memberDao.selectOneMemberById(id);
	}

	/**
	 * 회원 한명 조회(by checkKeyword)
	 */
	@Override
	public Member selectOneMemberByCheckKeyword(Map<String, Object> param) {
		return memberDao.selectOneMemberByCheckKeyword(param);
	}

	@Override
	public int memberWithdrawal(String id) {
		return memberDao.memberWithdrawal(id);
	}

	/**
	 * 지원 서비스 끝
	 */
	
	//다현코드
	@Override
	public Member selectOneMemberByMemberNo(int memberNo) {
		return memberDao.selectOneMemberByMemberNo(memberNo);
	}
	
}
