package com.kh.devrun.chart.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.customerCenter.model.vo.Notice;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.promotion.model.vo.Promotion;

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

	List<Map<String, Object>> selectBestCommunity();

	List<CommunityEntity> selectFreeboardList();

	List<Map<String, Object>> selectQnaList();

	List<Community> selectColumnList();

	List<ProductEntity> selectLikeProduct();

	List<Promotion> selectCurrentPromotionList();

	List<CommunityEntity> findComminitySearch(String searchKeyword);

	List<Product> findProductSearch(String searchKeyword);

	List<Notice> findNoticeSearch(String searchKeyword);


}
