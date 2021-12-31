package com.kh.devrun.address.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Address implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int addressNo;
	private int memberNo;
	private String postalCode;
	private String address1;
	private String address2;
	private String mainYn;
	private String title;
	private String addressee;
	private String phone;
}