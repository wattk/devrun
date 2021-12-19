package com.kh.devrun.mypage.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int messageNo;
	private int roomNo;
	private int memberNo1;
	private int memberNo2;
	private Date sendDate;
	private String readChk;
	private String messageContent;

}
