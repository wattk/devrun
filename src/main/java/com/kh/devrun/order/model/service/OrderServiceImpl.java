package com.kh.devrun.order.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.devrun.order.model.dao.OrderDao;
import com.kh.devrun.order.model.vo.Order;
import com.kh.devrun.order.model.vo.OrderDetail;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDao orderDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertDirectOrder(Order order, List<OrderDetail> list) {
		int result = 0;
		
		result = orderDao.insertOrder(order);
		result = orderDao.insertOrderDetail(list);
		return result;
	}
	
	

}
