package com.kh.devrun.product.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductEx extends Product implements Serializable {

	private static final long serialVersionUID = 1L;

	private String childCategoryCode;
	private String childCategoryTitle;
	private String parentCategoryCode;
	private String parentCategoryTitle;

	public ProductEx(String productCode, String name, int price, Date regDate, String thumbnail, String content,
			int viewCount, char status, int orderCount, List<ProductDetail> productDetailList) {
		super(productCode, name, price, regDate, thumbnail, content, viewCount, status, orderCount, productDetailList);
	}

	@Override
	public String toString() {
		return "ProductEx [childCategoryCode=" + childCategoryCode + ", childCategoryTitle=" + childCategoryTitle
				+ ", parentCategoryCode=" + parentCategoryCode + ", parentCategoryTitle=" + parentCategoryTitle
				+ ", toString()=" + super.toString() + "]";
	}

	

}
