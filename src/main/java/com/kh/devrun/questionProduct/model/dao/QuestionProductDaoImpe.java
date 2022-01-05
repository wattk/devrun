package com.kh.devrun.questionProduct.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class QuestionProductDaoImpe implements QuestionProductDao {

	@Autowired
	private SqlSession session;

	// 전체 게시물 조회
	@Override
	public List<QuestionProduct> selectAllQuestionList(int limit, int offset) {
		RowBounds rowBounds = new RowBounds(offset,limit);
		log.debug("전체 상품 문의 조회");
		return session.selectList("questionProduct.selectAllQuestionList",null,rowBounds);
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

	// 답변 등록 후 바로 question_ref_no 업데이트
	@Override
	public int updateQuestionRefNo(QuestionProduct questionProduct) {
		return session.update("questionProduct.updateQuestionRefNo",questionProduct);
	}

	// 답변 수정
	@Override
	public int updateAnswer(Map<String,Object>param) {
		return session.update("questionProduct.updateAnswer",param);
	}

	// 전체 질문 수 (답변 제외)
	@Override
	public int selectTotalQuestionCount() {
		return session.selectOne("questionProduct.selectTotalQuestionCount");
	}

	// 비동기 검색(담변 여부 제외한 검색)
	@Override
	public List<QuestionProduct> searchQuestionList(Map<String, Object> param) {
		
		int limit = (int)param.get("limit");
		int offset = (int)param.get("offset");
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return session.selectList("questionProduct.searchQuestionList",param,rowBounds);
	}
	// 비동기 검색 (답변여부로 검색)
	@Override
	public List<QuestionProduct> searchQuestionListByAnswerYn(Map<String, Object> param) {
		String ans = (String)param.get("searchKeyword");
		
		log.debug("ans = {}",ans);
		int limit = (int)param.get("limit");
		int offset = (int)param.get("offset");
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return session.selectList("questionProduct.searchQuestionListByAnswerYn",param,rowBounds);
	}

	// 검색 결과 수(답변 여부 제외)
	@Override
	public int searchQuestionListCount(Map<String, Object> param) {
		return session.selectOne("questionProduct.searchQuestionListCount",param);
	}
	
	// 검색 결과 수(답변 여부)
	@Override
	public int searchQuestionListByAnswerYnCount(Map<String, Object> param) {
		return session.selectOne("questionProduct.searchQuestionListByAnswerYnCount",param);
	}
	

	
	
	
}









