package com.kh.devrun.promotion.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.promotion.model.vo.Promotion;

@Repository
public class PromotionDaoImpl implements PromotionDao {
	
	@Autowired
	private SqlSession session;
	
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


	@Override
	public List<Promotion> selectAllPromotionList() {
		return session.selectList("promotion.selectAllPromotionList");
	}

	@Override
	public Promotion selectPromotionByPromotionCode(String promotionCode) {
		return session.selectOne("promotion.selectPromotionByPromotionCode", promotionCode);
	}


	@Override
	public int updatePromotion(Promotion promotion) {
		return session.update("promotion.updatePromotion", promotion);
	}

	@Override
	public int deleteProductPromotion(List<Map<String, Object>> deleteProductList) {
		return session.delete("promotion.deleteProductPromotion", deleteProductList);
	}

	@Override
	public int deletePromotion(String[] promotionCode) {
		return session.delete("promotion.deletePromotion", promotionCode);
	}

	@Override
	public List<Product> selectProductListByPromotionCode(Map<String, Object> param) {
		return session.selectList("promotion.selectProductListByPromotionCode", param);
	}

	@Override
	public List<Promotion> selectCurrentPromotionList() {
		return session.selectList("promotion.selectCurrentPromotionList");
	}

	@Override
	public List<Promotion> selectEndPromotionList() {
		return session.selectList("promotion.selectEndpromotionList");
	}

	@Override
	public List<Map<String, String>> selectProductPromotionByPromotionCode(String promotionCode) {
		return session.selectList("promotion.selectProductPromotionByPromotionCode", promotionCode);
	}

	@Override
	public List<Product> selectProductPromotionListByChildCategoryCode(Map<String, Object> param) {
		return session.selectList("promotion.selectProductPromotionListByChildCategoryCode", param);
	}
	
	

}
