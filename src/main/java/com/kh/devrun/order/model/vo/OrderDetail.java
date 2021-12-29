package com.kh.devrun.order.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail implements Serializable {

	private String orderCode;
	private int detailNo;
	private int buyCount;
	
	
}
