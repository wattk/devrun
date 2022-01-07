package com.kh.devrun.customerCenter.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Notice extends NoticeEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L; // VO클래스 만들면 기본적으로 만들어 두는 것.
	
	private String nickname;	// 닉네임

	public Notice(int no, int memberNo, String title, String content, Date enrollDate, int viewCount, String noticeCode,
			String nickname) {
		super(no, memberNo, title, content, enrollDate, viewCount, noticeCode);
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "Notice [" + super.toString() + ", nickname=" + nickname + "]";
	}

}
