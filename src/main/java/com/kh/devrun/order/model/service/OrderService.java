package com.kh.devrun.order.model.service;

import java.util.List;
import java.util.Map;

import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;

public interface OrderService {

	int insertOrder(Merchant merchant);

	int insertImp(Imp imp);

	Map<String, Object> selectOneMerchant(String merchantUid);

}
