package com.kh.devrun.product;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductCategory implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String childCategoryCode; // 소분류 코드
	private String productCode;
}
