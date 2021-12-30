package com.kh.devrun.order.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.order.model.dao.OrderDao;
import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDao orderDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED, 
	isolation = Isolation.READ_COMMITTED, 
	rollbackFor = {Exception.class})
	public int insertDirectOrder(Merchant order, List<MerchantDetail> list) {
		int result = 0;
		
		try {
			result = orderDao.insertOrder(order);
			result = orderDao.insertOrderDetail(list);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		return result;
	}

	@Override
	public int insertImp(Imp imp) {
		return orderDao.insertImp(imp);
	}
	
	

}
