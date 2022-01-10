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
import com.kh.devrun.report.model.vo.Report;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	@Autowired
	private SqlSession session;
	
	// 모집중에서 모집완료로 변경
	@Override
	public int updateJoinNo(Map<String, Object> param) {
		return session.update("community.updateJoinNo", param);
	}

	// 모집완료에서 모집중으로 변경
	@Override
	public int updateJoinYes(Map<String, Object> param) {
		return session.update("community.updateJoinYes", param);
	}
	
	@Override
	public int insertColumn(Community community) {
		return session.insert("community.insertColumn", community);
	}

	@Override
	public List<CommunityEntity> selectColumnList(int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectColumnList", null, rowBounds);
	}

	@Override
	public List<CommunityEntity> columnBestList() {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("community.columnBestList", null, rowBounds);
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
	public CommunityEntity selectOneCommunity(int communityNo) {
		return session.selectOne("community.selectOneCommunity", communityNo);
	}

	@Override
	public List<CommunityCommentEntity> selectCommentList(int communityNo) {
		return session.selectList("community.selectCommentList", communityNo);
	}

	// 댓글 등록
	@Override
	public int insertComment(CommunityComment communityComment) {
		return session.insert("community.insertComment", communityComment);
	}

	@Override
	public int commentDelete(int commentNo) {
		return session.delete("community.commentDelete", commentNo);
	}

	@Override
	public int updateCommunity(CommunityEntity communityEntity) {
		return session.update("community.updateCommunity", communityEntity);
	}

	@Override
	public int communityDelete(int communityNo) {
		return session.delete("community.communityDelete", communityNo);
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

	@Override
	public int insertCommunityReport(Report report) {
		return session.insert("community.insertCommunityReport", report);
	}

	@Override
	public List<CommunityEntity> selectLikeBoardList(Map<String, Object> param, int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectLikeBoardList", param, rowBounds);
	}

	// 답변순 리스트
	@Override
	public List<CommunityEntity> selectCommentBoardList(Map<String, Object> param, int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectCommentBoardList", param, rowBounds);
	}

	// 스터디 리스트
	@Override
	public List<CommunityEntity> selectStudyList(int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectStudyList", null, rowBounds);
	}

	@Override
	public int selectOneStudyCount() {
		return session.selectOne("community.selectStudyCount");
	}
	
	/**
	 * 지원 dao 시작
	 */
	
	@Override
	public List<CommunityEntity> selectAllPostOrderByLatest(int memberNo, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectAllPostOrderByLatest", memberNo, rowBounds);
	}

	@Override
	public int selectPostTotalCount(int memberNo) {
		return session.selectOne("community.selectPostTotalCount", memberNo);
	}
	
	@Override
	public List<CommunityEntity> selectAllPostOrderBySelectType(Map<String, Object> param, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectAllPostOrderBySelectType", param, rowBounds);
	}

	@Override
	public List<CommunityEntity> selectAllLikeOrderByLatest(int memberNo, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectAllLikeOrderByLatest", memberNo, rowBounds);
	}

	@Override
	public int selectLikeTotalCount(int memberNo) {
		return session.selectOne("community.selectLikeTotalCount", memberNo);
	}

	@Override
	public List<CommunityEntity> selectAllLikeOrderBySelectType(Map<String, Object> param, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectAllLikeOrderBySelectType", param, rowBounds);
	}

	/**
	 * 지원 dao 끝
	 */
	
	// 모집중 순 리스트
	@Override
	public List<CommunityEntity> selectJoinStartBoardList(Map<String, Object> param, int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectjoinStartBoardList", param, rowBounds);
	}

	// 모집중 게시물 수
	@Override
	public int selectOneStudyJoinStartCount() {
		return session.selectOne("community.selectOneStudyJoinStartCount");
	}

	// 모집완료 순 리스트
	@Override
	public List<CommunityEntity> selectJoinEndBoardList(Map<String, Object> param, int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectjoinEndBoardList", param, rowBounds);
	}

	// 모집완료 게시물 수
	@Override
	public int selectOneStudyJoinEndCount() {
		return session.selectOne("community.selectOneStudyJoinEndCount");
	}

	// Q&A 리스트
	@Override
	public List<CommunityEntity> selectQnAList(int offset, int limit) {
		// mybatis가 제공하는 RowBounds 객체를 하나 제공한다. -- 페이징 처리를 위해서
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("community.selectQnAList", null, rowBounds);
	}

	@Override
	public int selectOneQnACount() {
		return session.selectOne("community.selectOneQnACount");
	}

	/**
	 * 혜진 칼럼 시작
	 */
	@Override
	public int selectColumnCount() {
		return session.selectOne("community.selectColumnCount");
	}
	
	/**
	 * 혜진 칼럼 끝
	 */
}
