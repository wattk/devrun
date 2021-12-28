package com.kh.devrun.memberManage.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.member.model.vo.Member;

public interface MemberManageDao {

	List<Member> searchMemberList(Map<String, Object> param);

}
