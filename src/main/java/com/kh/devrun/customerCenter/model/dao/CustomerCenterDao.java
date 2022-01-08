package com.kh.devrun.customerCenter.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.customerCenter.model.vo.Notice;

public interface CustomerCenterDao {

	List<Notice> selectAllNoticeList(Map<String, Object> param, int offset, int limit);

	int insertNotice(Notice notice);

	Notice selectOneNotice(int noticeNo);

	int updateNotice(Notice notice);

	int deleteNotice(int[] noticeNo);

	int selectNoticeTotalCount(Map<String, Object> param);

	List<Notice> selectAllFaqList(Map<String, Object> param, int offset, int limit);

	int selectFaqTotalCount(Map<String, Object> param);

	int insertFaq(Notice notice);

	int updateFaq(Notice notice);

	int updateViewCount(int noticeNo);

}
