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
import com.kh.devrun.order.model.vo.MerchantExt;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.shop.model.vo.Cart;

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
	public int insertOrder(Merchant merchant) {
		int result = 0;
		String merchantUid = merchant.getMerchantUid();
		Map<String, Object> param = new HashMap<>();
		param.put("merchantUid", merchantUid);
		
		try {
			result = orderDao.insertOrder(merchant);
			result = orderDao.insertOrderDetail(merchant.getMerchantDetailList());
			result = orderDao.deleteCart(param);
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

	@Override
	public Map<String, Object> selectMyShopping(int memberNo) {
		Map<String, Object> map = new HashMap<>();
		//주문상태별 count
		
		//취소/교환/환불 count
		int orderLogCnt = orderDao.selectOrderLogCnt(memberNo);
		map.put("orderLogCnt", orderLogCnt);
		
		//최근 주문 내역 3건
		List<MerchantExt> orderList = orderDao.selectCurrentOrder(memberNo);
		map.put("orderList", orderList);
		
		return map;
	}

	@Override
	public List<MerchantExt> selectOrderList(int memberNo) {
		return orderDao.selectOrderList(memberNo);
	}

	@Override
	public List<Cart> selectCartList(int memberNo) {
		return orderDao.selectCartList(memberNo);
	}
	
	

}
