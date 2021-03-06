package com.kh.devrun.community.model.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// @Data : getter, setter, toString을 포함한다.
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Community implements Serializable {

	private static final long serialVersionUID = 1L;

	private int communityNo;
	private int memberNo;
	private int pageCode;
	private String title;
	private String content;
	private Date enrollDate;
	private int viewCount;
	private int likeCount;
	private String answerYn;
	private String hashtag;
	private String thumbnail;
	private String studyJoinYn;

}
