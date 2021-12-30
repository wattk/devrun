package com.kh.devrun.order.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MerchantDetail implements Serializable {

	private String merchantUid;
	private int detailNo;
	private int buyCount;
	
	
}
