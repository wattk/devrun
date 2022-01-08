package com.kh.devrun.customerCenter.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L; // VO클래스 만들면 기본적으로 만들어 두는 것.
	
	private int noticeNo;				// 공지 번호
	private int memberNo;		// 작성자 번호
	private String title;		// 제목
	private String content;		// 내용
	private Date enrollDate;	// 작성일
	private int viewCount;		// 조회수
	private String noticeCode;	// 공지코드(공지 N, 자주묻는질문 - 쇼핑몰 S, 커뮤니티 C, 기타 E)
	
}
