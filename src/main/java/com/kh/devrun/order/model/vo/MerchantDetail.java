package com.kh.devrun.order.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductDetail;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MerchantDetail extends ProductDetail implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String merchantUid;
	private int buyCount;
	public MerchantDetail(int detailNo, String productCode, String optionNo, String optionContent, String sku,
			int quantity) {
		super(detailNo, productCode, optionNo, optionContent, sku, quantity);
		// TODO Auto-generated constructor stub
	}
	
	
	
}
