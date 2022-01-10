package com.kh.devrun.report.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.report.model.vo.Blacklist;
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

	/**
	 * 지영 dao 시작
	 */
	@Override
	public List<Report> selectReviewReportList() {
		return session.selectList("report.selectReviewReportList");
	}

	@Override
	public String searchProductCode(String no) {
		return session.selectOne("report.searchProductCode", no);
	}

	@Override
	public int reportStatusUpdate(Map<String, Object> param) {
		return session.update("report.reportStatusUpdate", param);
	}

	@Override
	public int updateWarningCount(Map<String, Object> param) {
		return session.update("report.updateWarningCount", param);
	}

	@Override
	public int checkMemberBlackInsert(Map<String, Object> param) {
		return session.update("report.checkMemberBlackInsert", param);
	}

	@Override
	public int blacklistEnroll(Map<String, Object> param) {
		return session.insert("report.blacklistEnroll", param);
	}

	@Override
	public List<Report> selectMessageReportList() {
		return session.selectList("report.selectMessageReportList");
	}

	@Override
	public List<Report> selectBoardReportList() {
		return session.selectList("report.selectBoardReportList");
	}

	@Override
	public List<Report> selectCommentReportList() {
		return session.selectList("report.selectCommentReportList");
	}

	@Override
	public int searchCommunityNo(int no) {
		return session.selectOne("report.searchCommunityNo", no);
	}

	@Override
	public List<Report> selectMemberReportList() {
		return session.selectList("report.selectMemberReportList");
	}

	@Override
	public List<Blacklist> selectAllBlacklist() {
		return session.selectList("report.selectAllBlacklist");
	}

	@Override
	public int blacklistReleaseUpdate(Map<String, Object> param) {
		return session.update("report.blacklistReleaseUpdate", param);
	}

	@Override
	public int blacklistRelease(Map<String, Object> param) {
		return session.update("report.blacklistRelease", param);
	}

	@Override
	public int noteUpdate(Map<String, Object> param) {
		return session.update("report.noteUpdate", param);
	}
	
	/**
	 * 지영 dao 끝
	 */

}
