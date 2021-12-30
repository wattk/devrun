package com.kh.devrun.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.order.model.vo.Order;
import com.kh.devrun.order.model.vo.OrderDetail;

@Repository
public class OrderDaoImpl implements OrderDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insertOrder(Order order) {
		return session.insert("order.insertOrder", order);
	}

	@Override
	public int insertOrderDetail(List<OrderDetail> list) {
		return session.insert("order.insertOrderDetail", list);
	}
	
	

}
