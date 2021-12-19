package com.kh.devrun.community.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.community.model.dao.CommunityDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
// 빈의 이름을 정할 수 있다. (가져다 쓰는 쪽에서 참조할 수 있도록)
@Service("communityService")
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao communityDao;
}
