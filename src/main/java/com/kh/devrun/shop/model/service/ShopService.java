package com.kh.devrun.shop.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductEx;
import com.kh.devrun.questionProductCus.model.vo.QuestionProductId;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Cart;
import com.kh.devrun.shop.model.vo.Review;
import com.kh.devrun.shop.model.vo.Wishlist;
import com.kh.devrun.shop.model.vo.WishlistProduct;

public interface ShopService {

	/* 혜진 장바구니 시작 */
	int insertCart(Cart cart);

	int deleteCart(List<Integer> cartNoArr);
	
	List<ProductEntity> selectProductListByChildCategory(Map<String, Object> param, int offset, int limit);
	
	int selectProductTotalCount(Map<String, Object> param);
	/* 혜진 장바구니 끝 */

	int insertReview(Review review);

	List<Review> selectAllReview(Map<String, Object> param);

	int countAllList(String productCode);

	int countPicReviewList(String productCode);

	int reviewDelete(int reviewNo);

	List<Review> picReviewOnly(String productCode);

	List<ProductEx> CategoryItemAll(int offset, int limit, String parentCate);

	Attachment selectOneAttach(int reviewNo);

	List<Product> selectRecommendation(Map<String, Object> param);

	int didIHitLikes(Map<String, Object> param);

	int reviewLikeAdd(Map<String, Object> param);

	int reviewLikeDelete(Map<String, Object> param);

	int refreshCountLikes(int reviewNo);

	int wishlistAdd(Wishlist wishlist, int memberNo);

	int wishlistDelete(Map<String, Object> param);

	List<WishlistProduct> selectAllWishlist(int memberNo);

	int didIHitWishlist(Map<String, Object> param);

	ProductDetail selectOneProductDetail(int detailNo);

	int updateViewCount(String productCode);

	int insertSmsWatinglist(Map<String, Object> param);

	List<ProductEx> selectItemsByChildCate(int offset, int limit, String childCategoryCode);

	int countItemsByParentCode(String parentCate);

	int countItemsByChildCode(String childCategoryCode);

	List<Map<String, String>> selectAllChildCateNames(String parentCate);

	String thisCateName(String childCategoryCode);

	List<ProductEntity> selectItemsByChildCateBySort(int offset, int limit, Map<String, Object> param);

	List<ProductEntity> shopSearch(int offset, int limit, String searchKeyword);

	int countShopSearch(String searchKeyword);

	List<ProductEntity> shopSearchSort(int offset, int limit, Map<String, Object> param);

	List<Review> topFourReview();

	List<ProductEntity> topTenItems();

	// 태영
	List<QuestionProductId> selectQuestionList(String productCode);

}
