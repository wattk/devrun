package com.kh.devrun.questionProductCus.model.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.kh.devrun.questionProduct.model.vo.QuestionProduct;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuestionProductId extends QuestionProduct {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int questionNo;
	private int questionRefNo;
	private int memberNo;
	private String id;
	private String productCode;
	private String title;
	private String content;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date enrollDate;
	private char privateYn;
	private int questionLevel;
	

}
