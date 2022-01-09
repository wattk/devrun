package com.kh.devrun.chart.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.chart.model.dao.ChartDao;
import com.kh.devrun.community.model.dao.CommunityDao;
import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.product.model.dao.ProductDao;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.promotion.model.dao.PromotionDao;
import com.kh.devrun.promotion.model.vo.Promotion;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ChartServiceImpl implements ChartService {
	
	@Autowired
	private ChartDao chartDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private CommunityDao communityDao;
	@Autowired
	private PromotionDao promotionDao;


	@Override
	public Map<String, Integer> findMainCnt() {
		Map<String, Integer> cntList = new HashMap<>();
		
		//금일 매출
		int dailySales = chartDao.countDailySales();
		
		//금월 매출
		int monthlySales = chartDao.countMonthlySales();
		
		//누적 회원수
		int totalMembers = chartDao.countMembers();
		
		//신규 회원수
		int newMembers = chartDao.countTodayMembers();
		
		//차단 회원수
		int blacklistMembers = chartDao.countBlacklist();
		
		//접수 대기중 문의
		int questionProducts = chartDao.countQuestionProduct();
		
		//금년 게시글 수
		int communities = chartDao.countCommunities();
		
		cntList.put("dailySales", dailySales);
		cntList.put("monthlySales", monthlySales);
		cntList.put("totalMembers", totalMembers);
		cntList.put("newMembers", newMembers);
		cntList.put("blacklistMembers", blacklistMembers);
		cntList.put("questionProducts", questionProducts);
		cntList.put("communities", communities);
		
		
		return cntList;
	}
	
	@Override
	public Map<String, Object> findMainChart() {
		Map<String, Object> map = new HashMap<>();
		
		//일별, 월별 판매량
		List<Map<String, Object>> dailySales = chartDao.countSalesPerDay();
		List<Map<String, Object>> salesProduct = chartDao.countSalesProduct();
		log.debug("dailySales = {}", dailySales);
		
		//주문 통계
		int orderCnt = chartDao.countOrderCnt();
		Map<String, Integer> orderLogCnts = chartDao.countOrderLogCnt();
		orderLogCnts.put("COM", orderCnt);
		log.debug("orderLogCnts = {}", orderLogCnts);
		
		//게시판 게시글 수 통계
		List<Map<String, Object>> communityCnts = chartDao.countCommunityPerMonth();
		log.debug("communityCnts = {}", communityCnts);
		
		map.put("dailySales", dailySales);
		map.put("salesProduct", salesProduct);
		map.put("orderLogCnts", orderLogCnts);
		map.put("communityCnts", communityCnts);
		
		return map;
	}

	@Override
	public Map<String, Object> findHomeMain() {
		
		Map<String, Object> map = new HashMap<>();
		
		List<Map<String, Object>> likeCommunityList = chartDao.selectBestCommunity();
		List<CommunityEntity> freeboardList = chartDao.selectFreeboardList();
		List<Map<String, Object>> qnaList = chartDao.selectQnaList();
		List<Community> columnList = chartDao.selectColumnList();
		
		List<ProductEntity> likeProductList = chartDao.selectLikeProduct();
		
		List<Promotion> promotionList = chartDao.selectCurrentPromotionList();
		
		map.put("likeCommunityList", likeCommunityList);
		map.put("freeboardList", freeboardList);
		map.put("qnaList", qnaList);
		map.put("columnList", columnList);
		map.put("likeProductList", likeProductList);
		map.put("promotionList", promotionList);
		
		
		return map;
	}

	
	

}
