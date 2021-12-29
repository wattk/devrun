package com.kh.devrun.promotion.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.kh.devrun.product.model.vo.ProductEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Promotion implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String promotionCode;
	private String name;
	private Date startDate;
	private Date endDate;
	private String sideNote;
	private boolean isRegular;
	private String banner;
	private int viewCount;
	private int memberNo;
	private String nickname;
	private Date enrollDate;
	
	private List<ProductEntity> productList;

}
