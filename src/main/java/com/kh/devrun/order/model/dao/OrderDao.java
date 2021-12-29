package com.kh.devrun.order.model.dao;

import java.util.List;

import com.kh.devrun.order.model.vo.Order;
import com.kh.devrun.order.model.vo.OrderDetail;

public interface OrderDao {

	int insertOrder(Order order);

	int insertOrderDetail(List<OrderDetail> list);

}
