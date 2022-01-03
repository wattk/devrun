package com.kh.devrun.report.model.service;

import java.util.List;

import com.kh.devrun.report.model.vo.Report;

public interface ReportService {

	int insertReport(Report report);

	List<Report> selectAllReportByMemberNo(int memberNo, int offset, int limit);

	int selectReportTotalCount(int memberNo);
	
}
