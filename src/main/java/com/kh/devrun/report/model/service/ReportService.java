package com.kh.devrun.report.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.report.model.vo.Blacklist;
import com.kh.devrun.report.model.vo.Report;

public interface ReportService {

	int insertReport(Report report);

	List<Report> selectAllReportByMemberNo(int memberNo, int offset, int limit);

	int selectReportTotalCount(int memberNo);

	List<Report> selectReviewReportList();

	String searchProductCode(String no);

	int reportStatusUpdate(Map<String, Object> param);

	List<Report> selectMessageReportList();

	List<Report> selectBoardReportList();

	List<Report> selectCommentReportList();

	int searchCommunityNo(int no);

	List<Report> selectMemberReportList();

	List<Blacklist> selectAllBlacklist();

	int blacklistRelease(Map<String, Object> param);

	int noteUpdate(Map<String, Object> param);
	
}
