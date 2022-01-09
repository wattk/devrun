package com.kh.devrun.product.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.admin.exception.ProductDeleteException;
import com.kh.devrun.admin.exception.ProductInsertException;
import com.kh.devrun.admin.exception.ProductUpdateException;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.dao.ProductDao;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductEx;

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
	public int insertProduct(Map<String, Object> param) {
		int result = 0;

		// param 값 꺼내오기
		ProductEntity product = (ProductEntity) param.get("product");
		String productCode = (String) param.get("productCode");
		String childCategoryCode = (String) param.get("childCategoryCode");
		List<ProductDetail> productDetailList = (List<ProductDetail>) param.get("productDetailList");

		try {
			// 상품 테이블에 추가
			result = productDao.insertProduct(product);
			log.debug("product = {}", product);

			// 상품-분류 테이블에 추가
			productCode = product.getProductCode();
			ProductCategory productCategory = new ProductCategory(childCategoryCode, productCode);
			productCategory.setProductCode(product.getProductCode());
			result = insertProducCategory(productCategory);

			// 상품 디테일 테이블에 추가(1:N)
			if (productDetailList.size() > 0) {
				for (ProductDetail productDetail : productDetailList) {
					productDetail.setProductCode(product.getProductCode());

					result = insertProductDetail(productDetail);
				}
			}

		} catch (Exception e) {
			log.error(e.getMessage());
			throw new ProductInsertException("상품등록 오류가 발생했습니다", e);
		}

		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProducCategory(ProductCategory productCategory) {
		return productDao.insertProducCategory(productCategory);
	}

	@Override
	public List<ProductEntity> selectAllProductList(int offset, int limit) {
		return productDao.selectAllProductList(offset, limit);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertProductDetail(ProductDetail productDetail) {
		return productDao.insertProductDetail(productDetail);
	}

	// 전체 게시물 수 구하기(페이징)
	@Override
	public int selectTotalBoardCount() {
		return productDao.selectTotalBoardCount();
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
			throw new ProductDeleteException("상품 삭제가 실패했습니다", e);
		}
		return result;
	}

	// 상품정보 하나가져오기
	@Override
	public ProductEx selectProductOne(String productCode) {
		return productDao.selectProductOne(productCode);
	}

	// 상품 디테일 정보 가져오기
	@Override
	public List<ProductDetail> selectProductDetail(String productCode) {
		return productDao.selectProductDetail(productCode);
	}

	// 상품 정보 업데이트
	@Transactional(rollbackFor = Exception.class)
	@Override

	public int updateProduct(Map<String, Object> param) {
		int result = 0;
		ProductEntity product = (ProductEntity) param.get("product");
		List<ProductDetail> insertProductDetailList = (List<ProductDetail>) param.get("insertProductDetailList");
		List<ProductDetail> productDetailList = (List<ProductDetail>) param.get("ProductDetailList");

		try {
			result = productDao.updateProduct(product);
			// 상품 디테일 테이블에 추가(1:N)
			if (productDetailList != null && productDetailList.size() > 0) {
				for (ProductDetail productDetail : productDetailList) {
					productDetail.setProductCode(product.getProductCode());

					result = updateOption(productDetail, param);
				}
			}
			// 옵션 삭제 번호가 있을 시 옵션 삭제
			int[] deleteDetailNo = (int[]) param.get("deleteDetailNo");
			if (deleteDetailNo != null) {
				for (int i = 0; i < deleteDetailNo.length; i++) {
					result = productDao.deleteOption(deleteDetailNo[i]);
				}
			}
			// 옵션 추가 번호가 있을 시 옵션 추가
			if (insertProductDetailList.size() > 0) {
				for (ProductDetail productDetail : insertProductDetailList) {
					result = productDao.insertOption(productDetail);
				}
			}

		} catch (Exception e) {
			log.error(e.getMessage());
			throw new ProductUpdateException("상품 수정 오류", e);
		}

		return result;
	}

	// nextval 번호까지 붙은 thumbnail 값 가져오기 (최근 등록된)
	@Override
	public String selectRealProductImg() {
		return productDao.selectRealProductImg();
	}

	// 상품 detail 업데이트
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateOption(ProductDetail productDetail, Map<String, Object> param) {
		return productDao.updateOption(productDetail, param);
	}
	
	// 상품 검색 결과 가져오기
	@Override
	public List<ProductEntity> searchProductList(Map<String, Object> param) {
		return productDao.searchProductList(param);
	}
	// 상품 검색 결과 갯수 가져오기
	@Override
	public int searchProductListCount(Map<String, Object> param) {
		return productDao.searchProductListCount(param);
	}
	
	

	// 다현 - 상세 페이지 뿌리기 위한 item 받아오기
	@Override
	public ProductEx selectOneItem(String productCode) {
		return productDao.selectOneItem(productCode);
	}

	// 다현 - 품절만 가져오기
	@Override
	public List<ProductDetail> selectOutOfStock(String productCode) {
		return productDao.selectOutOfStock(productCode);
	}

	/**
	 * 혜진 상품 + 상품 상세(옵션) 조회
	 * 
	 * @param detailNo
	 * @return
	 */

	@Override
	public List<Product> selectProductByDetailNo(int[] detailNo) {
		return productDao.selectProductByDetailNo(detailNo);
	}

	@Override
	public List<Integer> selectCartValidList(Map<String, Object> cartParam) {
		return productDao.selectCartValidList(cartParam);
	}

	@Override
	public Map<String, Object> selectProductDetailList(List<String> productArr) {
		Map<String,Object> productDetailList = new HashMap<>();
		for(int i = 0; i < productArr.size(); i++) {
			String productCode = productArr.get(i);
			List<ProductDetail> list = productDao.selectProductDetail(productCode);
			productDetailList.put(productCode, list);
		}
		
		return productDetailList;
	}



	

	/* 혜진 끝 */

}
