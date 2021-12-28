package com.kh.devrun.product.model.vo;
import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductExtends implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String name;
	private String thumbnail;
	private int price;
	private char status;
	private String content;	
	private String parentCategoryCode;
	private String childCategoryCode;
	private String childCategoryTitle;
	private Date regDate;
	private int viewCount;
	
}
