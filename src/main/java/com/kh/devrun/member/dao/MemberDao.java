package com.kh.devrun.member.dao;

import com.kh.devrun.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(String id);

}
