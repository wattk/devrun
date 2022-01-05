package com.kh.devrun.order.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Shipment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int shipmentNo;
	private String merchantUid;
	private String trackingNo;
	private int orderLogNo;
	private Date shipmentDate;
}
