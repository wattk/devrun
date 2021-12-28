package com.kh.devrun.memberManage.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.memberManage.model.dao.MemberManageDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {

	@Autowired
	private MemberManageDao memberManageDao;

	@Override
	public List<Member> searchMemberList(Map<String, Object> param) {		
		return memberManageDao.searchMemberList(param);
	}
}






