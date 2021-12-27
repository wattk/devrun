package com.kh.devrun.promotion.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.promotion.model.vo.ProductPromotion;
import com.kh.devrun.promotion.model.vo.Promotion;

public interface PromotionDao {

	List<Product> selectProductListByProductCode(String searchCode);
	
	int insertPromotion(Promotion promotion);
	
	int insertProductPromotion(List<Map<String, Object>> list);
	
	List<Promotion> selectAllPromotionList();
	
	Promotion selectPromotionWithProductByPromotionCode(String promotionCode);
	
	int updatePromotion(Promotion promotion);
	
	int deleteProductPromotion(List<Map<String, Object>> deleteProductList);
	
	int deletePromotion(String[] promotionCode);
	
	List<Product> selectProductListByPromotionCode(Map<String, Object> param);

	List<Promotion> selectCurrentPromotionList();

	List<Promotion> selectEndPromotionList();

	List<Map<String, String>> selectProductPromotionByPromotionCode(String promotionCode);

	List<Product> selectProductPromotionListByChildCategoryCode(Map<String, Object> param);

	List<Map<String, Object>> selectProductNameAndCodeByPromotionCode(String promotionCode);

	int updateViewCount(String promotionCode);

	Promotion selectPromotionByPromotionCode(String promotionCode);

	List<Product> selectProductListByPromotionCode(Map<String, Object> param, int offset, int limit);

	int selectProductTotalCount(Map<String, Object> param);
}
