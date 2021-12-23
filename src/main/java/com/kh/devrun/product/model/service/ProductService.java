package com.kh.devrun.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductExtends;

public interface ProductService {
	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Map<String,Object> param);

	int insertProducCategory(ProductCategory productCategory);

	int insertProductDetail(ProductDetail productDetail);

	
	List<ProductExtends> selectAllProductList(int offset, int limit);
	
	int selectTotalBoardCount();
}
