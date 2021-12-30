package com.kh.devrun.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

public interface ShopDao {

	int insertReview(Review review);

	int insertAttach(Attachment attach);

	List<Review> selectAllReview(String productCode);

	int countAllList(String productCode);

	int countPicReviewList(String productCode);

	int reviewDelete(int reviewNo);

	List<Review> picReviewOnly(String productCode);

	List<ProductEntity> CategoryItemAll(String parentCate);

	Attachment selectOneAttach(int reviewNo);

}
