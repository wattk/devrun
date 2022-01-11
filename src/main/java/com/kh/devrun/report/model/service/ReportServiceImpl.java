package com.kh.devrun.report.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.report.model.dao.ReportDao;
import com.kh.devrun.report.model.exception.ReportException;
import com.kh.devrun.report.model.vo.Blacklist;
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
	
	/**
	 * 지영 서비스 시작
	 */
	@Override
	public List<Report> selectReviewReportList() {
		return reportDao.selectReviewReportList();
	}

	@Override
	public String searchProductCode(String no) {
		return reportDao.searchProductCode(no);
	}

	/**
	 * 트랜잭션 처리
	 * - 여러건의 dml이 모두 성공/실패로 처리해야하는 최소단위
	 */
	@Override
	@Transactional(
			propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class 
	)
	public int reportStatusUpdate(Map<String, Object> param) {
		int result = 0;
		int result1 = 0;
		
		try {
			// report update (처리상태, 처리자 업데이트)
			result = reportDao.reportStatusUpdate(param);
			//log.debug("status = {}", param.get("status"));
			
			// member update (신고대상 경고부여 - 처리 완료인 경우)
			if("CF".equals(param.get("status"))) {
				result = reportDao.updateWarningCount(param);
				// 신고 대상 회원이 경고횟수가 딱 3회인 경우(3회 이상이면 계속 업데이트되어 블랙 등록이 아래에 계속 진행됨) 블랙리스트 등록, 사유는 경고횟수 누적
				// + 이미 블랙인 회원은 바로 블랙 등록하는 경우 대비하여 black_yn이 'N'인 상태만 update할것
				result1 = reportDao.checkMemberBlackInsert(param);
			}
			
			// 블랙 등록된 경우 (딱 3회인 경우에만 result1 조건 통과하므로 계속 블랙이 등록되지 않음)
			if(result1 > 0) {
				result = reportDao.blacklistEnroll(param);
			}
			
		} catch (Exception e) {
			// 예외 꼭 던져야 한다. 그래야 트랜잭션 매니저가 안다.
			// 사용자정의예외(RuntimeException)로 전환 던짐
			throw new ReportException("처리상태 변경 오류", e);
		}
		
		return result;
	}

	@Override
	public List<Report> selectMessageReportList() {
		return reportDao.selectMessageReportList();
	}

	@Override
	public List<Report> selectBoardReportList() {
		return reportDao.selectBoardReportList();
	}

	@Override
	public List<Report> selectCommentReportList() {
		return reportDao.selectCommentReportList();
	}

	@Override
	public int searchCommunityNo(int no) {
		return reportDao.searchCommunityNo(no);
	}

	@Override
	public List<Report> selectMemberReportList() {
		return reportDao.selectMemberReportList();
	}

	@Override
	public List<Blacklist> selectAllBlacklist() {
		return reportDao.selectAllBlacklist();
	}

	/**
	 * 트랜잭션 처리
	 * - 여러건의 dml이 모두 성공/실패로 처리해야하는 최소단위
	 */
	@Override
	@Transactional(
			propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class 
	)
	public int blacklistRelease(Map<String, Object> param) {
		int result = 0;
		
		try {
			// blacklist update (해제일, 처리자 업데이트)
			result = reportDao.blacklistReleaseUpdate(param);
			
			// member update (경고횟수, 블랙여부 업데이트)
			result = reportDao.blacklistRelease(param);
			
		} catch (Exception e) {
			// 예외 꼭 던져야 한다. 그래야 트랜잭션 매니저가 안다.
			// 사용자정의예외(RuntimeException)로 전환 던짐
			throw new ReportException("블랙리스트 해제 오류", e);
		}
		
		return result;
	}

	@Override
	public int noteUpdate(Map<String, Object> param) {
		return reportDao.noteUpdate(param);
	}
	
	/**
	 * 지영 서비스 끝
	 */

}
