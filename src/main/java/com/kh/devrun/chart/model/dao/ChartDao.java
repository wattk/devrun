package com.kh.devrun.chart.model.dao;

import java.util.List;
import java.util.Map;

public interface ChartDao {

	int countDailySales();

	int countMonthlySales();

	int countMembers();

	int countTodayMembers();

	int countBlacklist();

	int countQuestionProduct();
	
	int countCommunities();

	List<Map<String, Object>> countSalesPerDay();

	List<Map<String, Object>> countSalesProduct();

	int countOrderCnt();

	Map<String, Integer> countOrderLogCnt();

	List<Map<String, Object>> countCommunityPerMonth();


}
