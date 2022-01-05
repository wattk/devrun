package com.kh.devrun.category.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.category.model.vo.ProductParentCategory;

@Repository
public class ProductCategoryDaoImpl implements ProductCategoryDao {

	@Autowired
	SqlSession session;

	@Override
	public List<ProductParentCategory> selectAllParentCategory() {
		return session.selectList("productCategory.selectAllParentCategory");
	}

	@Override
	public List<ProductChildCategory> searchChildCategory(String code) {
		return session.selectList("productCategory.searchChildCategory",code);
	}
}
