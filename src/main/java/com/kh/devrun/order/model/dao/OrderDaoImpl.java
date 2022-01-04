package com.kh.devrun.order.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.devrun.order.model.vo.Imp;
import com.kh.devrun.order.model.vo.Merchant;
import com.kh.devrun.order.model.vo.MerchantDetail;
import com.kh.devrun.order.model.vo.MerchantExt;
import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.shop.model.vo.Cart;

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
	public int deleteCart(Map<String, Object> param) {
		return session.delete("order.deleteCart", param);
	}

	@Override
	public int insertImp(Imp imp) {
		return session.insert("order.insertImp", imp);
	}

	@Override
	public Merchant selectOneMerchant(String merchantUid) {
		return session.selectOne("order.selectOneMerchant", merchantUid);
	}

	@Override
	public List<Product> selectMerchantProductList(List<Integer> detailNoList) {
		return session.selectList("order.selectMerchantProductList", detailNoList);
	}

	@Override
	public Imp selectOneImp(String merchantUid) {
		return session.selectOne("order.selectOneImp", merchantUid);
	}

	@Override
	public int selectOrderLogCnt(int memberNo) {
		return session.selectOne("order.selectOrderLogCnt", memberNo);
	}

	@Override
	public List<MerchantExt> selectCurrentOrder(int memberNo) {
		RowBounds rowBounds = new RowBounds(0, 3);
		return session.selectList("order.selectOrder", memberNo, rowBounds);
	}

	@Override
	public List<MerchantExt> selectOrderList(int memberNo) {
		return session.selectList("order.selectOrder", memberNo);
	}

	@Override
	public List<Cart> selectCartList(int memberNo) {
		return session.selectList("order.selectCartList", memberNo);
	}

	@Override
	public List<Merchant> selectAllMerchant() {
		return session.selectList("order.selectAllMerchant");
	}

	@Override
	public List<Merchant> selectMerchantProductList(Map<String, Object> param) {
		return session.selectList("order.selectMerchantList", param);
	}

	@Override
	public MerchantExt selectOneMerchantExt(String merchantUid) {
		return session.selectOne("order.selectOneMerchantExt", merchantUid);
	}

	
}
