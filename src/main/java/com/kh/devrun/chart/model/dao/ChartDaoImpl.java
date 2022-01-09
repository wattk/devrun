package com.kh.devrun.chart.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	

}
