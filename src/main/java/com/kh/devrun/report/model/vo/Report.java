package com.kh.devrun.report.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int reportNo;
	private String reasonCate;
	private String reportRootCate;
	private int memberNo;
	private String id;
	private String targetPkNo;
	private String reportContent;
	private String sideNote;
	private String status;
	private Date regDate;
	private int memberNo2;
	private Date confirmDate;
	
	
	
	

}
