package com.kh.devrun.shop.model.service;

import java.util.List;

import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

public interface ShopService {

	int insertReview(Review review);

	List<Review> selectAllReview(String productCode);

	int countAllList(String productCode);

	int countPicReviewList(String productCode);

	int reviewDelete(int reviewNo);

	List<Review> picReviewOnly(String productCode);

	List<ProductEntity> CategoryItemAll(String parentCate);

	Attachment selectOneAttach(int reviewNo);

}
