package com.kh.devrun.order.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.kh.devrun.order.model.dao.OrderDao;
import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;

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
	public int insertDirectOrder(Merchant order, List<MerchantDetail> list) {
		int result = 0;
		
		try {
			result = orderDao.insertOrder(order);
			result = orderDao.insertOrderDetail(list);
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw new RuntimeException("주문 관련 등록 오류", e);
		}
		return result;
	}

	@Override
	public int insertImp(Imp imp) {
		return orderDao.insertImp(imp);
	}
	
	

}
