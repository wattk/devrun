package com.kh.devrun.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.member.dao.MemberDao;
import com.kh.devrun.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	
	/**
	 * 혜진 서비스 시작
	 */

	@Override
	public Member selectOneMember(Map<String, Object> param) {
		return memberDao.selectOneMember(param);
	}

	
	/**
	 * 혜진 서비스 끝
	 */
}
