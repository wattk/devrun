package com.kh.devrun.community.model.service;

import java.util.List;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityEntity;

public interface CommunityService {

	int insertColumn(Community community);

	List<Community> selectColumnList();

	List<Community> columnBestList();

	int insertFreeboard(Community community);

	List<CommunityEntity> selectFreeboardList(int offset, int limit);

	int selectFreeboardTotalCount();

	CommunityEntity selectOneFreeBoard(int communityNo);



	
}
