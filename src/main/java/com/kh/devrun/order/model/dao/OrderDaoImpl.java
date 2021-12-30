package com.kh.devrun.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;

@Repository
public class OrderDaoImpl implements OrderDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insertOrder(Merchant order) {
		return session.insert("order.insertOrder", order);
	}

	@Override
	public int insertOrderDetail(List<MerchantDetail> list) {
		return session.insert("order.insertOrderDetail", list);
	}

	@Override
	public int insertImp(Imp imp) {
		return session.insert("order.insertImp", imp);
	}
	
	

}
