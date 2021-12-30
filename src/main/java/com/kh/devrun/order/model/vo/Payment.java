package com.kh.devrun.order.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int paymentNo;
	private String pg;
	private String payWay;
	private String orderCode;
	private int payPrice;
	private String email;
	private String name;
	private String phone;
	private String address;
	private String postalCode;

}
