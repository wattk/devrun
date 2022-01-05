package com.kh.devrun.memberManage.model.dao;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberManageDaoImpl implements MemberManageDao {

	@Autowired
	private SqlSession session;

	// 이름,번호,별명,검색
	@Override
	public List<Member> searchMemberList(Map<String, Object> param) {
		int limit = (int)param.get("limit");
		int offset = (int)param.get("offset");
		RowBounds rowBounds = new RowBounds(offset,limit);
				
		return session.selectList("memberManage.searchMemberList",param,rowBounds);
	}

	// 전체 회원 리스트
	@Override
	public List<Member> selectAllMember(int offset,int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("memberManage.selectAllMember",null,rowBounds);
	}
	
	// 권한으로 검색
	@Override
	public List<Member> seachMemberListByAuthority(Map<String, Object> param) {
		int limit = (int)param.get("limit");
		int offset = (int)param.get("offset");
		RowBounds rowBounds = new RowBounds(offset,limit);				
		
		String key = (String) param.get("searchKeyword");
		
		// 문자열 -> 리스트로 변환 후 mapper에서 반복문 사용 
		String[]keys = key.split(",");
		List<String>searchKeyword = Arrays.asList(keys);
		param.put("searchKeyword", searchKeyword);
		
		log.debug("searchKeyword = {}",searchKeyword);  
		log.debug("param = {}",param);  
		
		return session.selectList("memberManage.seachMemberListByAuthority",param,rowBounds);
	}
	
	// 비동기 전체 조회
	@Override
	public List<Member> selectSearchAllMember(Map<String, Object> param) {
		int limit = (int)param.get("limit");
		int offset = (int)param.get("offset");
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return session.selectList("memberManage.selectSearchAllMember",param,rowBounds);
	}

	// 전체 회원 수 검색
	@Override
	public int selectTotalMemberCount() {
		return session.selectOne("memberManage.selectTotalMemberCount");
	}
	
	//  검색한 회원의 수 
	@Override
	public int searchMemberListCount(Map<String, Object> param) {		
		return session.selectOne("memberManage.searchMemberListCount", param);
	}
	
	//  권한으로 검색한 회원의 수 
	@Override
	public int searchMemberListCountByAuthority(Map<String, Object> param) {		
		return session.selectOne("memberManage.searchMemberListCountByAuthority", param);
	}
	
	// 비동기로 전체 검색한 회원 수
	@Override
	public int searchMemberListCountByAll(Map<String, Object> param) {
		return session.selectOne("memberManage.searchMemberListCountByAll",param);
	}
	
	// 멤버 권한 수정
	@Override
	public int updateAuthority(Map<String, Object> param) {		
		return session.update("memberManage.updateAuthority",param);
	}




	
}
