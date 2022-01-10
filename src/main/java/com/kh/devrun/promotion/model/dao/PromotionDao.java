package com.kh.devrun.promotion.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.promotion.model.vo.ProductPromotion;
import com.kh.devrun.promotion.model.vo.Promotion;

public interface PromotionDao {

	List<ProductEntity> selectProductListByProductCode(String searchCode);
	
	int insertPromotion(Promotion promotion);
	
	int insertProductPromotion(List<Map<String, Object>> list);
	
	List<Promotion> selectAllPromotionList();
	
	Promotion selectPromotionWithProductByPromotionCode(String promotionCode);
	
	int updatePromotion(Promotion promotion);
	
	int deleteProductPromotion(List<Map<String, Object>> deleteProductList);
	
	int deletePromotion(String[] promotionCode);
	
	List<ProductEntity> selectProductListByPromotionCode(Map<String, Object> param);

	List<Promotion> selectCurrentPromotionList();

	List<Promotion> selectEndPromotionList();

	List<Map<String, String>> selectProductPromotionByPromotionCode(String promotionCode);

	List<ProductEntity> selectProductPromotionListByChildCategoryCode(Map<String, Object> param);

	List<Map<String, Object>> selectProductNameAndCodeByPromotionCode(String promotionCode);

	int updateViewCount(String promotionCode);

	Promotion selectPromotionByPromotionCode(String promotionCode);

	List<ProductEntity> selectProductListByPromotionCode(Map<String, Object> param, int offset, int limit);

	int selectProductTotalCount(Map<String, Object> param);

	/**
	 * 지원 dao 시작
	 */
	Promotion selectOneLatestPromotionBanner();
	
	List<Promotion> selectThreeCurrentPromotion();

	List<ProductEntity> selectPromotionProductList1(String promotionCode1);

	List<ProductEntity> selectPromotionProductList2(String promotionCode2);

	List<ProductEntity> selectPromotionProductList3(String promotionCode3);
	/**
	 * 지원 dao 끝
	 */
}
