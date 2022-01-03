package com.kh.devrun.shop.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Cart;
import com.kh.devrun.shop.model.vo.Review;
import com.kh.devrun.shop.model.vo.Wishlist;

public interface ShopService {

	int insertReview(Review review);

	List<Review> selectAllReview(Map<String, Object> param);

	int countAllList(String productCode);

	int countPicReviewList(String productCode);

	int reviewDelete(int reviewNo);

	List<Review> picReviewOnly(String productCode);

	List<ProductEntity> CategoryItemAll(String parentCate);

	Attachment selectOneAttach(int reviewNo);

	List<Product> selectRecommendation(Map<String, Object> param);

	int didIHitLikes(Map<String, Object> param);

	int reviewLikeAdd(Map<String, Object> param);

	int reviewLikeDelete(Map<String, Object> param);

	int refreshCountLikes(int reviewNo);

	int wishlistAdd(Wishlist wishlist, int memberNo);

	int wishlistDelete(Map<String, Object> param);

	/* 혜진 장바구니 시작 */
	int insertCart(Cart cart);
	
	int deleteCart(List<Integer> cartNoArr);
	/* 혜진 장바구니 끝 */

	int didIHitWishlist(Map<String, Object> param);


}
