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
import com.kh.devrun.product.model.vo.ProductExtends;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ProductDaoImpe implements ProductDao{

	@Autowired
	SqlSession session;

	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return session.selectList("category.selectChildCategory",param);
	}

	//상품 등록
	@Override
	public int insertProduct(Product product) {
		return session.insert("product.insertProduct",product);
	}

	// 상품-카테고리 등록
	@Override
	public int insertProducCategory(ProductCategory productCategory) {
		return session.insert("product.insertProductCategory",productCategory);
	}
	
	// 상품 상세정보 등록
	@Override
	public int insertProductDetail(ProductDetail productDetail) {
		return session.insert("product.insertProductDetail",productDetail);
	}
	
	@Override
	public List<Product> selectAllProductList(int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("product.selectAllProductList",null,rowBounds);
	}

	// 전체 상품 수 조회(페이징)
	@Override
	public int selectTotalBoardCount() {
		return session.selectOne("product.selectTotalBoardCount");
	}

	// 옵션 리스트 조회(비동기)
	@Override
	public List<ProductDetail> findProductOption(String productCode) {
		return session.selectList("product.findProductOption", productCode);
	}
	
	// 상품 삭제
	@Override
	public int deleteProduct(String productCode) {
		return session.delete("product.deleteProduct",productCode);
	}

	// 상품정보 하나 가져오기
	@Override
	public ProductExtends selectProductOne(String productCode) {
		return session.selectOne("product.selectProductOne",productCode);
	}

	// 상품 디테일 정보 가져오기
	@Override
	public List<ProductDetail> selectProductDetail(String productCode) {
		return session.selectList("product.selectProductDetail",productCode);
	}
	// 상품 정보 업데이트	
	@Override
	public int updateProduct(Product product) {
		return session.update("product.updateProduct", product);
	}
	
	// nextval 번호까지 붙은 thumbnail 값 가져오기 (최근 등록된)
	@Override
	public String selectRealProductImg() {
		return session.selectOne("product.selectRealProductImg");
	}
	
}



