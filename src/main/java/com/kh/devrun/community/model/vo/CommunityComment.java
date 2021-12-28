package com.kh.devrun.community.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// @Data : getter, setter, toString을 포함한다.
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommunityComment implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int commentNo; // 댓글 번호
	private int memberNo; // 회원 번호
	private int commentRefNo; // 댓글이 속한 댓글 번호(commentNo)
	private int communityNo; // 게시물 번호
	private int commentLevel; // 댓글의 깊이 : 모댓글이면 1, 답글이면 2
	private String content; // 댓글 작성 내용
	private Date regDate; // 댓글 작성시간

}
