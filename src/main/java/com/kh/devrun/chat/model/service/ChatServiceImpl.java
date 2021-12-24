package com.kh.devrun.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.chat.model.dao.ChatDao;
import com.kh.devrun.member.model.vo.Member;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;

	@Override
	public List<Member> selectAllMemberByNickname(String searchNickname) {
		return chatDao.selectAllMemberByNickname(searchNickname);
	}
}
