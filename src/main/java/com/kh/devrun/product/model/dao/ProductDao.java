package com.kh.devrun.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductEx;

public interface ProductDao {
	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(ProductEntity product);

	int insertProducCategory(ProductCategory productCategory);

	int insertProductDetail(ProductDetail productDetail);

	List<ProductEntity> selectAllProductList(int offset, int limit);

	int selectTotalBoardCount();

	// 상품삭제
	int deleteProduct(String productCode);

	// 상품정보 하나 가져오기
	ProductEx selectProductOne(String productCode);

	// 상품 디테일 정보 가져오기
	List<ProductDetail> selectProductDetail(String productCode);

	// 상품 정보 업데이트
	int updateProduct(ProductEntity product);

	// nextval 번호까지 붙은 thumbnail 값 가져오기 (최근 등록된)
	String selectRealProductImg();

	// productOption 업데이트
	int updateOption(ProductDetail productDetail, Map<String, Object> param);

	// productOption 삭제
	int deleteOption(int deleteDetailNo);

	// productOption 추가
	int insertOption(ProductDetail productDetail);
	// 상품 검색 결과 가져오기
	List<ProductEntity> searchProductList(Map<String, Object> param);
	
	
	
	
	
	// 다현 - 상세 페이지 뿌리기 위한 item 받아오기
	ProductEx selectOneItem(String productCode);

	// 다현 - 품절만 가져오기
	List<ProductDetail> selectOutOfStock(String productCode);

	/**
	 * 혜진 상품 + 상품 상세(옵션) 조회
	 * 
	 * @param detailNo
	 * @return
	 */
	List<Product> selectProductByDetailNo(int[] detailNo);

	List<Integer> selectCartValidList(Map<String, Object> cartParam);
	/* 혜진 끝 */



}
