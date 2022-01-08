package com.kh.devrun.chart.model.dao;

import java.util.Map;

public interface ChartDao {

	int countDailySales();

	int countMonthlySales();

	int countMembers();

	int countTodayMembers();

	int countBlacklist();

	int countQuestionProduct();
	
	int countCommunities();

	Map<String, Object> countSalesPerDay();

	Map<String, Object> countSalesPerMonth();

	int countOrderCnt();

	Map<String, Object> countOrderLogCnt();

	Map<String, Object> countCommunityPerMonth();


}
