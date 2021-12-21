package com.kh.devrun.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;
import com.kh.devrun.product.ProductCategory;

public interface AdminDao {

	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Product product);

	int insertProducCategory(ProductCategory productCategory);

}
