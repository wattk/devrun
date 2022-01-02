package com.kh.devrun.mypage.model.service;

import java.util.List;

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
	 * 주소 수정
	 */
	@Override
	public int updateAddress(Address address) {
		return mypageDao.updateAddress(address);
	}

	/**
	 * 주소 삭제
	 */
	@Override
	public int deleteAddress(Address address) {
		return mypageDao.deleteAddress(address);
	}

	/**
	 * 전체 주소 조회
	 */
	@Override
	public List<Address> selectAllAddressById(int memberNo) {
		return mypageDao.selectAllAddressById(memberNo);
	}

	/**
	 * 주소 상세 조회
	 */
	@Override
	public Address selectOneAddress(int addressNo) {
		return mypageDao.selectOneAddress(addressNo);
	}
	
	/**
	 * 지원 서비스 끝
	 */
	
}