package com.kh.devrun.community.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityComment;
import com.kh.devrun.community.model.vo.CommunityCommentEntity;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.report.model.vo.Report;

public interface CommunityService {

	List<Community> selectColumnList();

	List<Community> columnBestList();

	List<CommunityEntity> selectFreeboardList(int offset, int limit);

	int selectFreeboardTotalCount();

	// 커뮤니티 상세보기
	CommunityEntity selectOneCommunity(int communityNo);

	// 댓글 보기
	List<CommunityCommentEntity> selectCommentList(int communityNo);

	// 댓글 등록
	int insertCommentEnroll(CommunityComment communityComment);

	int commentDelete(int commentNo);

	// 커뮤니티 수정하기
	int updateCommunity(CommunityEntity communityEntity);

	int viewCount(int communityNo);

	List<CommunityEntity> selectFreeboardListByType(Map<String, Object> param, int offset, int limit);

	int selectFreeboardTotalCountByType(Map<String, Object> param);

	int didIHitLikes(Map<String, Object> param);

	int freeboardLikeAdd(Map<String, Object> param);

	int refreshCountLikes(int communityNo);

	int freeboardLikeDelete(Map<String, Object> param);

	int insertCommunity(CommunityEntity communityEntity);

	int insertColumn(Community community);

	int insertFreeboard(Community community);

	int insertQna(Community community);

	int insertStudy(Community community);

	int insertCommunityWriteEnroll(Community community);

	int insertCommunityReport(Report report);

	List<CommunityEntity> selectLikeBoardList(Map<String, Object> param, int offset, int limit);

	List<CommunityEntity> selectCommentBoardList(Map<String, Object> param, int offset, int limit);

	// 스터디 리스트
	List<CommunityEntity> selectStudyList(int offset, int limit);

	// 스터디 전체 게시물 수
	int selectOneStudyCount();

	// 커뮤니티 게시물 삭제
	int communityDelete(int communityNo);

	//나의 커뮤니티
	List<CommunityEntity> selectAllPostOrderByLatest(int memberNo, int offset, int limit);

	int selectPostTotalCount(int memberNo);

	List<CommunityEntity> selectAllPostOrderBySelectType(Map<String, Object> param, int offset, int limit);







	
}
