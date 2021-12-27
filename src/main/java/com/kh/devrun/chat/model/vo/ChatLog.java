package com.kh.devrun.chat.model.vo;

import java.io.Serializable;

import com.kh.devrun.member.model.vo.Member;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ChatLog extends ChatLogEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Member member;
	private int unreadCount;
	private Type type; // MESSAGE...

	// 롬복에서 수퍼(부모)생성자를 호출하는 코드를 자동으로 못만들어준다.
	// 전체필트 생성자는 새로 만든다. 사용할 경우 대비
	public ChatLog(int no, String chatId, int memberNo, String msg, long logTime, Member member, int unreadCount) {
		super(no, chatId, memberNo, msg, logTime);
		this.member = member;
		this.unreadCount = unreadCount;
	}

	@Override
	public String toString() {
		return "ChatLog [" + super.toString() + ", member=" + member + ", unreadCount=" + unreadCount + "]";
	}


}
