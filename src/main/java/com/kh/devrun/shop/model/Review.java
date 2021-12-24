package com.kh.devrun.shop.model;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Review implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int reviewNo;
	@NonNull
	private int memberNo;
	@NonNull
	private String productCode;
	@NonNull
	private String content;
	private int likeCount;
	private Date regDate;
	private int rate;
	
	

}
