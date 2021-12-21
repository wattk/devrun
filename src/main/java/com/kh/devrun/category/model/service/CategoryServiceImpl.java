package com.kh.devrun.category.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.category.model.dao.CategoryDao;
import com.kh.devrun.category.model.vo.ProductChildCategory;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDao categoryDao;

	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return categoryDao.selectChildCategory(param);
	}
	
	
}
