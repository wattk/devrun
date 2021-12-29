package com.kh.devrun.product.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product extends ProductEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductDetail productDetail;

	public Product(String productCode, String name, int price, Date regDate, String thumbnail, String content,
			int viewCount, char status, int orderCount) {
		super(productCode, name, price, regDate, thumbnail, content, viewCount, status, orderCount);
	}
	
	
}
