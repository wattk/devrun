package com.kh.devrun.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEx;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Cart;
import com.kh.devrun.shop.model.vo.Review;
import com.kh.devrun.shop.model.vo.Wishlist;
import com.kh.devrun.shop.model.vo.WishlistProduct;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ShopDaoImpl implements ShopDao {

	@Autowired
	private SqlSession session;

	/* 혜진 장바구니 시작 */
	@Override
	public int insertCart(Cart cart) {
		return session.insert("shop.insertCart", cart);
	}

	@Override
	public int insertMemberCart(Cart cart) {
		return session.insert("shop.insertMemberCart", cart);
	}

	@Override
	public int deleteCart(List<Integer> cartNoArr) {
		return session.delete("shop.deleteCart", cartNoArr);
	}

	/* 혜진 장바구니 끝 */

	@Override
	public int findWishlistNo(Map<String, Object> param) {
		return session.selectOne("shop.findWishlistNo", param);
	}

	@Override
	public int wishlistDelete(int wishlistNo) {
		return session.delete("shop.wishlistDelete", wishlistNo);
	}

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
	public List<ProductEx> CategoryItemAll(int offset, int limit, String parentCate) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("shop.CategoryItemAll", parentCate, rowBounds);
	}

	@Override
	public List<ProductEx> selectItemsByChildCate(int offset, int limit, String childCategoryCode) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("shop.selectItemsByChildCate", childCategoryCode, rowBounds);
	}

	@Override
	public Attachment selectOneAttach(int reviewNo) {
		return session.selectOne("shop.selectOneAttach", reviewNo);
	}

	@Override
	public List<Product> selectRecommendation(Map<String, Object> param) {
		return session.selectList("shop.selectRecommendation", param);
	}

	@Override
	public int didIHitLikes(Map<String, Object> param) {
		return session.selectOne("shop.didIHitLikes", param);
	}

	@Override
	public int reviewLikeAdd(Map<String, Object> param) {
		return session.update("shop.reviewLikeAdd", param);
	}

	@Override
	public int insertMemberReviewLike(Map<String, Object> param) {
		return session.insert("shop.insertMemberReviewLike", param);
	}

	@Override
	public int deleteMemberReviewLike(Map<String, Object> param) {
		return session.delete("shop.deleteMemberReviewLike", param);
	}

	@Override
	public int reviewLikeDelete(Map<String, Object> param) {
		return session.update("shop.reviewLikeDelete", param);
	}

	@Override
	public int refreshCountLikes(int reviewNo) {
		return session.selectOne("shop.refreshCountLike", reviewNo);
	}

	@Override
	public int insertWishlist(Wishlist wishlist) {
		return session.insert("shop.wishlistAdd", wishlist);
	}

	@Override
	public int insertMemberWishlist(Map<String, Object> param) {
		return session.insert("shop.insertMemberWishlist", param);
	}

	@Override
	public int didIHitWishlist(Map<String, Object> param) {
		return session.selectOne("shop.didIHitWishlist", param);
	}

	@Override
	public List<WishlistProduct> selectAllWishlist(int memberNo) {
		return session.selectList("shop.selectAllWishlist", memberNo);
	}

	@Override
	public ProductDetail selectOneProductDetail(int detailNo) {
		return session.selectOne("shop.selectOneProductDetail", detailNo);
	}

	@Override
	public int updateViewCount(String productCode) {
		return session.update("shop.updateViewCount", productCode);
	}

	@Override
	public int insertSmsWatinglist(Map<String, Object> param) {
		return session.insert("shop.insertSmsWatinglist", param);
	}

	@Override
	public int countItemsByParentCode(String parentCate) {
		return session.selectOne("shop.countItemsByParentCode", parentCate);
	}

	@Override
	public int countItemsByChildCode(String childCategoryCode) {
		return session.selectOne("shop.countItemsByChildCode", childCategoryCode);
	}

	@Override
	public List<String> selectAllChildCateNames(String parentCate) {
		return session.selectList("shop.selectAllChildCateNames", parentCate);
	}

	@Override
	public String thisCateName(String childCategoryCode) {
		return session.selectOne("shop.thisCateName", childCategoryCode);
	}

}
