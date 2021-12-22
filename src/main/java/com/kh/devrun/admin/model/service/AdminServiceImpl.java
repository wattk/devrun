package com.kh.devrun.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.admin.model.dao.AdminDao;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;
import com.kh.devrun.product.ProductCategory;
import com.kh.devrun.promotion.model.exception.PromotionException;
import com.kh.devrun.promotion.model.vo.Promotion;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;
	
	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return adminDao.selectChildCategory(param);
	}

	// 상품 등록, 상품-분류 추가
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProduct(Product product, String childCategoryCode) {
		int result = 0;
		String productCode="";
		
		try {
			// 상품 테이블에 추가
			result = adminDao.insertProduct(product);
			log.debug("product = {}", product);
			
			// 상품-분류 테이블에 추가
			productCode = product.getProductCode();
			ProductCategory productCategory = new ProductCategory(childCategoryCode,productCode);
			
			productCategory.setProductCode(product.getProductCode());
			log.debug("productCategory = {}", productCategory);
			
			result = insertProducCategory(productCategory);
			
		}catch(Exception e) {
			throw e;
		}
				
		return result;
	}

	
	

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProducCategory(ProductCategory productCategory) {
		return adminDao.insertProducCategory(productCategory);
	}
	
	

	/**
	 * 혜진 시작
	 */
	@Override
	public List<Product> selectProductListByProductCode(String searchCode) {
		return adminDao.selectProductListByProductCode(searchCode);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class)
	public int insertPromotion(Map<String, Object> param) {
		int result = 0;
		try {
			Promotion promotion = (Promotion)param.get("promotion");
			//promotion 테이블 insert
			result = adminDao.insertPromotion(promotion);
			
			List<Map<String, Object>> list = (List<Map<String, Object>>)param.get("list");
			log.debug("list = {}", list);
			//promotion-product 테이블 insert
			result = adminDao.insertProductPromotion(list);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new PromotionException("프로모션 상품 등록 오류", e);
		}
		return result;
	}

	@Override
	public List<Promotion> selectAllPromotionList() {
		return adminDao.selectAllPromotionList();
	}

	@Override
	public Promotion selectPromotionByPromotionCode(String promotionCode) {
		return adminDao.selectPromotionByPromotionCode(promotionCode);
	}

	

	
	/**
	 * 혜진 끝
	 */
	
	
}
