package com.kh.devrun.category.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;

public interface CategoryService {

	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

}
