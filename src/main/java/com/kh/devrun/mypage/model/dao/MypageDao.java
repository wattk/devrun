package com.kh.devrun.mypage.model.dao;

import com.kh.devrun.address.model.vo.Address;

public interface MypageDao {

	int selectMessageTotalCount(int memberNo2);
	
	int insertAddress(Address address);

}