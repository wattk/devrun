package com.kh.devrun.category.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.category.model.vo.ProductChildCategory;

@Repository
public class CategoryDaoImpl implements CategoryDao{

	@Autowired
	private SqlSession session;

	@Override
	public List<ProductChildCategory> selectChildCategory(Map<String, Object> param) {
		return session.selectList("category.selectChildCategory",param);
	}
	
	
}
