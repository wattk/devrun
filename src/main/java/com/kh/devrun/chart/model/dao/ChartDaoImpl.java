package com.kh.devrun.chart.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.community.model.vo.Community;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.promotion.model.vo.Promotion;

@Repository
public class ChartDaoImpl implements ChartDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public int countDailySales() {
		return session.selectOne("chart.countDailySales");
	}

	@Override
	public int countMonthlySales() {
		return session.selectOne("chart.countMonthlySales");
	}

	@Override
	public int countMembers() {
		return session.selectOne("chart.countMembers");
	}

	@Override
	public int countTodayMembers() {
		return session.selectOne("chart.countTodayMembers");
	}

	@Override
	public int countBlacklist() {
		return session.selectOne("chart.countBlacklist");
	}

	
	@Override
	public int countQuestionProduct() {
		return session.selectOne("chart.countQuestionProduct");
	}

	@Override
	public int countCommunities() {
		return session.selectOne("chart.countCommunities");
	}

	@Override
	public List<Map<String, Object>> countSalesPerDay() {
		return session.selectList("chart.countSalesPerDay");
	}

	@Override
	public List<Map<String, Object>> countSalesProduct() {
		return session.selectList("chart.countSalesProduct");
	}

	@Override
	public int countOrderCnt() {
		return session.selectOne("chart.countOrderCnt");
	}

	@Override
	public Map<String, Integer> countOrderLogCnt() {
		return session.selectOne("chart.countOrderLogCnt");
	}

	@Override
	public List<Map<String, Object>> countCommunityPerMonth() {
		return session.selectList("chart.countCommunityPerMonth");
	}
	
	
	/**
	 * 메인 페이지 관련 데이터 작업
	 */

	@Override
	public List<Map<String, Object>> selectBestCommunity() {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("community.selectBestCommunity", null, rowBounds);
	}

	@Override
	public List<CommunityEntity> selectFreeboardList() {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("community.selectFreeboardList", null, rowBounds);
	}

	@Override
	public List<Map<String, Object>> selectQnaList() {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("community.selectQnaList", null, rowBounds);
	}

	@Override
	public List<Community> selectColumnList() {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("community.columnBestList", null, rowBounds);
	}

	@Override
	public List<ProductEntity> selectLikeProduct() {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("product.selectLikeProduct", null, rowBounds);
	}

	@Override
	public List<Promotion> selectCurrentPromotionList() {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("promotion.selectCurrentPromotionList", null, rowBounds);
	}
	
	

}
