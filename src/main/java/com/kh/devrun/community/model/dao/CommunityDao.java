package com.kh.devrun.community.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityComment;
import com.kh.devrun.community.model.vo.CommunityCommentEntity;
import com.kh.devrun.community.model.vo.CommunityEntity;

public interface CommunityDao {

	int insertColumn(Community community);

	List<Community> selectColumnList();

	List<Community> columnBestList();

	int insertFreeboard(Community community);

	List<CommunityEntity> selectFreeboardList(int offset, int limit);

	int selectFreeboardTotalCount();

	CommunityEntity selectOneFreeBoard(int communityNo);

	List<CommunityCommentEntity> selectFreeboardCommentList(int communityNo);

	int insertFreeboardComment(CommunityComment communityComment);

	int commentDelete(int commentNo);

	int updateFreeboard(Community community);

	int freeboardDelete(int communityNo);

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





}
