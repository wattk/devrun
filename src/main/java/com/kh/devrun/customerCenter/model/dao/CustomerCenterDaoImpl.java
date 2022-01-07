package com.kh.devrun.customerCenter.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.customerCenter.model.vo.Notice;

@Repository
public class CustomerCenterDaoImpl implements CustomerCenterDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<Notice> selectAllNoticeList(Map<String, Object> param, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("customerCenter.selectAllNoticeList", param, rowBounds);
	}

	@Override
	public int insertNotice(Notice notice) {
		return session.insert("customerCenter.insertNotice", notice);
	}

	@Override
	public Notice selectOneNotice(int noticeNo) {
		return session.selectOne("customerCenter.selectOneNotice", noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {
		return session.update("customerCenter.updateNotice", notice);
	}

	@Override
	public int deleteNotice(int[] noticeNo) {
		return session.delete("customerCenter.deleteNotice", noticeNo);
	}

	@Override
	public int selectNoticeTotalCount(Map<String, Object> param) {
		return session.selectOne("customerCenter.selectNoticeTotalCount", param);
	}

	@Override
	public List<Notice> selectAllFaqList(Map<String, Object> param, int offset, int limit) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("customerCenter.selectAllFaqList", param, rowBounds);
	}

	@Override
	public int selectFaqTotalCount(Map<String, Object> param) {
		return session.selectOne("customerCenter.selectFaqTotalCount", param);
	}

	@Override
	public int insertFaq(Notice notice) {
		return session.insert("customerCenter.insertFaq", notice);
	}

	@Override
	public int updateFaq(Notice notice) {
		return session.update("customerCenter.updateFaq", notice);
	}

	@Override
	public int updateViewCount(int noticeNo) {
		return session.update("customerCenter.updateViewCount", noticeNo);
	}
}
