package com.kh.devrun.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.product.model.vo.ProductEx;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ProductDaoImpl implements ProductDao {

	@Autowired
	SqlSession session;

	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return session.selectList("category.selectChildCategory", param);
	}

	// 상품 등록
	@Override
	public int insertProduct(ProductEntity product) {
		return session.insert("product.insertProduct", product);
	}

	// 상품-카테고리 등록
	@Override
	public int insertProducCategory(ProductCategory productCategory) {
		return session.insert("product.insertProductCategory", productCategory);
	}

	// 상품 상세정보 등록
	@Override
	public int insertProductDetail(ProductDetail productDetail) {
		return session.insert("product.insertProductDetail", productDetail);
	}

	@Override
	public List<ProductEntity> selectAllProductList(int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("product.selectAllProductList", null, rowBounds);
	}

	// 전체 상품 수 조회(페이징)
	@Override
	public int selectTotalBoardCount() {
		return session.selectOne("product.selectTotalBoardCount");
	}

	// 상품 삭제
	@Override
	public int deleteProduct(String productCode) {
		return session.delete("product.deleteProduct", productCode);
	}

	// 상품정보 하나 가져오기
	@Override
	public ProductEx selectProductOne(String productCode) {
		return session.selectOne("product.selectProductOne", productCode);
	}

	// 상품 디테일 정보 가져오기
	@Override
	public List<ProductDetail> selectProductDetail(String productCode) {
		return session.selectList("product.selectProductDetail", productCode);
	}

	// 상품 정보 업데이트
	@Override
	public int updateProduct(ProductEntity product) {
		return session.update("product.updateProduct", product);
	}

	// nextval 번호까지 붙은 thumbnail 값 가져오기 (최근 등록된)
	@Override
	public String selectRealProductImg() {
		return session.selectOne("product.selectRealProductImg");
	}

	// 상품 옵션 업데이트
	@Override
	public int updateOption(ProductDetail productDetail, Map<String, Object> param) {
		return session.update("product.updateOption", productDetail);
	}

	// 상품 옵션 삭제
	@Override
	public int deleteOption(int deleteDetailNo) {
		return session.delete("product.deleteOption", deleteDetailNo);
	}

	// 상품 옵션 추가
	@Override
	public int insertOption(ProductDetail productDetail) {
		return session.insert("product.insertOption", productDetail);
	}
	
	// 상품 검색 결과 가져오기
	@Override
	public List<ProductEntity> searchProductList(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("product.searchProductList",param,rowBounds);
	}
	// 상품 검색 결과 갯수 가져오기
	@Override
	public int searchProductListCount(Map<String, Object> param) {

		return session.selectOne("product.searchProductListCount",param);
	}
	
	

	// 다현 - 상세 페이지 뿌리기 위한 item 받아오기
	@Override
	public ProductEx selectOneItem(String productCode) {
		return session.selectOne("product.selectOneItem", productCode);
	}

	// 다현 - 품절만 가져오기
	@Override
	public List<ProductDetail> selectOutOfStock(String productCode) {
		return session.selectList("product.selectOutOfStock", productCode);
	}

	/**
	 * 혜진 상품 + 상품 상세(옵션) 조회
	 * 
	 * @param detailNo
	 * @return
	 */
	@Override
	public List<Product> selectProductByDetailNo(int[] detailNo) {
		return session.selectList("product.selectProductByDetailNo", detailNo);
	}

	@Override
	public List<Integer> selectCartValidList(Map<String, Object> cartParam) {
		return session.selectList("product.selectCartValidList", cartParam);
	}
	
	/* 혜진 끝 */

	/**
	 * 지원 메인페이지 카테고리별 상품 조회
	 */
	@Override
	public List<ProductEntity> selectLatestProductList() {
		return session.selectList("product.selectLatestProductList");
	}

	@Override
	public List<ProductEntity> selectTop12ProductList() {
		return session.selectList("product.selectTop12ProductList");
	}

	@Override
	public List<ProductEntity> selectTenThousandWonProductList() {
		return session.selectList("product.selectTenThousandWonProductList");
	}
	/**
	 * 지원 끝
	 */
	
}
