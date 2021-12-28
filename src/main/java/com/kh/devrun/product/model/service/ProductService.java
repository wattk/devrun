package com.kh.devrun.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductExtends;

public interface ProductService {
	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Map<String,Object> param);

	int insertProducCategory(ProductCategory productCategory);

	int insertProductDetail(ProductDetail productDetail);

	// 상품 리스트 조회
	List<Product> selectAllProductList(int offset, int limit);
	
	int selectTotalBoardCount();

	// 비동기로 옵션값 가져오기
	List<ProductDetail> findProductOption(String productCode);

	// 상품삭제
	int deleteProduct(String productCode);
	
	// 상품 정보 하나 가져오기
	ProductExtends selectProductOne(String productCode);

	// 상품 디테일 정보 가져오기
	List<ProductDetail> selectProductDetail(String productCode);

	// 상품 정보 업데이트
	int updateProduct(Map<String, Object> param);

	// nextval 번호까지 붙은 thumbnail 값 가져오기 (최근 등록된)
	String selectRealProductImg();

	// 상품 옵션 업데이트
	int updateOption(ProductDetail productDetail, Map<String, Object> param);

	//다현 - 상세 페이지 뿌리기 위한 item 받아오기
	Product selectOneItem(String productCode);




	
	
}
