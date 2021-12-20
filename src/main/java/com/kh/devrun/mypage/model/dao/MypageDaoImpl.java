package com.kh.devrun.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDaoImpl implements MypageDao {

	@Autowired
	private SqlSession session;

	@Override
	public int selectMessageTotalCount(int memberNo2) {
		return session.selectOne("mypage.selectMessageTotalCount", memberNo2);
	}
	
}