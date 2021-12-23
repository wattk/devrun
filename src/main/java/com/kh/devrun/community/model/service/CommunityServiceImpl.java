package com.kh.devrun.community.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.community.model.dao.CommunityDao;
import com.kh.devrun.community.model.vo.Community;

import lombok.extern.slf4j.Slf4j;

@Slf4j
// 빈의 이름을 정할 수 있다. (가져다 쓰는 쪽에서 참조할 수 있도록)
@Service("communityService")
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao communityDao;

	@Override
	public int insertColumn(Community community) {
		return communityDao.insertColumn(community);
	}

	@Override
	public List<Community> selectColumnList() {
		return communityDao.selectColumnList(); // 전달할 값이 없으므로 공란
	}

	@Override
	public List<Community> columnBestList() {
		return communityDao.columnBestList();
	}
}
