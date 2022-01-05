package com.kh.devrun.category.model.dao;

import java.util.List;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

public interface ProductCategoryDao {

	List<ProductParentCategory> selectAllParentCategory();

	List<ProductChildCategory> searchChildCategory(String code);

}
