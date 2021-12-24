package com.kh.devrun.community.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityEntity;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int insertColumn(Community community) {
		return session.insert("community.insertColumn", community);
	}

	@Override
	public List<Community> selectColumnList() {
		return session.selectList("community.selectColumnList");
	}

	@Override
	public List<Community> columnBestList() {
		return session.selectList("community.columnBestList");
	}

	@Override
	public int insertFreeboard(Community community) {
		return session.insert("community.insertFreeboard", community);
	}

	@Override
	public List<CommunityEntity> selectFreeboardList() {
		return session.selectList("community.selectFreeboardList");
	}

	
}
