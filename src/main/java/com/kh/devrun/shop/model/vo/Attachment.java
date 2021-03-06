package com.kh.devrun.shop.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attachment implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int reviewAttachNo;
	private int reviewNo;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	

}
