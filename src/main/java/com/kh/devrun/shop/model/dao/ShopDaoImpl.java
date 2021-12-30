package com.kh.devrun.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.shop.model.service.ShopServiceImpl;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ShopDaoImpl implements ShopDao {

	@Autowired
	private SqlSession session;

	@Override
	public int insertReview(Review review) {
		return session.insert("shop.insertReview", review);
	}

	@Override
	public int insertAttach(Attachment attach) {
		return session.insert("shop.insertAttach", attach);
	}

	@Override
	public List<Review> selectAllReview(Map<String, Object> param) {
		return session.selectList("shop.selectAllReview", param);
	}

	@Override
	public int countAllList(String productCode) {
		return session.selectOne("shop.countAllList", productCode);
	}

	@Override
	public int countPicReviewList(String productCode) {
		return session.selectOne("shop.countPicReviewList", productCode);
	}

	@Override
	public int reviewDelete(int reviewNo) {
		return session.delete("shop.reviewDelete", reviewNo);
	}

	@Override
	public List<Review> picReviewOnly(String productCode) {
		return session.selectList("shop.picReviewOnly", productCode);
	}

	@Override
	public List<ProductEntity> CategoryItemAll(String parentCate) {
		return session.selectList("shop.CategoryItemAll", parentCate);
	}

	@Override
	public Attachment selectOneAttach(int reviewNo) {
		return session.selectOne("shop.selectOneAttach", reviewNo);
	}


}
