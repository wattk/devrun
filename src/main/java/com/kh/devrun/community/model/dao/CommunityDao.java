package com.kh.devrun.community.model.dao;

import java.util.List;

import com.kh.devrun.community.model.vo.Community;

public interface CommunityDao {

	int insertColumn(Community community);

	List<Community> selectColumnList();

}
