package com.kh.devrun.community.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.community.model.vo.Community;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	@Autowired
	private SqlSession session;

	@Override
	public int insertColumn(Community community) {
		return session.insert("community.insertColumn", community);
	}
}
