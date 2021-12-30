package com.kh.devrun.order.model.service;

import java.util.List;

import com.kh.devrun.order.model.vo.Order;
import com.kh.devrun.order.model.vo.OrderDetail;

public interface OrderService {

	int insertDirectOrder(Order order, List<OrderDetail> list);

}
