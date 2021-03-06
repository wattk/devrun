package com.kh.devrun.memberManage.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.memberManage.exception.AuthorityUpdateException;
import com.kh.devrun.memberManage.model.dao.MemberManageDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {

	@Autowired
	private MemberManageDao memberManageDao;

	@Override
	public List<Member> searchMemberList(Map<String, Object> param) {
		int offset = (int)param.get("offset");
		int limit = (int)param.get("limit");
		
		List<Member> searchMemberList = null;
		
		// searchType, searchKeyword가 a면 전체 검색으로 분기
		if("m.all".equals(param.get("searchType"))) {
			searchMemberList = memberManageDao.selectSearchAllMember(param);
			log.debug("searchAll------");
		}
			
		// 권한 검색일 경우 분기처리한다.
		else if("m.authority".equals(param.get("searchType"))) {
			log.debug("권한 검색");
			searchMemberList = memberManageDao.seachMemberListByAuthority(param);
		}
		else {
			searchMemberList = memberManageDao.searchMemberList(param);
		}
		return searchMemberList; 
	}

	@Override
	public List<Member> selectAllMember(int offset, int limit) {
		return memberManageDao.selectAllMember(offset,limit);
	}

	// 전체 회원 수
	@Override
	public int selectTotalMemberCount() {
		return memberManageDao.selectTotalMemberCount();
	}

	// 멤버 권한 수정
	@Override
	public int updateAuthority(Map<String, Object> param) {
		int result = 0;
		
		try {
			result = memberManageDao.updateAuthority(param);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new AuthorityUpdateException("권한 업데이트 오류",e);
		}		
		return result;
	}

	// 검색한 회원의 숫자(권한 검색은 분기처리)
	@Override
	public int searchMemberListCount(Map<String, Object> param) {
		int result = 0;
		
		// 전체 검색,권한 검색일 경우 분기처리한다.
		if("m.authority".equals(param.get("searchType"))) {
			log.debug("권한 검색");
			result = memberManageDao.searchMemberListCountByAuthority(param);
		}
		else if("m.all".equals(param.get("searchType"))){
			result = memberManageDao.searchMemberListCountByAll(param);
		}
		else {
			result = memberManageDao.searchMemberListCount(param);
		}
		
		return result;
	}
}






