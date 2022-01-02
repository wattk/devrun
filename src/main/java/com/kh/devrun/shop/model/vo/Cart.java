package com.kh.devrun.shop.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.kh.devrun.product.model.vo.Product;

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
	
	private int memberNo;
	private int cartNo;
	private int detailNo;
	private int amount;
	private int price;
	private Date regDate;
	
	private Product product;

}
