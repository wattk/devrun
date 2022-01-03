package com.kh.devrun.report.model.dao;

import java.util.List;

import com.kh.devrun.report.model.vo.Report;

public interface ReportDao {

	int insertReport(Report report);
	
	List<Report> selectAllReportByMemberNo(int memberNo, int offset, int limit);

	int selectReportTotalCount(int memberNo);

}
