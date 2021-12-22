package com.kh.devrun.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;

import com.kh.devrun.product.ProductCategory;

import com.kh.devrun.promotion.model.vo.Promotion;


public interface AdminService {

	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Product product, String childCategoryCode);


	int insertProducCategory(ProductCategory productCategory);

	
	
	
	/**
	 * 혜진 시작
	 * @param searchCode
	 * @return
	 */
	List<Product> selectProductListByProductCode(String searchCode);

	
	int insertPromotion(Map<String, Object> param);

	List<Promotion> selectAllPromotionList();

	Promotion selectPromotionByPromotionCode(String promotionCode);

	int updatePromotion(Map<String, Object> param);
	
	/**
	 * 혜진 끝
	 */

}
