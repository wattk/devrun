package com.kh.devrun.community.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.community.model.dao.CommunityDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao communityDao;
}
