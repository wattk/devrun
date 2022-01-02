package com.kh.devrun.shop.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Wishlist implements Serializable  {


	private static final long serialVersionUID = 1L;
	
	private int wishlistNo;
	private String productCode;
	private Date regDate;


}
