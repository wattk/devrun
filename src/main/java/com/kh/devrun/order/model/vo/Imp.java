package com.kh.devrun.order.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Imp implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String impUid;
	private String merchantUid;
	private String pgProvider;
	private String name;
	private String payMethod;
	private int amount;
	private String buyerAddr;
	private String buyerEmail;
	private String buyerName;
	private String buyerPostcode;
	private String buyerPhone;
	private boolean isCanceled;
	private String receiptUrl;

}
