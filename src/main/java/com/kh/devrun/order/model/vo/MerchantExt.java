package com.kh.devrun.order.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MerchantExt extends Merchant implements Serializable {

	/**
	 * 
	 */
	private Imp imp;
	private String productCode;
	public MerchantExt(String merchantUid, int memberNo, Date orderDate, String orderStatus, String csStatus,
			int pointValue, int productPrice, int shippingFee, int totalPrice, String shippingReq,
			List<MerchantDetail> merchantDetailList) {
		super(merchantUid, memberNo, orderDate, orderStatus, csStatus, pointValue, productPrice, shippingFee, totalPrice,
				shippingReq, merchantDetailList);
	}
	
	
}
