package com.kh.devrun.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.address.model.vo.Address;

@Repository
public class MypageDaoImpl implements MypageDao {

	@Autowired
	private SqlSession session;

	/**
	 * 지원 dao 시작
	 */
	
	@Override
	public int selectMessageTotalCount(int memberNo2) {
		return session.selectOne("mypage.selectMessageTotalCount", memberNo2);
	}

	@Override
	public int insertAddress(Address address) {
		return session.insert("mypage.insertAddress", address);
	}
	
	/**
	 * 지원 dao 끝
	 */
	
}