package com.kh.devrun.mypage.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.address.model.vo.Address;

public interface MypageService {
	
	int selectMessageTotalCount(int memberNo2);
	
	int updateMainAddress(int memberNo);
	
	int insertAddress(Address address);
	
	int updateAddress(Address address);

	int deleteAddress(Address address);

	List<Address> selectAllAddressByMemberNo(int memberNo, int offset, int limit);
	
	int selectAddressTotalCount(int memberNo);

	Address selectOneAddress(int addressNo);

	Address selectOneAddressByTitle(Map<String, Object> param);
	
}