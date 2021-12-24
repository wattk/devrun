package com.kh.devrun.shop.model;

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
@ToString(callSuper = true)
public class ReviewAttachment implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int ReviewAttachmentNo;
	private int reviewNo;
	private String originalFilenname;
	private String renamenFilename;
	private Date regDate;
	

}
