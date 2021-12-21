package com.kh.devrun.category.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;

public interface CategoryDao {

	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

}
