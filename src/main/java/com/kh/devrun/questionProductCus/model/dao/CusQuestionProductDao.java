package com.kh.devrun.questionProductCus.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProductCus.model.vo.QuestionProductId;

public interface CusQuestionProductDao {

	int insertQuestionProduct(Map<String, Object> param);

	List<QuestionProductId> selectQuestionList(String productCode);

	 List<QuestionProduct>  checkMyQuestionProduct(Map<String, Object> param);

}
