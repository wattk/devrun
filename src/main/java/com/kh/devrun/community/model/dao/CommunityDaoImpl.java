package com.kh.devrun.community.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityComment;
import com.kh.devrun.community.model.vo.CommunityCommentEntity;
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
	public List<CommunityEntity> selectFreeboardList(int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectFreeboardList", null, rowBounds);
	}

	@Override
	public int selectFreeboardTotalCount() {
		return session.selectOne("community.selectFreeboardCount");
	}

	@Override
	public CommunityEntity selectOneFreeBoard(int communityNo) {
		return session.selectOne("community.selectOneFreeBoard", communityNo);
	}

	@Override
	public List<CommunityCommentEntity> selectFreeboardCommentList(int communityNo) {
		return session.selectList("community.selectFreeboardCommentList", communityNo);
	}

	@Override
	public int insertFreeboardComment(CommunityComment communityComment) {
		return session.insert("community.insertFreeboardComment", communityComment);
	}


	

	
}
