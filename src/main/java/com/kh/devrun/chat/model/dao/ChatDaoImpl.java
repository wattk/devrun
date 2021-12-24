package com.kh.devrun.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.member.model.vo.Member;

@Repository
public class ChatDaoImpl implements ChatDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<Member> selectAllMemberByNickname(String searchNickname) {
		return session.selectList("chat.selectAllMemberByNickname", searchNickname);
	}
}
