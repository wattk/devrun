package com.kh.devrun.category.model.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.category.model.dao.ProductCategoryDao;
import com.kh.devrun.category.model.exception.deleteProductCategoryException;
import com.kh.devrun.category.model.exception.insertCategoryException;
import com.kh.devrun.category.model.exception.updateCategoryException;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductCategoryServiceImpl implements ProductCategoryService {

	@Autowired
	private ProductCategoryDao productCategoryDao;

	@Override
	public List<ProductParentCategory> selectAllParentCategory() {
		return productCategoryDao.selectAllParentCategory();
	}
	
	@Override
	public List<ProductChildCategory> selectAllChildCategory() {
		return productCategoryDao.selectAllChildCategory(); 
	}
	
	// 비동기로 소분류 이름 & 코드 가져오기.
	@Override
	public List<ProductChildCategory> searchChildCategory(String code) {
		return productCategoryDao.searchChildCategory(code);
	}
	
	// 상품 카테고리 등록
	@Override
	public int insertCategory(Map<String, String> param) {
		
		
		int result=0;
		// 소분류 추가는 대분류 코드도 넣어줘야해서 분기처리
		if("childCategory".equals(param.get("selectCategory"))){
			log.debug("소분류 추가요~~~");
			try {
				result = productCategoryDao.insertChildCategory(param);
			} catch (Exception e) {
				log.error(e.getMessage());
				throw new insertCategoryException("소분류 카테고리 등록 오류",e);
			}
		}
		else {		
			try {
				result = productCategoryDao.insertParentCategory(param);
			} catch (Exception e) {
				log.error(e.getMessage());
				throw new insertCategoryException("대분류 카테고리 등록 오류",e);
			}
		}
		

		return result;
	}
	
	// 비동기로 대분류 값 가져오기
	@Override
	public List<ProductParentCategory> selectParentCategory(){ 
		return productCategoryDao.selectParentCategory();
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteProductCategory(Map<String,String>param) {
		int result = 0;		
		String deleteChildCategoryCode =  param.get("deleteChildCategoryCode");
		String deleteParentCategoryCode =  param.get("deleteParentCategoryCode");
		
		try {
			// 대분류 카테고리 삭제
			if(deleteChildCategoryCode == null || deleteChildCategoryCode == "" ) {
				result = productCategoryDao.deleteProductCategory(deleteParentCategoryCode);
			}
			// 소분류 카테고리 삭제
			else {
				result = productCategoryDao.deleteChildProductCategory(deleteChildCategoryCode);				
			}
				
		} catch (Exception e) {			
			log.error(e.getMessage());
			throw new deleteProductCategoryException("상품 카테고리 삭제 오류",e);
		}
		
		return result;
	}
	
	// 해당 코드에 따른 객체 하나 가져오기
	@Override
	public List<ProductParentCategory> selectCategoryCode(String afterUpdateCategoryCode) {
		return productCategoryDao.selectCategoryCode(afterUpdateCategoryCode) ;
	}

	// 해당 이름에 따른 객체 하나 가져오기
	@Override
	public List<ProductParentCategory> selectCategoryTitle(String afterUpdateCategoryTitle) {
		return productCategoryDao.selectCategoryTitle(afterUpdateCategoryTitle) ;
	}

	// 카테고리 업데이트
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateCategory(Map<String, String> param) {
		int result = 0;
		
		try {
			// 업데이트문 join 실패로 각각 한번씩 실행
			result = updateCategoryToParent(param);
			result = updateCategoryToChild(param);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new updateCategoryException("카테고리 업데이트 오류",e);
		}
		
		return result;
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int updateCategoryToParent(Map<String,String>param) {
		return productCategoryDao.updateCategoryToParent(param);
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int updateCategoryToChild(Map<String,String>param) {
		return productCategoryDao.updateCategoryToChild(param);
	}
	


	
	
	
	
	
	
	
	
}
