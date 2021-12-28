package com.kh.devrun.memberManage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.member.model.vo.Member;

@Repository
public class MemberManageDaoImpl implements MemberManageDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<Member> searchMemberList(Map<String, Object> param) {
		return session.selectList("memberManage.searchMemberList",param);
	}
	
}
