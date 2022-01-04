package com.kh.devrun.report.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.report.model.dao.ReportDao;
import com.kh.devrun.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;

	@Override
	public int insertReport(Report report) {
		return reportDao.insertReport(report);
	}
	
	/**
	 * 지원 서비스 시작
	 */
	
	/**
	 * 전체 신고 조회
	 */
	@Override
	public List<Report> selectAllReportByMemberNo(int memberNo, int offset, int limit) {
		return reportDao.selectAllReportByMemberNo(memberNo, offset, limit);
	}

	/**
	 * 전체 신고 개수
	 */
	@Override
	public int selectReportTotalCount(int memberNo) {
		return reportDao.selectReportTotalCount(memberNo);
	}
	
	/**
	 * 지원 서비스 끝
	 */

}
