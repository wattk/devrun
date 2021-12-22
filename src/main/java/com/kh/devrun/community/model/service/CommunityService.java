package com.kh.devrun.community.model.service;

import java.util.List;

import com.kh.devrun.community.model.vo.Community;

public interface CommunityService {

	int insertColumn(Community community);

	List<Community> selectColumnList();

}
