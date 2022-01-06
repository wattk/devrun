package com.kh.devrun.category.model.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.category.model.dao.ProductCategoryDao;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductCategoryServiceImpl implements ProductCategoryService {

	@Autowired
	private ProductCategoryDao productCategoryDao;

	@Override
	public List<ProductParentCategory> selectAllParentCategory() {
		return productCategoryDao.selectAllParentCategory();
	}

	@Override
	public List<ProductChildCategory> searchChildCategory(String code) {
		return productCategoryDao.searchChildCategory(code);
	}
}
