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
public class Order implements Serializable {

	private String orderCode;
	private int memberNo;
	private Date orderDate;
	private String orderStatus;
	private String csStatus;
	private int pointValue;
	private int productPrice;
	private int shippingFee;
	private int totalPrice;
	private String shippingReq;
	
	private List<OrderDetail> orderDetailList;
}
