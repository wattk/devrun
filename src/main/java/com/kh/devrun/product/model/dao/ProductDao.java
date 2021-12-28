package com.kh.devrun.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductExtends;

public interface ProductDao {
	List<ProductChildCategory> selectChildCategory(Map<String, Object> param);

	int insertProduct(Product product);

	int insertProducCategory(ProductCategory productCategory);
	
	int insertProductDetail(ProductDetail productDetail);
	
	List<Product>selectAllProductList(int offset, int limit);
	
	int selectTotalBoardCount();

	List<ProductDetail> findProductOption(String productCode);
	
	// 상품삭제
	int deleteProduct(String productCode);

	// 상품정보 하나 가져오기
	ProductExtends selectProductOne(String productCode);

	// 상품 디테일 정보 가져오기
	List<ProductDetail> selectProductDetail(String productCode); 

	// 상품 정보 업데이트
	int updateProduct(Product product);
	
	// nextval 번호까지 붙은 thumbnail 값 가져오기 (최근 등록된)
	String selectRealProductImg();

	// productOption 업데이트
	int updateOption(ProductDetail productDetail, Map<String, Object> param);

	// productOption 삭제
	int deleteOption(int deleteDetailNo);

	// productOption 추가
	int insertOption(ProductDetail productDetail);
	
	//다현 - 상세 페이지 뿌리기 위한 item 받아오기
	Product selectOneItem(String productCode);
	
	
	
}
