package com.kh.devrun.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductEx;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Cart;
import com.kh.devrun.shop.model.vo.Review;
import com.kh.devrun.shop.model.vo.Wishlist;
import com.kh.devrun.shop.model.vo.WishlistProduct;

public interface ShopDao {

	/* 혜진 장바구니 시작 */
	int insertCart(Cart cart);

	int insertMemberCart(Cart cart);

	int deleteCart(List<Integer> cartNoArr);
	/* 혜진 장바구니 끝 */

	int insertReview(Review review);

	int insertAttach(Attachment attach);

	List<Review> selectAllReview(Map<String, Object> param);

	int countAllList(String productCode);

	int countPicReviewList(String productCode);

	int reviewDelete(int reviewNo);

	List<Review> picReviewOnly(String productCode);

	List<ProductEx> CategoryItemAll(String parentCate);

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

	int didIHitWishlist(Map<String, Object> param);

	List<WishlistProduct> selectAllWishlist(int memberNo);

	ProductDetail selectOneProductDetail(int detailNo);

	int updateViewCount(String productCode);

	int insertSmsWatinglist(Map<String, Object> param);

	List<ProductEx> selectItemsByChildCate(String childCategoryCode);

	int countItemsByParentCode(String parentCate);

	int countItemsByChildCode(String childCategoryCode);

}
