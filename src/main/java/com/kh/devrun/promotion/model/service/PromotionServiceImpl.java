package com.kh.devrun.promotion.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.promotion.model.dao.PromotionDao;

@Service
public class PromotionServiceImpl implements PromotionService {
	
	@Autowired
	private PromotionDao promotionDao;

	
	

}
