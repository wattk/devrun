package com.kh.devrun.order.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderLog implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int orderLogNo;
	private String reasonCode;
	private String merchantUid;
	private int prevOptionNo;
	private int currOptionNo;
	private String csStatus;
	private Date reqDate;
	private Date processDate;
	private Date endDate;
	private String costStatus;
	private int cost;
	private String reasonDetail;
	private int memberNo;
}
