package com.kh.devrun.product.model.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String productCode;
	private String name;
	private int price;
	private Date regDate;
	private String thumbnail;
	private String content;
	private int viewCount;
	private char status;
	private int orderCount; 
	
}
