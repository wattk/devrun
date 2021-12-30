package com.kh.devrun.questionProduct.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;

public interface QuestionProductDao {

	List<QuestionProduct> selectAllQuestionList();

	QuestionProductEx selectOneQuestionProductInfo(Map<String,Object> param);

	int insertQuestionProduct(QuestionProduct questionProduct);

	QuestionProduct selectQuestionByRefNo(int questionNo);

}
