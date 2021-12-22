package com.kh.devrun.product;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDetail implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int detailNo;
	private String productCode;
	private String optionNo;
	private String optionContent;
	private String sku; // 제품 단위
	private int quantity; // 재고
	
	
}
