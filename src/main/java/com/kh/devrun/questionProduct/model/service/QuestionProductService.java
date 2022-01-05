package com.kh.devrun.questionProduct.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;

public interface QuestionProductService {

	List<QuestionProduct> selectAllQuestionList(int limit, int offset);

	// 선택한 상품 문의 정보 가져오기
	QuestionProductEx selectOneQuestionProductInfo(Map<String,Object> param);

	int insertQuestionProduct(QuestionProduct questionProduct);

	// 문의 번호를 참조번호로 하는 게시물 가져오기
	QuestionProduct selectQuestionByRefNo(int questionNo);

	// 답변 수정
	int updateAnswer(Map<String,Object>param);

	// 전체 게시물 수 
	int selectTotalQuestionCount();

	// 비동기 검색 & 페이징
	List<QuestionProduct> searchQuestionList(Map<String, Object> param);

	// 검색 결과 수
	int searchQuestionListCount(Map<String, Object> param);

	int searchQuestionListByAnswerYnCount(Map<String, Object> param);
	
}
