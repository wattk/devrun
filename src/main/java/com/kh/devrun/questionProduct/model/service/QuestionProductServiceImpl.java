package com.kh.devrun.questionProduct.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.questionProduct.exception.insertQuestionProductException;
import com.kh.devrun.questionProduct.exception.updateAnswerException;
import com.kh.devrun.questionProduct.model.dao.QuestionProductDao;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;
import com.kh.devrun.questionProduct.model.vo.QuestionProductEx;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class QuestionProductServiceImpl implements QuestionProductService {
	
	@Autowired
	private QuestionProductDao questionProductDao;

	@Override
	public List<QuestionProduct> selectAllQuestionList(int limit, int offset) {
		return questionProductDao.selectAllQuestionList(limit,offset);
	}

	@Override
	public QuestionProductEx selectOneQuestionProductInfo(Map<String,Object> param) {
		return questionProductDao.selectOneQuestionProductInfo(param);
	}
	

	// 상품 문의 답변 1행 추가
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertQuestionProduct(QuestionProduct questionProduct) {
		
		int result = 0;
		
		try {
			// question_product 1행 추가
			result = questionProductDao.insertQuestionProduct(questionProduct);
			log.debug("questionRefNo = {}", questionProduct.getQuestionRefNo());				
			
			
			// select key를 통해 mapper에서 막 insert한 product
			questionProduct.setQuestionNo(questionProduct.getQuestionNo());
			result = updateQuestionRefNo(questionProduct); 
			
			
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new insertQuestionProductException("상품등록 오류가 발생했습니다.",e);
		}		
		return result;
	}
	
	// 문의 번호를 참조번호로 하는 게시물 가져오기
	@Override
	public QuestionProduct selectQuestionByRefNo(int questionNo) {
		return questionProductDao.selectQuestionByRefNo(questionNo);
	}
	
	// 답변한 게시물의 question_ref_no 업데이트
	@Transactional(rollbackFor = Exception.class)
	public int updateQuestionRefNo(QuestionProduct questionProduct) {	
		return questionProductDao.updateQuestionRefNo(questionProduct);
	}

	// 답변 수정
	@Override
	public int updateAnswer(Map<String,Object>param) {
		int result = 0;
		
		try {
			result = questionProductDao.updateAnswer(param);
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new updateAnswerException("상품 문의 답변 수정 오류!",e);
		}
		
		return result;
	}

	// 전체 게시물 수
	@Override
	public int selectTotalQuestionCount() {
		return questionProductDao.selectTotalQuestionCount();
	}

	// 비동기 검색(검색 타입별 분기처리) 
	@Override
	public List<QuestionProduct> searchQuestionList(Map<String, Object> param) {
				
		log.debug("param = {}",param);
		String searchType = (String)param.get("searchType");
		
		List<QuestionProduct> searchQuestionList = null;
		
		// 검색 타입이
		if(searchType.equals("answer_yn")){			
			searchQuestionList = questionProductDao.searchQuestionListByAnswerYn(param);
		}	
		else {
			searchQuestionList = questionProductDao.searchQuestionList(param);
		}

		return searchQuestionList;
	}

	// 검색 검색 결과 수(답변 여부 제외)
	@Override
	public int searchQuestionListCount(Map<String, Object> param) {
		return questionProductDao.searchQuestionListCount(param);
	}

	// 답변 여부 검색 결과 수
	@Override
	public int searchQuestionListByAnswerYnCount(Map<String, Object> param) {
		return questionProductDao.searchQuestionListByAnswerYnCount(param);
	}
	
}
