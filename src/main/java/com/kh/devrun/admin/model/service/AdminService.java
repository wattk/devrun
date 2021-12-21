package com.kh.devrun.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;

public interface AdminService {

	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Product product);
	
}
