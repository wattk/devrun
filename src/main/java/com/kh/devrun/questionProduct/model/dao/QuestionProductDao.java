package com.kh.devrun.questionProduct.model.dao;

import java.util.List;

import com.kh.devrun.questionProduct.model.vo.QuestionProduct;

public interface QuestionProductDao {

	List<QuestionProduct> selectAllQuestionList();

}
