package com.kh.devrun.mypage.model.service;

import java.util.List;

import com.kh.devrun.address.model.vo.Address;

public interface MypageService {
	
	int selectMessageTotalCount(int memberNo2);
	
	int insertAddress(Address address);
	
	int updateAddress(Address address);

	int deleteAddress(Address address);

	List<Address> selectAllAddressById(int memberNo);

	Address selectOneAddress(int addressNo);
	
}