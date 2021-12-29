package com.kh.devrun.questionProduct.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.questionProduct.model.dao.QuestionProductDao;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class QuestionProductServiceImpl implements QuestionProductService {
	
	@Autowired
	private QuestionProductDao questionProductDao;

	@Override
	public List<QuestionProduct> selectAllQuestionList() {
		return questionProductDao.selectAllQuestionList();
	}
	
}
