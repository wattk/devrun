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
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.shop.model.dao.ShopDao;
import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Cart;
import com.kh.devrun.shop.model.vo.Review;
import com.kh.devrun.shop.model.vo.Wishlist;
import com.kh.devrun.shop.model.vo.WishlistProduct;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDao shopDao;

//--------------------------------------------------------구분선---------------------------------------------------------

	/* 혜진 장바구니 시작 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int insertCart(Cart cart) {
		int result = 0;

		try {
			result = shopDao.insertCart(cart);
			result = shopDao.insertMemberCart(cart);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return result;
	}

	@Override
	public int deleteCart(List<Integer> cartNoArr) {
		int result = shopDao.deleteCart(cartNoArr);

		return result;

	}

	/* 혜진 장바구니 끝 */

//--------------------------------------------------------구분선---------------------------------------------------------

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int insertReview(Review review) {
		int result = 0;

		try {
			// 1. review insert
			result = shopDao.insertReview(review);

			Attachment attach = review.getAttach();

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
	public List<Review> selectAllReview(Map<String, Object> param) {
		return shopDao.selectAllReview(param);
	}

	@Override
	public int countAllList(String productCode) {
		return shopDao.countAllList(productCode);
	}

	@Override
	public int countPicReviewList(String productCode) {
		return shopDao.countPicReviewList(productCode);
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
	public List<ProductEntity> CategoryItemAll(String parentCate) {
		return shopDao.CategoryItemAll(parentCate);
	}

	@Override
	public Attachment selectOneAttach(int reviewNo) {
		return shopDao.selectOneAttach(reviewNo);
	}

	@Override
	public List<Product> selectRecommendation(Map<String, Object> param) {
		return shopDao.selectRecommendation(param);
	}

	@Override
	public int didIHitLikes(Map<String, Object> param) {
		return shopDao.didIHitLikes(param);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int reviewLikeAdd(Map<String, Object> param) {
		int result = 0;
		int result2 = 0;
		try {
			result = shopDao.insertMemberReviewLike(param);
			result2 = shopDao.reviewLikeAdd(param);
			// thorw e 처리 어케?

		} catch (Exception e) {
			log.error(e.getMessage(), e); // 로깅해주고
			throw e;

		}
		return result2;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int reviewLikeDelete(Map<String, Object> param) {
		int result = 0;
		int result2 = 0;
		try {
			result = shopDao.deleteMemberReviewLike(param);
			result2 = shopDao.reviewLikeDelete(param);
			// thorw e 처리 어케?

		} catch (Exception e) {
			log.error(e.getMessage(), e); // 로깅해주고
			throw e;

		}
		return result2;
	}

	// 좋아요 변화 이후 새로 카운팅
	@Override
	public int refreshCountLikes(int reviewNo) {
		return shopDao.refreshCountLikes(reviewNo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int wishlistAdd(Wishlist wishlist, int memberNo) {
		int result = 0;
		int result2 = 0;
		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", memberNo);

		try {

			result = shopDao.insertWishlist(wishlist);
			int wishlistNo = wishlist.getWishlistNo();
			param.put("wishlistNo", wishlistNo);

			if (result == 1) {
				result2 = shopDao.insertMemberWishlist(param);

			}
		} catch (Exception e) {
			log.debug(e.getMessage());
			throw e;
		}

		return result2;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
	public int wishlistDelete(Map<String, Object> param) {
		int result = 0;

		try {
			// wishlistNo조회
			int wishlistNo = shopDao.findWishlistNo(param);
			log.debug("삭제를 위한 wishlistNo : {}", wishlistNo);
			result = shopDao.wishlistDelete(wishlistNo);

		} catch (Exception e) {
			log.debug(e.getMessage());
			throw e;
		}

		return result;
	}

	@Override
	public int didIHitWishlist(Map<String, Object> param) {
		return shopDao.didIHitWishlist(param);
	}

	@Override
	public List<WishlistProduct> selectAllWishlist(int memberNo) {
		return shopDao.selectAllWishlist(memberNo);
	}

	@Override
	public ProductDetail selectOneProductDetail(int detailNo) {
		return shopDao.selectOneProductDetail(detailNo);
	}

	@Override
	public int updateViewCount(String productCode) {
		return shopDao.updateViewCount(productCode);
	}

}
