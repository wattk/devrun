package com.kh.devrun.product.model.service;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.admin.exception.ProductDeleteException;
import com.kh.devrun.admin.exception.ProductInsertException;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.dao.ProductDao;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductExtends;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDao productDao;
	
	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return productDao.selectChildCategory(param);
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
			result = productDao.insertProduct(product);
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
		return productDao.insertProducCategory(productCategory);
	}
	
	@Override
	public List<Product> selectAllProductList(int offset, int limit) {
		return productDao.selectAllProductList(offset, limit);
	}

	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProductDetail(ProductDetail productDetail) {
		return productDao.insertProductDetail(productDetail) ;
	}
	
	// 전체 게시물 수 구하기(페이징)
	@Override
	public int selectTotalBoardCount() {
		return productDao.selectTotalBoardCount();
	}

	@Override
	public List<ProductDetail> findProductOption(String productCode) {
		return productDao.findProductOption(productCode);
	}

	// 상품삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteProduct(String productCode) {
		int result = 0;
		try {
			result = productDao.deleteProduct(productCode);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new ProductDeleteException("상품 삭제가 실패했습니다",e);
		}	
		return result;
	}

	
	// 상품정보 하나가져오기
	@Override
	public ProductExtends selectProductOne(String productCode) {
		return productDao.selectProductOne(productCode);
	}
	
}




