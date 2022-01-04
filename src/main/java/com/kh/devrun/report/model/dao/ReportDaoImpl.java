package com.kh.devrun.report.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ReportDaoImpl implements ReportDao {

	@Autowired
	private SqlSession session;

	@Override
	public int insertReport(Report report) {
		return session.insert("report.insertReport", report);
	}
	
	/**
	 * 지원 dao 시작
	 */
	@Override
	public List<Report> selectAllReportByMemberNo(int memberNo, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("report.selectAllReportByMemberNo", memberNo, rowBounds);
	}

	@Override
	public int selectReportTotalCount(int memberNo) {
		return session.selectOne("report.selectReportTotalCount", memberNo);
	}
	/**
	 * 지원 dao 끝
	 */

}
