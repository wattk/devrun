package com.kh.devrun.category.model.service;

import java.util.List;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

public interface ProductCategoryService {

	List<ProductParentCategory> selectAllParentCategory();

	List<ProductChildCategory> searchChildCategory(String code);
	
}
