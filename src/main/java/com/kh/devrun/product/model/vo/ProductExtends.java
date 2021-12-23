package com.kh.devrun.product.model.vo;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductExtends {

	private String thumbnail;
	private String name;
	private String optionNo;
	private int quantity;
	private char status;
	private String childCategoryCode;
	private Date regDate;
	private int viewCount;
	
}
