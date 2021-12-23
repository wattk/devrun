package com.kh.devrun.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.admin.exception.ProductInsertException;
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
	public int insertProduct(Map<String,Object> param) {
		int result = 0;
	
		// param 값 꺼내오기
		Product product = (Product)param.get("product");
		String productCode=(String)param.get("productCode");
		String childCategoryCode = (String)param.get("childCategoryCode");
		List<ProductDetail> productDetailList = (List<ProductDetail>)param.get("productDetailList");
		
		try {
			// 상품 테이블에 추가
			result = adminDao.insertProduct(product);
			log.debug("product = {}", product);
			
			// 상품-분류 테이블에 추가
			productCode = product.getProductCode();
			ProductCategory productCategory = new ProductCategory(childCategoryCode,productCode);
			productCategory.setProductCode(product.getProductCode());
			result = insertProducCategory(productCategory);
			
			// 상품 디테일 테이블에 추가(1:N)
			if(product.getProductDetailList().size() > 0) {
				for(ProductDetail productDetail : product.getProductDetailList()) {
					productDetail.setProductCode(product.getProductCode());
					
					result = insertProductDetail(productDetail);
				}
			}

		}catch(Exception e) {
			log.error(e.getMessage());
			throw new ProductInsertException("상품등록 오류가 발생했습니다",e);
		}
				
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProducCategory(ProductCategory productCategory) {
		return adminDao.insertProducCategory(productCategory);
	}
	
	@Override
	public List<ProductExtends> selectAllProductList(int offset, int limit) {
		return adminDao.selectAllProductList(offset, limit);
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProductDetail(ProductDetail productDetail) {
		return adminDao.insertProductDetail(productDetail) ;
	}
	
	// 전체 게시물 수 구하기(페이징)
	@Override
	public int selectTotalBoardCount() {
		return adminDao.selectTotalBoardCount();
	}
	
	/**
	 * 태영 끝 --------------------------------------------	
	 */	

	


	
	
}
