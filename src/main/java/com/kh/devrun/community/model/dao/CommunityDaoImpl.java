package com.kh.devrun.community.model.dao;

import java.util.List;
import java.util.Map;

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

	@Override
	public int commentDelete(int commentNo) {
		return session.delete("community.commentDelete", commentNo);
	}

	@Override
	public int updateFreeboard(Community community) {
		return session.update("community.updateFreeboard", community);
	}

	@Override
	public int freeboardDelete(int communityNo) {
		return session.delete("community.freeboardDelete", communityNo);
	}

	@Override
	public int viewCount(int communityNo) {
		return session.update("community.viewCount", communityNo);
	}

	@Override
	public List<CommunityEntity> selectFreeboardListByType(Map<String, Object> param, int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectFreeboardListByType", param, rowBounds);
	}

	@Override
	public int selectFreeboardTotalCountByType(Map<String, Object> param) {
		return session.selectOne("community.selectFreeboardTotalCountByType", param);
	}

	@Override
	public int didIHitLikes(Map<String, Object> param) {
		return session.selectOne("community.didIHitLikes", param);
	}

	@Override
	public int freeboardLikeAdd(Map<String, Object> param) {
		return session.update("community.freeboardLikeAdd", param);
	}

	@Override
	public int refreshCountLikes(int communityNo) {
		return session.selectOne("community.refreshCountLike", communityNo);
	}

	@Override
	public int freeboardLikeDelete(Map<String, Object> param) {
		return session.update("community.freeboardLikeDelete", param);
	}

	@Override
	public int insertCommunity(CommunityEntity communityEntity) {
		return session.insert("community.insertCommunity", communityEntity);
	}

	@Override
	public int insertQna(Community community) {
		return session.insert("community.insertQna", community);
	}

	@Override
	public int insertStudy(Community community) {
		return session.insert("community.insertStudy", community);
	}

	@Override
	public int insertMemberCommunityLike(Map<String, Object> param) {
		return session.insert("community.insertMemberCommunityLike", param);
	}

	@Override
	public int deleteMemberCommunityLike(Map<String, Object> param) {
		return session.delete("community.deleteMemberCommunityLike", param);
	}

	@Override
	public int insertCommunityWriteEnroll(Community community) {
		return session.insert("community.insertCommunityWriteEnroll", community);
	}



}
