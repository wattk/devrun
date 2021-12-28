package com.kh.devrun.promotion.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.kh.devrun.product.model.vo.Product;
import com.kh.devrun.product.model.vo.ProductDetail;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductPromotion extends Product implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String childCategoryCode;
	private String childCategoryTitle;
	
	public ProductPromotion(String productCode, String name, int price, Date regDate, String thumbnail, String content,
			int viewCount, char status, int orderCount, List<ProductDetail> productDetailList) {
		super(productCode, name, price, regDate, thumbnail, content, viewCount, status, orderCount, productDetailList);
	}
	
	

}
