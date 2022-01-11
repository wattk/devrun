package com.kh.devrun.questionProductCus.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.questionProduct.exception.insertQuestionProductException;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProductCus.model.dao.CusQuestionProductDao;
import com.kh.devrun.questionProductCus.model.vo.QuestionProductId;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CusQuestionProductServiceImpl implements CusQuestionProductService {

	@Autowired
	CusQuestionProductDao cusQuestionProductdao;

	@Override
	public int insertQuestionProduct(Map<String, Object> param) {
		int result = 0;
		
		try {
			result = cusQuestionProductdao.insertQuestionProduct(param);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new insertQuestionProductException("상품 문의 등록 오류!",e);
		}
		
		return result;
	}


	public List<QuestionProductId> selectQuestionList(String productCode) {
		return cusQuestionProductdao.selectQuestionList(productCode);
	}


	@Override
	public  List<QuestionProduct>  checkMyQuestionProduct(Map<String, Object> param) {
		return cusQuestionProductdao.checkMyQuestionProduct(param);
	}
}
