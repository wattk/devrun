package com.kh.devrun.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.order.model.dao.OrderDao;
import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;
import com.kh.devrun.product.model.vo.Product;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDao orderDao;

	@Override
	@Transactional(
			propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class
	)
	public int insertOrder(Merchant order, List<MerchantDetail> list) {
		int result = 0;
		
		try {
			result = orderDao.insertOrder(order);
			result = orderDao.insertOrderDetail(list);
		} catch (Exception e) {
			throw new RuntimeException("주문 관련 등록 오류", e);
		}
		return result;
	}

	@Override
	public int insertImp(Imp imp) {
		return orderDao.insertImp(imp);
	}

	@Override
	public Map<String, Object> selectOneMerchant(String merchantUid) {
		Map<String, Object> map = new HashMap<>();
		
		Merchant merchant = orderDao.selectOneMerchant(merchantUid);
		map.put("merchant", merchant);
		
		Imp imp = orderDao.selectOneImp(merchantUid);
		map.put("imp", imp);
		
		List<Integer> detailNoList = new ArrayList<>();
		
		for(MerchantDetail d : merchant.getMerchantDetailList()) {
			detailNoList.add(d.getDetailNo());
		}
		
		List<Product> list = orderDao.selectMerchantProductList(detailNoList);
		map.put("list", list);
		
		return map;
	}
	
	

}
