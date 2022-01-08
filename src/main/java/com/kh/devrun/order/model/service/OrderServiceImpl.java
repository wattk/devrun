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
import com.kh.devrun.order.model.vo.OrderLog;
import com.kh.devrun.order.model.vo.OrderLogExt;
import com.kh.devrun.order.model.vo.Shipment;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.shop.model.vo.Cart;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
		
		if("SS".equals(merchant.getOrderStatus()) || "OC".equals(merchant.getOrderStatus())) {
			Map<String, Object> param = new HashMap<>();
			param.put("value", merchant.getMerchantUid());
			
			if("COM".equals(merchant.getCsStatus())) {
				param.put("target", "merchant");
			}
			else {
				param.put("target", "orderLog");
				
			}
			
			Shipment shipment = orderDao.selectOneShipment(param);
			map.put("shipment", shipment);
		}
		
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

	@Override
	public List<Merchant> selectAllMerchant() {
		return orderDao.selectAllMerchant();
	}

	@Override
	public List<Merchant> selectMerchantList(Map<String, Object> param) {
		return orderDao.selectMerchantProductList(param);
	}

	@Override
	@Transactional(
			propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class
	)
	public int updateMerchant(Map<String, Object> param) {
		int result = 0;
		try {
			result = orderDao.updateMerchant(param);
			List<Map<String, Object>> detailList = (List<Map<String, Object>>)param.get("detailList");
			log.debug("detailList = {}", detailList);
			result = orderDao.updateProductQuantity(detailList);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Map<String, Object> countMerchant() {
		Map<String, Object> merchantCntList = new HashMap<>();
		Map<String, Object> param = new HashMap<>();
		param.put("date", "today");
		Map<String, Object> todayCnt = orderDao.countMerchant(param);
		param.put("date", "week");
		Map<String, Object> weekCnt = orderDao.countMerchant(param);
		param.put("date", "week");
		Map<String, Object> monthCnt = orderDao.countMerchant(param);
		merchantCntList.put("todayCnt", todayCnt);
		merchantCntList.put("weekCnt", weekCnt);
		merchantCntList.put("monthCnt", monthCnt);
		
		return merchantCntList;
	}

	@Override
	public List<Shipment> selectAllShipment() {
		return orderDao.selectAllShipment();
	}

	@Override
	public List<Merchant> selectSomeMerchant(String str) {
		return orderDao.selectSomeMerchant(str);
	}

	@Override
	@Transactional(
			propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class
	)
	public int insertShipment(Map<String, Object> shipmentArr) {
		shipmentArr.put("keyword", "order_status");
		shipmentArr.put("value", "SS");
		log.debug("shipmentArr = {}", shipmentArr);
		int result = orderDao.insertShipment((List<Map<String, Object>>)shipmentArr.get("shipmentArr"));
		result = orderDao.updateMerchant(shipmentArr);
		return result;
	}

	@Override
	@Transactional(
			propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class
	)
	public int insertOrderLog(OrderLog orderLog) {
		Map<String, Object> param = new HashMap<>();
		String[] uidArr = new String[1];
		uidArr[0] = orderLog.getMerchantUid();
		param.put("keyword", "cs_status");
		param.put("value", orderLog.getCsStatus());
		param.put("target", "merchantUid");
		param.put("uidArr", uidArr);
		
		int result = orderDao.insertOrderLog(orderLog);
		result = orderDao.updateMerchant(param);
		
		return result;
	}

	@Override
	public Imp selectOneImp(String merchantUid) {
		return orderDao.selectOneImp(merchantUid);
	}

	@Override
	public List<OrderLogExt> selectOrderLogList(int memberNo) {
		return orderDao.selectOrderLogList(memberNo);
	}

	@Override
	@Transactional(
			propagation = Propagation.REQUIRED, 
			isolation = Isolation.READ_COMMITTED, 
			rollbackFor = Exception.class
	)
	public int updateOrderLog(Map<String, Object> param) {
		int result = 0;
		result = orderDao.updateOrderLog(param);
		String receiptUrl = (String)param.get("receiptUrl");
		if(receiptUrl != null) {
			result = orderDao.updateImp(receiptUrl);
		}
		result = orderDao.updateProductQuantity((List<Map<String, Object>>)param.get("detailList"));
		return result;
	}

	@Override
	public List<OrderLog> selectAllOrderLog() {
		return orderDao.selectAllOrderLog();
	}

	@Override
	public List<OrderLog> selectSomeOrderLog(String param) {
		return orderDao.selectSomeOrderLog(param);
	}

	@Override
	public Map<String, Object> selectOneOrderLog(String orderLogUid) {
		Map<String, Object> map = new HashMap<>();
		
		OrderLog orderLog = orderDao.selectOneOrderLog(orderLogUid);
		map.put("orderLog", orderLog);
		
		Imp imp = orderDao.selectOneImp(orderLog.getMerchantUid());
		map.put("imp", imp);
		
		List<Integer> detailNoList = new ArrayList<>();
		Merchant merchant = orderLog.getMerchant();
		
		for(MerchantDetail d : merchant.getMerchantDetailList()) {
			detailNoList.add(d.getDetailNo());
		}
		
		List<Product> list = orderDao.selectMerchantProductList(detailNoList);
		map.put("list", list);
		
		return map;
	}

	
	

}
