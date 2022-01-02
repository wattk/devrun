package com.kh.devrun.questionProduct.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuestionProduct implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int questionNo;
	private int questionRefNo;
	private int memberNo;
	private String productCode;
	private String title;
	private String content;
	private Date enrollDate;
	private char privateYn;
	private int questionLevel;

	
}
