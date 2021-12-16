package com.kh.devrun.member.dao;

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
	public Member selectOneMember(String id) {
		return session.selectOne("member.selectOneMember", id);
	}
	
	/**
	 * 혜진 dao 끝
	 */
}
