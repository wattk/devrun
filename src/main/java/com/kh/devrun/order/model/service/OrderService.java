package com.kh.devrun.order.model.service;

import java.util.List;

import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;

public interface OrderService {

	int insertDirectOrder(Merchant order, List<MerchantDetail> list);

	int insertImp(Imp imp);

}
