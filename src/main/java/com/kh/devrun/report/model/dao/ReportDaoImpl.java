package com.kh.devrun.report.model.dao;

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

}
