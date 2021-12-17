package com.kh.devrun.member.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.member.model.dao.MemberDao;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.security.dao.SecurityDao;

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

	
	/**
	 * 혜진 서비스 끝
	 */
	
	
	/**
	 * 지영 서비스 시작
	 */
	
	@Override
	public String findId(Map<String, Object> param) {
		return memberDao.findId(param);
	}
	
	/**
	 * 지영 서비스 끝
	 */
}
