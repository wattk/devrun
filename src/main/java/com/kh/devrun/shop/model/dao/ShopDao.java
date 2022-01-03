package com.kh.devrun.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Cart;
import com.kh.devrun.shop.model.vo.Review;
import com.kh.devrun.shop.model.vo.Wishlist;

public interface ShopDao {

	int insertReview(Review review);

	int insertAttach(Attachment attach);

	List<Review> selectAllReview(Map<String, Object> param);

	int countAllList(String productCode);

	int countPicReviewList(String productCode);

	int reviewDelete(int reviewNo);

	List<Review> picReviewOnly(String productCode);

	List<ProductEntity> CategoryItemAll(String parentCate);

	Attachment selectOneAttach(int reviewNo);

	List<Product> selectRecommendation(Map<String, Object> param);

	int didIHitLikes(Map<String, Object> param);

	int insertMemberReviewLike(Map<String, Object> param);

	int reviewLikeAdd(Map<String, Object> param);

	int deleteMemberReviewLike(Map<String, Object> param);

	int reviewLikeDelete(Map<String, Object> param);

	int refreshCountLikes(int reviewNo);

	int insertWishlist(Wishlist wishlist);

	int insertMemberWishlist(Map<String, Object> param);

	int findWishlistNo(Map<String, Object> param);

	int wishlistDelete(int wishlistNo);

	/* 혜진 장바구니 시작 */
	int insertCart(Cart cart);

	int insertMemberCart(Cart cart);
	/* 혜진 장바구니 끝 */

	int didIHitWishlist(Map<String, Object> param);

}
