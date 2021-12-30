package com.kh.devrun.questionProduct.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuestionProductEx implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String questionNo;
	private int questionRefNo;
	private String title;
	private String content;
	private int memberNo;
	private char privateYn;
	private String productCode;
	private String name;
	private String thumbnail;
	private int price;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date enrollDate;
	private int qLevel;
			
}
