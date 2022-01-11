package com.kh.devrun.questionProductCus.model.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProductCus.model.vo.QuestionProductId;


@Repository
public class CusQuestionProductDaoImpl implements CusQuestionProductDao {

	@Autowired
	private SqlSession session;

	@Override
	public int insertQuestionProduct(Map<String, Object> param) {
		return session.insert("questionProduct.insertQuestionProduct",param);
	}

	@Override
	public List<QuestionProductId> selectQuestionList(String productCode) {
		return session.selectList("questionProduct.selectQuestionList",productCode);
	}

	@Override
	public List<QuestionProduct> checkMyQuestionProduct(Map<String, Object> param) {
		return session.selectList("questionProduct.checkMyQuestionProduct",param);
	}
	
}
