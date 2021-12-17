package com.kh.devrun.security.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

@Repository
public class SecurityDaoImpl implements SecurityDao {

	@Autowired
	private SqlSession session;

	@Override
	public UserDetails loadUserByUsername(String username) {
		return session.selectOne("security.loadUserByUsername",username);
	}

	@Override
	public int insertAuthorities(int memberNo) {
		return session.insert("security.insertAuthorities", memberNo);
	}
	
	
}
