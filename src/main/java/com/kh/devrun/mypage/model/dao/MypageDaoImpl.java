package com.kh.devrun.mypage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.address.model.vo.Address;

@Repository
public class MypageDaoImpl implements MypageDao {

	@Autowired
	private SqlSession session;

	/**
	 * 지원 dao 시작
	 */
	
	@Override
	public int selectMessageTotalCount(int memberNo2) {
		return session.selectOne("mypage.selectMessageTotalCount", memberNo2);
	}

	@Override
	public int updateMainAddress(int memberNo) {
		return session.update("mypage.updateMainAddress", memberNo);
	}
	
	@Override
	public int insertAddress(Address address) {
		return session.insert("mypage.insertAddress", address);
	}

	@Override
	public int updateAddress(Address address) {
		return session.update("mypage.updateAddress", address);
	}

	@Override
	public int deleteAddress(Address address) {
		return session.delete("mypage.deleteAddress", address);
	}

	@Override
	public List<Address> selectAllAddressByMemberNo(int memberNo, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("mypage.selectAllAddressByMemberNo", memberNo, rowBounds);
	}

	@Override
	public int selectAddressTotalCount(int memberNo) {
		return session.selectOne("mypage.selectAddressTotalCount", memberNo);
	}
	
	@Override
	public Address selectOneAddress(int addressNo) {
		return session.selectOne("mypage.selectOneAddress", addressNo);
	}

	@Override
	public Address selectOneAddressByTitle(Map<String, Object> param) {
		return session.selectOne("mypage.selectOneAddressByTitle", param);
	}

	/**
	 * 지원 dao 끝
	 */
	
}