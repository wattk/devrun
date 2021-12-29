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
			searchMemberList = memberManageDao.selectAllMember(offset, limit);
			log.debug("aaaaaaaa");
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
}






