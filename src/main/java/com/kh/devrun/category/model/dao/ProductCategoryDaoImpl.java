package com.kh.devrun.category.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ProductCategoryDaoImpl implements ProductCategoryDao {

	@Autowired
	SqlSession session;

	@Override
	public List<ProductParentCategory> selectAllParentCategory() {
		return session.selectList("productCategory.selectAllParentCategory");
	}
	
	@Override
	public List<ProductChildCategory> selectAllChildCategory() {
		return session.selectList("productCategory.selectAllChildCategory");
	}

	// 비동기로 소분류 이름 & 코드 가져오기.
	@Override
	public List<ProductChildCategory> searchChildCategory(String code) {
		return session.selectList("productCategory.searchChildCategory",code);
	}


	// 비동기로 대분류 값 가져오기
	@Override
	public List<ProductParentCategory> selectParentCategory() {
		return session.selectList("productCategory.selectParentCategory");
	}
	
	// 대분류 카테고리 등록
	@Override
	public int insertParentCategory(Map<String, String> param) {
		return session.insert("productCategory.insertParentCategory",param);
	}
	// 소분류 카테고리 등록
	@Override
	public int insertChildCategory(Map<String, String> param) {
		return session.insert("productCategory.insertChildCategory",param);
	}

	// 상품 대분류 카테고리 삭제
	@Override
	public int deleteProductCategory(String deleteParentCategoryCode) {
		return session.delete("productCategory.deleteProductCategory",deleteParentCategoryCode);
	}

	// 상품 소분류 카테고리 삭제
	@Override
	public int deleteChildProductCategory(String deleteChildCategoryCode) {
		return session.delete("productCategory.deleteChildProductCategory",deleteChildCategoryCode);
	}
	
	// 해당 코드에 따른 객체 하나 가져오기
	@Override
	public List<ProductParentCategory> selectCategoryCode(String afterUpdateCategoryCode) {
		return session.selectList("productCategory.selectCategoryCode",afterUpdateCategoryCode);
	}

	// 해당 이름에 따른 객체 하나 가져오기
	@Override
	public List<ProductParentCategory> selectCategoryTitle(String afterUpdateCategoryTitle) {
		return session.selectList("productCategory.selectCategoryTitle",afterUpdateCategoryTitle);
	}

	// 상품 대분류카테고리 업데이트
	@Override
	public int updateCategoryToParent(Map<String, String> param) {
		return session.update("productCategory.updateCategoryToParent",param);
	}
	
	// 상품 소분류카테고리 업데이트
	@Override
	public int updateCategoryToChild(Map<String, String> param) {
		return session.update("productCategory.updateCategoryToChild",param);
	}




}
