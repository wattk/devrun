package com.kh.devrun.community.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.community.model.dao.CommunityDao;
import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityComment;
import com.kh.devrun.community.model.vo.CommunityCommentEntity;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.report.model.vo.Report;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Log4j
// 빈의 이름을 정할 수 있다. (가져다 쓰는 쪽에서 참조할 수 있도록)
@Service("communityService")
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao communityDao;

	@Override
	public List<Community> selectColumnList() {
		return communityDao.selectColumnList(); // 전달할 값이 없으므로 공란
	}

	@Override
	public List<Community> columnBestList() {
		return communityDao.columnBestList();
	}

	@Override
	public List<CommunityEntity> selectFreeboardList(int offset, int limit) {
		return communityDao.selectFreeboardList(offset, limit);
	}

	@Override
	public int selectFreeboardTotalCount() {
		return communityDao.selectFreeboardTotalCount();
	}

	@Override
	public CommunityEntity selectOneFreeBoard(int communityNo) {
		return communityDao.selectOneFreeBoard(communityNo);
	}

	@Override
	public List<CommunityCommentEntity> selectFreeboardCommentList(int communityNo) {
		return communityDao.selectFreeboardCommentList(communityNo);
	}

	@Override
	public int insertFreeboardCommentEnroll(CommunityComment communityComment) {
		return communityDao.insertFreeboardComment(communityComment);
	}

	@Override
	public int commentDelete(int commentNo) {
		return communityDao.commentDelete(commentNo);
	}

	@Override
	public int updateFreeboard(Community community) {
		return communityDao.updateFreeboard(community);
	}

	@Override
	public int freeboardDelete(int communityNo) {
		return communityDao.freeboardDelete(communityNo);
	}

	@Override
	public int viewCount(int communityNo) {
		return communityDao.viewCount(communityNo);
	}

	@Override
	public List<CommunityEntity> selectFreeboardListByType(Map<String, Object> param, int offset, int limit) {
		return communityDao.selectFreeboardListByType(param, offset, limit);
	}

	@Override
	public int selectFreeboardTotalCountByType(Map<String, Object> param) {
		return communityDao.selectFreeboardTotalCountByType(param);
	}

	@Override
	public int didIHitLikes(Map<String, Object> param) {
		return communityDao.didIHitLikes(param);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int freeboardLikeAdd(Map<String, Object> param) {
		int result = 0;
		int result2 = 0;
		
		try {
			result = communityDao.insertMemberCommunityLike(param);
			result2 = communityDao.freeboardLikeAdd(param);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return result2;
	}

	@Override
	public int refreshCountLikes(int communityNo) {
		return communityDao.refreshCountLikes(communityNo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int freeboardLikeDelete(Map<String, Object> param) {
		int result = 0;
		int result2 = 0;
		
		try {
			result = communityDao.deleteMemberCommunityLike(param);
			result2 = communityDao.freeboardLikeDelete(param);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		
		return result2;
	}

	@Override
	public int insertCommunity(CommunityEntity communityEntity) {
		return communityDao.insertCommunity(communityEntity);
	}

	@Override
	public int insertColumn(Community community) {
		return communityDao.insertColumn(community);
	}

	@Override
	public int insertFreeboard(Community community) {
		return communityDao.insertFreeboard(community);
	}

	@Override
	public int insertQna(Community community) {
		return communityDao.insertQna(community);
	}

	@Override
	public int insertStudy(Community community) {
		return communityDao.insertStudy(community);
	}

	@Override
	public int insertCommunityWriteEnroll(Community community) {
		return communityDao.insertCommunityWriteEnroll(community);
	}

	@Override
	public int insertCommunityReport(Report report) {
		return communityDao.insertCommunityReport(report);
	}

	// 좋아요순 리스트
	@Override
	public List<CommunityEntity> selectLikeBoardList(Map<String, Object> param, int offset, int limit) {
		return communityDao.selectLikeBoardList(param, offset, limit);
	}

	@Override
	public List<CommunityEntity> selectCommentBoardList(Map<String, Object> param, int offset, int limit) {
		return communityDao.selectCommentBoardList(param, offset, limit);
	}





	
}
