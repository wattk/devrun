package com.kh.devrun.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.devrun.admin.model.dao.AdminDao;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.Product;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;
	
	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return adminDao.selectChildCategory(param);
	}

	@Override
	public int insertProduct(Product product) {
		return adminDao.insertProduct(product);
	}
}
