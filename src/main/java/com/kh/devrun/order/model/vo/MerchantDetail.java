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
public class MerchantDetail implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String merchantUid;
	private int detailNo;
	private int buyCount;
	
	
}
