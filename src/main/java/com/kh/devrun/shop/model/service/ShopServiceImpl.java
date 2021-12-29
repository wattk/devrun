package com.kh.devrun.shop.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.shop.model.dao.ShopDao;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDao shopDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int insertReview(Review review) {
		int result = 0;

		try {
			// 1. review insert
			result = shopDao.insertReview(review);

			Attachment attach = review.getAttach();
			log.debug("attach 없나? : {}", attach);
			if (attach != null) {
				attach.setReviewNo(review.getReviewNo());
				result = shopDao.insertAttach(attach);
			}

		} catch (Exception e) {
			log.error(e.getMessage(), e); // 로깅해주고
			throw e;
		}
		return result;
	}

	@Override
	public List<Review> selectAllReview(String productCode) {
		return shopDao.selectAllReview(productCode);
	}

	@Override
	public int countAllList(String productCode) {
		return shopDao.countAllList(productCode);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int reviewDelete(int reviewNo) {
		return shopDao.reviewDelete(reviewNo);
	}

	@Override
	public List<Review> picReviewOnly(String productCode) {
		return shopDao.picReviewOnly(productCode);
	}

	@Override
	public List<Product> CategoryItemAll(String parentCate) {
		return shopDao.CategoryItemAll(parentCate);
	}

	@Override
	public Attachment selectOneAttach(int reviewNo) {
		return shopDao.selectOneAttach(reviewNo);
	}

}
