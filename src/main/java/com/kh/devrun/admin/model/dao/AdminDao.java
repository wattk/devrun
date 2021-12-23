package com.kh.devrun.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;
import com.kh.devrun.product.ProductCategory;
import com.kh.devrun.product.ProductDetail;
import com.kh.devrun.product.ProductExtends;
import com.kh.devrun.promotion.model.vo.Promotion;

public interface AdminDao {

	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Product product);

	int insertProducCategory(ProductCategory productCategory);
	
	int insertProductDetail(ProductDetail productDetail);
	
	List<ProductExtends> selectAllProductList(int offset, int limit);
	
	int selectTotalBoardCount();
	
	/**
	 * 태영 끝-----------------------------------
	 */
	
	





	







}
