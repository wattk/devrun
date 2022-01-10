package com.kh.devrun.community.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityComment;
import com.kh.devrun.community.model.vo.CommunityCommentEntity;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.report.model.vo.Report;

public interface CommunityDao {
	
	// 모집중에서 모집완료로 변경
	int updateJoinNo(Map<String, Object> param);

	// 모집완료에서 모집중으로 변경
	int updateJoinYes(Map<String, Object> param);

	int insertColumn(Community community);

	List<Community> selectColumnList();

	List<Community> columnBestList();

	int insertFreeboard(Community community);

	List<CommunityEntity> selectFreeboardList(int offset, int limit);

	int selectFreeboardTotalCount();
	
	// 커뮤니티 상세보기
	CommunityEntity selectOneCommunity(int communityNo);

	// 댓글 보기
	List<CommunityCommentEntity> selectCommentList(int communityNo);

	// 댓글 등록
	int insertComment(CommunityComment communityComment);

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

	int insertQna(Community community);

	int insertStudy(Community community);

	int insertMemberCommunityLike(Map<String, Object> param);

	int deleteMemberCommunityLike(Map<String, Object> param);

	int insertCommunityWriteEnroll(Community community);

	int insertCommunityReport(Report report);

	List<CommunityEntity> selectLikeBoardList(Map<String, Object> param, int offset, int limit);

	List<CommunityEntity> selectCommentBoardList(Map<String, Object> param, int offset, int limit);

	// 스터디 리스트
	List<CommunityEntity> selectStudyList(int offset, int limit);
	
	// 스터디 전체 게시물 수 
	int selectOneStudyCount();

	int communityDelete(int CommunityNo);

	//나의 커뮤니티 포스팅 내역
	List<CommunityEntity> selectAllPostOrderByLatest(int memberNo, int offset, int limit);

	//나의 커뮤니티 전체 포스팅 개수
	int selectPostTotalCount(int memberNo);

	//나의 커뮤니티 포스팅 내역(옵션순)
	List<CommunityEntity> selectAllPostOrderBySelectType(Map<String, Object> param, int offset, int limit);

	//나의 커뮤니티 좋아요 내역
	List<CommunityEntity> selectAllLikeOrderByLatest(int memberNo, int offset, int limit);

	//나의 커뮤니티 전체 좋아요 개수
	int selectLikeTotalCount(int memberNo);

	//나의 커뮤니티 좋아요 내역(옵션순)
	List<CommunityEntity> selectAllLikeOrderBySelectType(Map<String, Object> param, int offset, int limit);

	// 회원 모집진행 순 리스트
	List<CommunityEntity> selectJoinStartBoardList(Map<String, Object> param, int offset, int limit);

	// 회원 모집진행 게시물 수 
	int selectOneStudyJoinStartCount();

	// 회원 모집완료 순 리스트
	List<CommunityEntity> selectJoinEndBoardList(Map<String, Object> param, int offset, int limit);

	// 회원 모집완료 게시물 수
	int selectOneStudyJoinEndCount();

	// Q&A 리스트
	List<CommunityEntity> selectQnAList(int offset, int limit);

	// QnA 전체 게시물 수 
	int selectOneQnACount();

	// 답변완료 --> 답변중
	int updateAnswerNo(Map<String, Object> param);

	// 답변중 --> 답변완료
	int updateAnswerYes(Map<String, Object> param);

	// 답변 많은 순 전체 게시물 수 
	int selectCommentTotalCountByBoard(int pageCode);

	// 타입별 검색
	List<CommunityEntity> selectBoardListByType(Map<String, Object> param, int offset, int limit);

	// 타입별 검색 총 게시물 수
	int selectCommunityTotalCountByType(Map<String, Object> param);

	// 최근답변순 정렬
	List<CommunityEntity> selectcurrentCommentBoardList(Map<String, Object> param, int offset, int limit);



}
