package com.kh.devrun.promotion.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.promotion.model.vo.Promotion;

public interface PromotionDao {

	List<Product> selectProductListByProductCode(String searchCode);
	
	int insertPromotion(Promotion promotion);
	
	int insertProductPromotion(List<Map<String, Object>> list);
	
	List<Promotion> selectAllPromotionList();
	
	Promotion selectPromotionByPromotionCode(String promotionCode);
	
	int updatePromotion(Promotion promotion);
	
	int deleteProductPromotion(List<Map<String, Object>> deleteProductList);
	
	int deletePromotion(String[] promotionCode);
	
	List<Product> selectProductListByPromotionCode(String promotionCode);

	List<Promotion> selectCurrentPromotionList();

	List<Promotion> selectEndPromotionList();
}
