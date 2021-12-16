package com.kh.devrun.member.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	private int memberNo;
	private String id;
	private String name;
	private String nickname;
	private String password;
	private Date birthday;
	private String email;
	private int phone;
	private int point;

}
