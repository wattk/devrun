package com.kh.devrun.chart.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.chart.model.dao.ChartDao;

@Service
public class ChartServiceImpl implements ChartService {
	
	@Autowired
	private ChartDao chartDao;


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
	public Map<String, JSONObject> findMainChart() {
		Map<String, JSONObject> map = new HashMap<>();
		
		//일별, 월별 판매량
		Map<String, Object> dailySales = chartDao.countSalesPerDay();
		Map<String, Object> monthlySales = chartDao.countSalesPerMonth();
		
		//주문 통계
		int orderCnt = chartDao.countOrderCnt();
		Map<String, Object> orderLogCnts = chartDao.countOrderLogCnt();
		
		//게시판 게시글 수 통계
		Map<String, Object> communityCnts = chartDao.countCommunityPerMonth();
		
		return map;
	}

	
	

}
