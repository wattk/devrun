package com.kh.devrun.memberManage.model.dao;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

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

	@Override
	public List<Member> searchMemberList(Map<String, Object> param) {
		return session.selectList("memberManage.searchMemberList",param);
	}

	@Override
	public List<Member> selectAllMember() {
		return session.selectList("memberManage.selectAllMember");
	}

	// 권한으로 검색
	@Override
	public List<Member> seachMemberListByAuthority(Map<String, Object> param) {
		String key = (String) param.get("searchKeyword");
		
		// 문자열 -> 리스트로 변환 후 mapper에서 반복문 사용 
		String[]keys = key.split(",");
		List<String>searchKeyword = Arrays.asList(keys);
		param.put("searchKeyword", searchKeyword);
		
		log.debug("searchKeyword = {}",searchKeyword);  
		log.debug("param = {}",param);  
		
		return session.selectList("memberManage.seachMemberListByAuthority",param);
	}
	
}
