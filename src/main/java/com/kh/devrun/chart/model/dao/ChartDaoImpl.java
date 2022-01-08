package com.kh.devrun.chart.model.dao;

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
	public Map<String, Object> countSalesPerDay() {
		return null;
	}

	@Override
	public Map<String, Object> countSalesPerMonth() {
		return null;
	}

	@Override
	public int countOrderCnt() {
		return 0;
	}

	@Override
	public Map<String, Object> countOrderLogCnt() {
		return null;
	}

	@Override
	public Map<String, Object> countCommunityPerMonth() {
		return null;
	}
	
	

}
