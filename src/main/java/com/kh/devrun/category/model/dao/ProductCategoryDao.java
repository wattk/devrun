package com.kh.devrun.category.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

public interface ProductCategoryDao {

	List<ProductParentCategory> selectAllParentCategory();

	List<ProductChildCategory> selectAllChildCategory();
	
	// 비동기로 소분류 이름 & 코드 가져오기.
	List<ProductChildCategory> searchChildCategory(String code);
	
	// 비동기로 대분류 값 가져오기
	List<ProductParentCategory> selectParentCategory();
	
	// 대분류 카테고리 등록
	int insertParentCategory(Map<String, String> param);

	// 소분류 카테고리 등록
	int insertChildCategory(Map<String, String> param);

	// 상품 대분류 카테고리 삭제
	int deleteProductCategory(String deleteParentCategoryCode);

	// 상품 소분류 카테고리 삭제
	int deleteChildProductCategory(String deleteChildCategoryCode);
	
	// 해당 코드에 따른 객체 하나 가져오기
	List<ProductParentCategory> selectCategoryCode(String afterUpdateCategoryCode);

	// 해당 분류 이름에 따른 객체 하나 가져오기
	List<ProductParentCategory> selectCategoryTitle(String afterUpdateCategoryTitle);
	
	// 상품 대분류 카테고리 업데이트
	int updateCategoryToParent(Map<String, String> param);

	// 상품 소분류 카테고리 업데이트
	int updateCategoryToChild(Map<String, String> param);

	
	
}




