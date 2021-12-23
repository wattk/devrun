package com.kh.devrun.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductExtends;

public interface ProductDao {
	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Product product);

	int insertProducCategory(ProductCategory productCategory);
	
	int insertProductDetail(ProductDetail productDetail);
	
	List<ProductExtends> selectAllProductList(int offset, int limit);
	
	int selectTotalBoardCount();
}
