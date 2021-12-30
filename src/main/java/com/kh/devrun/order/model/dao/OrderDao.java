package com.kh.devrun.order.model.dao;

import java.util.List;

import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;
import com.kh.devrun.product.model.vo.Product;

public interface OrderDao {

	int insertOrder(Merchant order);

	int insertOrderDetail(List<MerchantDetail> list);

	int insertImp(Imp imp);

	Merchant selectOneMerchant(String merchantUid);

	List<Product> selectMerchantProductList(List<Integer> detailNoList);

	Imp selectOneImp(String merchantUid);

}
