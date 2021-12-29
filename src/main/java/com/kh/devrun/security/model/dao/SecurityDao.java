package com.kh.devrun.security.model.dao;

import org.springframework.security.core.userdetails.UserDetails;

import com.kh.devrun.member.model.vo.Member;

public interface SecurityDao {

	UserDetails loadUserByUsername(String username);

	int insertAuthorities(int memberNo);

}
