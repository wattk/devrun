package com.kh.devrun.shop.model.service;

import java.util.List;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.shop.model.vo.Review;

public interface ShopService {

	int insertReview(Review review);

	List<Review> selectAllReview();

	int countAllList();

	int reviewDelete(int reviewNo);

	List<Review> picReviewOnly();

	List<Product> CategoryItemAll(String parentCate);

}
