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
import com.kh.devrun.product.ProductDetail;
import com.kh.devrun.product.ProductExtends;
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
	public int insertProduct(Product product, String childCategoryCode, ProductDetail productDetail) {
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
			result = insertProducCategory(productCategory);
			
			// 상품 디테일 테이블에 추가
			productDetail.setProductCode(product.getProductCode());
			result = insertProductDetail(productDetail);
			
			
			
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
	

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProductDetail(ProductDetail productDetail) {
		return adminDao.insertProductDetail(productDetail);
	}
	
	@Override
	public List<ProductExtends> selectAllProductList() {
		return adminDao.selectAllProductList();
	}
	
	
	
	
	/**
	 * 태영 끝 --------------------------------------------	
	 */	

	
	

	
	
}
