package com.kh.devrun.questionProduct.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;

@Repository
public class QuestionProductDaoImpe implements QuestionProductDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<QuestionProduct> selectAllQuestionList() {
		return session.selectList("questionProduct.selectAllQuestionList");
	}
}
