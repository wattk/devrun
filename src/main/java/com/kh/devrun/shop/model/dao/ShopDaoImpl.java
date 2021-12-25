package com.kh.devrun.shop.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ShopDaoImpl implements ShopDao{
	
	@Autowired
	private SqlSession session;
	
	@Override
	public int insertReview(Review review) {
		return session.insert("shop.insertReview", review);
	}

	@Override
	public int insertAttach(Attachment attach) {
		return session.insert("shop.insertAttach",attach);
	}

	@Override
	public List<Review> selectAllReview() {
		return session.selectList("shop.selectAllReview");
	}

	@Override
	public int countAllList() {
		return session.selectOne("shop.countAllList");
	}

}
