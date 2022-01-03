package com.kh.devrun.shop.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.kh.devrun.product.model.vo.ProductDetail;
import com.kh.devrun.product.model.vo.ProductEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int cartNo;
	private int memberNo;
	private int detailNo;
	private int amount;
	private Date regDate;
	
	private ProductEntity product;
	private ProductDetail productDetail;

}
