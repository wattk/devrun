package com.kh.devrun.order.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;
import com.kh.devrun.order.model.vo.MerchantExt;
import com.kh.devrun.order.model.vo.OrderLog;
import com.kh.devrun.order.model.vo.Shipment;
import com.kh.devrun.shop.model.vo.Cart;

public interface OrderService {

	int insertOrder(Merchant merchant);

	int insertImp(Imp imp);

	Map<String, Object> selectOneMerchant(String merchantUid);

	Map<String, Object> selectMyShopping(int memberNo);

	List<MerchantExt> selectOrderList(int memberNo);

	List<Cart> selectCartList(int memberNo);

	List<Merchant> selectAllMerchant();

	List<Merchant> selectMerchantList(Map<String, Object> param);

	int updateMerchant(Map<String, Object> param);

	Map<String, Object> countMerchant();

	List<Shipment> selectAllShipment();

	List<Merchant> selectSomeMerchant(String string);

	int insertShipment(Map<String, Object> shipmentArr);

	int insertOrderLog(OrderLog orderLog);

	Imp selectOneImp(String merchantUid);


}
