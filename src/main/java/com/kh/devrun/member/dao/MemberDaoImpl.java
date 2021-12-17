package com.kh.devrun.member.dao;

import java.util.Map;

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

	
	/**
	 * 혜진 dao 끝
	 */
}
