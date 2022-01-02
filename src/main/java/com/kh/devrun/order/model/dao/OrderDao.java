package com.kh.devrun.order.model.dao;

import java.util.List;

import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;
import com.kh.devrun.order.model.vo.MerchantExt;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.shop.model.vo.Cart;

public interface OrderDao {

	int insertOrder(Merchant order);

	int insertOrderDetail(List<MerchantDetail> list);

	int insertImp(Imp imp);

	Merchant selectOneMerchant(String merchantUid);

	List<Product> selectMerchantProductList(List<Integer> detailNoList);

	Imp selectOneImp(String merchantUid);

	int selectOrderLogCnt(int memberNo);

	List<MerchantExt> selectCurrentOrder(int memberNo);

	List<MerchantExt> selectOrderList(int memberNo);

	List<Cart> selectCartList(int memberNo);

}
