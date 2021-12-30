package com.kh.devrun.questionProduct.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;

@Repository
public class QuestionProductDaoImpe implements QuestionProductDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<QuestionProduct> selectAllQuestionList() {
		return session.selectList("questionProduct.selectAllQuestionList");
	}

	// 선택한 상품문의 정보 && 상품 정보 가져오기
	@Override
	public QuestionProductEx selectOneQuestionProductInfo(Map<String,Object> param) {
		return session.selectOne("questionProduct.selectOneQuestionProductInfo",param);
	}
	
	// 상품 문의 답변 추가
	@Override
	public int insertQuestionProduct(QuestionProduct questionProduct) {
		return session.insert("questionProduct.insertQuestionProduct",questionProduct);
	}

	// 문의 번호를 참조번호로 하는 게시물 가져오기
	@Override
	public QuestionProduct selectQuestionByRefNo(int questionNo) {
		return session.selectOne("questionProduct.selectQuestionByRefNo",questionNo);
	}
	
	
}









