package com.kh.devrun.promotion.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.promotion.model.dao.PromotionDao;
import com.kh.devrun.promotion.model.exception.PromotionException;
import com.kh.devrun.promotion.model.vo.ProductPromotion;
import com.kh.devrun.promotion.model.vo.Promotion;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PromotionServiceImpl implements PromotionService {
	
	@Autowired
	private PromotionDao promotionDao;

	@Override
	public List<Product> selectProductListByProductCode(String searchCode) {
		return promotionDao.selectProductListByProductCode(searchCode);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class)
	public int insertPromotion(Map<String, Object> param) {
		int result = 0;
		try {
			Promotion promotion = (Promotion)param.get("promotion");
			//promotion 테이블 insert
			result = promotionDao.insertPromotion(promotion);
			
			List<Map<String, Object>> list = (List<Map<String, Object>>)param.get("list");
			log.debug("list = {}", list);
			//promotion-product 테이블 insert
			result = promotionDao.insertProductPromotion(list);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new PromotionException("프로모션 상품 등록 오류", e);
		}
		return result;
	}

	@Override
	public List<Promotion> selectAllPromotionList() {
		return promotionDao.selectAllPromotionList();
	}

	@Override
	public Promotion selectPromotionWithProductByPromotionCode(String promotionCode) {
		return promotionDao.selectPromotionWithProductByPromotionCode(promotionCode);
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED, 
	isolation = Isolation.READ_COMMITTED, 
	rollbackFor = Exception.class)
	public int updatePromotion(Map<String, Object> param) {
		int result = 0;
		try {
			Promotion promotion = (Promotion)param.get("promotion");
			//promotion 테이블 insert
			result = promotionDao.updatePromotion(promotion);
			
			List<Map<String, Object>> deleteProductList = (List<Map<String, Object>>)param.get("deleteProductList");
			if(!deleteProductList.isEmpty()) result = promotionDao.deleteProductPromotion(deleteProductList);
			
			List<Map<String, Object>> changeProductList = (List<Map<String, Object>>)param.get("changeProductList");
			//promotion-product 테이블 insert
			if(!changeProductList.isEmpty()) result = promotionDao.insertProductPromotion(changeProductList);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new PromotionException("프로모션 상품 등록 오류", e);
		}
		return result;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, 
	isolation = Isolation.READ_COMMITTED, 
	rollbackFor = Exception.class)
	public int deletePromotion(String[] promotionCode) {
		return promotionDao.deletePromotion(promotionCode);
	}

	@Override
	public List<Product> selectProductListByPromotionCode(Map<String, Object> param) {
		return promotionDao.selectProductListByPromotionCode(param);
	}

	@Override
	public Map<String, List<Promotion>> selectDevidedPromotionList() {
		List<Promotion> currentPromotionList = promotionDao.selectCurrentPromotionList();
		List<Promotion> endPromotionList = promotionDao.selectEndPromotionList();
		
		Map<String, List<Promotion>> map = new HashMap<>();
		
		map.put("currentPromotionList", currentPromotionList);
		map.put("endPromotionList", endPromotionList);
		
		return map;
	}

	@Override
	public List<Map<String, String>> selectProductPromotionByPromotionCode(String promotionCode) {
		return promotionDao.selectProductPromotionByPromotionCode(promotionCode);
	}

	@Override
	public List<Product> selectProductPromotionListByChildCategoryCode(Map<String, Object> param) {
		return promotionDao.selectProductPromotionListByChildCategoryCode(param);
	}

	@Override
	public List<Map<String, Object>> selectProductNameAndCodeByPromotionCode(String promotionCode) {
		return promotionDao.selectProductNameAndCodeByPromotionCode(promotionCode);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, 
	isolation = Isolation.READ_COMMITTED, 
	rollbackFor = Exception.class)
	public int updateViewCount(String promotionCode) {
		return promotionDao.updateViewCount(promotionCode);
	}

	@Override
	public Promotion selectPromotionByPromotionCode(String promotionCode) {
		return promotionDao.selectPromotionByPromotionCode(promotionCode);
	}

	@Override
	public List<Product> selectProductListByPromotionCode(Map<String, Object> param, int offset, int limit) {
		return promotionDao.selectProductListByPromotionCode(param, offset, limit);
	}

	@Override
	public int selectProductTotalCount(Map<String, Object> param) {
		return promotionDao.selectProductTotalCount(param);
	}

	
	
}
