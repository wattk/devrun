package com.kh.devrun.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;
import com.kh.devrun.product.ProductCategory;
import com.kh.devrun.promotion.model.vo.Promotion;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	SqlSession session;

	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return session.selectList("category.selectChildCategory",param);
	}

	@Override
	public int insertProduct(Product product) {
		return session.insert("product.insertProduct",product);
	}

	@Override
	public int insertProducCategory(ProductCategory productCategory) {
		return session.insert("product.insertProductCategory",productCategory);
	}

	/**
	 * 혜진 시작
	 */
	@Override
	public List<Product> selectProductListByProductCode(String searchCode) {
		return session.selectList("product.selectProductListByProductCode", searchCode);
	}

	@Override
	public int insertPromotion(Promotion promotion) {
		return session.insert("promotion.insertPromotion", promotion);
	}

	@Override
	public int insertProductPromotion(List<Map<String, Object>> list) {
		return session.insert("promotion.insertProductPromotion", list);
	}
	
	
	/**
	 * 혜진 끝
	 */
	
}
