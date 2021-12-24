package com.kh.devrun.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.admin.exception.ProductInsertException;
import com.kh.devrun.admin.model.dao.AdminDao;
import com.kh.devrun.category.model.vo.ProductChildCategory;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductCategory;
import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductExtends;
import com.kh.devrun.promotion.model.exception.PromotionException;
import com.kh.devrun.promotion.model.vo.Promotion;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService {


	
}
