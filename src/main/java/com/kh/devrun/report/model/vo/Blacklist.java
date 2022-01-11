package com.kh.devrun.report.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Blacklist implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int blacklistNo;
	private int memberNo;
	private Date regDate;
	private Date releaseDate;
	private String note;
	private int memberNo2;

}