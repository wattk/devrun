package com.kh.devrun.mypage.model.service;

import com.kh.devrun.address.model.vo.Address;

public interface MypageService {
	
	int selectMessageTotalCount(int memberNo2);
	
	int insertAddress(Address address);
	
}