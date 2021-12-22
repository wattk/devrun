package com.kh.devrun.chat.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatLogEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L; // VO클래스 만들면 기본적으로 만들어 두는 것.
	
	private int no;				// 채팅 로그 번호
	private String chatId;		// 채팅 아이디
	private int memberNo;		// 회원 번호
	private String msg;			// 메세지
	private long logTime;		// message 작성시각 unix time으로 관리
}
