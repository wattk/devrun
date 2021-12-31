package com.kh.devrun.mypage.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.address.model.vo.Address;
import com.kh.devrun.mypage.model.dao.MypageDao;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private MypageDao mypageDao;

	/**
	 * 지원 서비스 시작
	 */
	
	@Override
	public int selectMessageTotalCount(int memberNo2) {
		return mypageDao.selectMessageTotalCount(memberNo2);
	}

	/**
	 * 주소 등록
	 */
	@Override
	public int insertAddress(Address address) {
		return mypageDao.insertAddress(address);
	}
	
	/**
	 * 지원 서비스 끝
	 */
	
}