/**
 * 
 */
package com.kh.devrun.community.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * community에 nickname이 없다.
 * nickname을 추가하고 Community를 상속하는 CommunityEntity 테이블을 생성
 *
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
// board에 ToString을 호출.
@ToString(callSuper = true)
public class CommunityEntity extends Community {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String nickname;
	private String authority;
	private int commentCount;
	
	
	public CommunityEntity(int communityNo, int memberNo, int pageCode, String title, String content,
			Date enrollDate, int viewCount, int likeCount, String thumbnail, String answerYn, String hashtag, String studyJoinYn,
			String nickname, String authority, int commentCount) {
		super(communityNo, memberNo, pageCode, title, content, enrollDate, viewCount, likeCount, thumbnail,
				answerYn, hashtag, studyJoinYn);
		this.nickname = nickname;
		this.authority = authority;
		this.commentCount = commentCount;
	}
		
}
