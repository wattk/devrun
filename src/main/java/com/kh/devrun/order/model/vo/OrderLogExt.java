package com.kh.devrun.order.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderLogExt extends OrderLog implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Imp imp;
	private String thumbnail;
	public OrderLogExt(String orderLogUid, String reasonCode, String merchantUid, String prevDetailNo,
			String currDetailNo, String csStatus, Date reqDate, Date processDate, Date endDate, String costStatus,
			int cost, String reasonDetail, int memberNo, List<MerchantDetail> merchantDetailList) {
		super(orderLogUid, reasonCode, merchantUid, prevDetailNo, currDetailNo, csStatus, reqDate, processDate, endDate,
				costStatus, cost, reasonDetail, memberNo, merchantDetailList);
	}
	
	
}
