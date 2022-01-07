package com.kh.devrun.customerCenter.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.customerCenter.model.dao.CustomerCenterDao;
import com.kh.devrun.customerCenter.model.vo.Notice;

@Service
public class CustomerCenterServiceImpl implements CustomerCenterService {

	@Autowired
	private CustomerCenterDao customerCenterDao;

	@Override
	public List<Notice> selectAllNoticeList(Map<String, Object> param, int offset, int limit) {
		return customerCenterDao.selectAllNoticeList(param, offset, limit);
	}

	@Override
	public int insertNotice(Notice notice) {
		return customerCenterDao.insertNotice(notice);
	}

	@Override
	public Notice selectOneNotice(int noticeNo) {
		return customerCenterDao.selectOneNotice(noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {
		return customerCenterDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int[] noticeNo) {
		return customerCenterDao.deleteNotice(noticeNo);
	}

	@Override
	public int selectNoticeTotalCount(Map<String, Object> param) {
		return customerCenterDao.selectNoticeTotalCount(param);
	}

	@Override
	public List<Notice> selectAllFaqList(Map<String, Object> param, int offset, int limit) {
		return customerCenterDao.selectAllFaqList(param, offset, limit);
	}

	@Override
	public int selectFaqTotalCount(Map<String, Object> param) {
		return customerCenterDao.selectFaqTotalCount(param);
	}

	@Override
	public int insertFaq(Notice notice) {
		return customerCenterDao.insertFaq(notice);
	}

	@Override
	public int updateFaq(Notice notice) {
		return customerCenterDao.updateFaq(notice);
	}

	@Override
	public int updateViewCount(int noticeNo) {
		return customerCenterDao.updateViewCount(noticeNo);
	}
}
