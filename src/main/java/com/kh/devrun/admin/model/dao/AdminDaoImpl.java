package com.kh.devrun.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;
import com.kh.devrun.product.ProductCategory;
import com.kh.devrun.product.ProductDetail;
import com.kh.devrun.product.ProductExtends;
import com.kh.devrun.promotion.model.vo.Promotion;

@Repository
public class AdminDaoImpl implements AdminDao {

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
	
	// Product 목록 가져오기
	@Override
	public List<ProductExtends> selectAllProductList(int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("product.selectAllProductList",null,rowBounds);
	}

	// 전체 상품 수 조회(페이징)
	@Override
	public int selectTotalBoardCount() {
		return session.selectOne("product.selectTotalBoardCount");
	}
	
	
	/**
	 * 태영 끝 ----------------------------------------------
	 */
	



}
