package com.kh.devrun.promotion.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.product.Product;
import com.kh.devrun.product.ProductExtends;
import com.kh.devrun.promotion.model.vo.Promotion;

public interface PromotionService {

	List<Product> selectProductListByProductCode(String searchCode);

	
	int insertPromotion(Map<String, Object> param);


	List<Promotion> selectAllPromotionList();

	Promotion selectPromotionByPromotionCode(String promotionCode);

	int updatePromotion(Map<String, Object> param);

	int deletePromotion(String[] promotionCode);

	List<Product> selectProductListByPromotionCode(String promotionCode);


	List<Promotion> selectCurrentPromotionList();


	List<Promotion> selectEndPromotionList();

}
