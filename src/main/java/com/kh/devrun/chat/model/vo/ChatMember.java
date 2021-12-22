package com.kh.devrun.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatMember implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String chatId;		// 채팅 아이디
	private int memberNo;	// 회원 번호
	private int memberNo2;	// 상대방 회원 번호
	private long lastCheck;		// 마지막 확인 시간
	private Date startDate;		// 시작일
	private Date endDate;		// 종료일
	private String status;
}
