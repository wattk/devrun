package com.kh.devrun.category.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

public interface ProductCategoryService {

	List<ProductParentCategory> selectAllParentCategory();
	
	List<ProductChildCategory> selectAllChildCategory();
	
	// 비동기로 소분류 이름 & 코드 가져오기.
	List<ProductChildCategory> searchChildCategory(String code);
	
	// 상품 카테고리 등록
	int insertCategory(Map<String, String> param);
	
	// 비동기로 대분류 값 가져오기
	List<ProductParentCategory> selectParentCategory();

	int deleteProductCategory(Map<String, String> param);
	
	// 해당 대분류 코드에 따른 객체 하나 가져오기
	ProductParentCategory selectOneParentCategoryCode(String updateCategoryCode);
	
	// 해당 소분류 코드에 따른 객체 하나 가져오기
	ProductChildCategory selectOneChildCategoryCode(String updateCategoryCode);

	
	
}
