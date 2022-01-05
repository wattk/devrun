package com.kh.devrun.questionProduct.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;

public interface QuestionProductDao {

	List<QuestionProduct> selectAllQuestionList(int limit, int offset);

	QuestionProductEx selectOneQuestionProductInfo(Map<String,Object> param);

	int insertQuestionProduct(QuestionProduct questionProduct);

	QuestionProduct selectQuestionByRefNo(int questionNo);

	// question_ref_no update
	int updateQuestionRefNo(QuestionProduct questionProduct);

	// 답변 수정
	int updateAnswer(Map<String,Object>param);

	// 전체 게시물 수(답변 제외 한 수)
	int selectTotalQuestionCount();

	// 비동기 검색(답변여부 제외)
	List<QuestionProduct> searchQuestionList(Map<String, Object> param);

	int searchQuestionListCount(Map<String, Object> param);

	List<QuestionProduct> searchQuestionListByAnswerYn(Map<String, Object> param);

	int searchQuestionListByAnswerYnCount(Map<String, Object> param);

}
