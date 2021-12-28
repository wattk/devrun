package com.kh.devrun.community.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * CommunityComment에 nickname이 없다.
 * nickname을 추가하고 CommunityComment를 상속하는 CommunityEntity 테이블을 생성
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class CommunityCommentEntity extends CommunityComment {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String nickname;

	public CommunityCommentEntity(int commentNo, int memberNo, int commentRefNo, int communityNo, int commentLevel,
			String content, Date regDate, String nickname) {
		super(commentNo, memberNo, commentRefNo, communityNo, commentLevel, content, regDate);
		this.nickname = nickname;
	}
	

}
