package com.kh.devrun.common.mail;

import org.apache.commons.mail.HtmlEmail;

public class MailUtils {
	
	// 임시 비밀번호 메일 전송
	public static void mailSendWithPassword(String id, String rawPassword, String email) throws Exception {
		
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";	// SMTP 서버명
		String hostSMTPid = "devrunlearn";	// gmail 아이디
		String hostSMTPpwd = "kkmpyc!234";	// gmail 비밀번호
		
		// 보내는 사람 email, 제목, 내용 (받는 사람 이메일에 표시됨)
		String fromEmail = "devrunlearn@gmail.com";	
		String fromName = "DevRun";
		String subject = "";	// 메일 제목
		String msg = "";		// 메일 내용
		
		// 받는 사람
		String toName = id;
		
		subject = "[DevRun] 임시 비밀번호 발급 안내";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += id + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += rawPassword + "</p></div>";
		
		// email 전송
		String mailRecipient = email;
		try {
			// 객체 선언
			HtmlEmail mail = new HtmlEmail();
			mail.setDebug(true);
			mail.setCharset(charSet);
			mail.setSSL(true);
			mail.setHostName(hostSMTP);
			mail.setSmtpPort(465); // SMTP 포트 번호 // 네이버 이용시 587

			mail.setAuthentication(hostSMTPid, hostSMTPpwd);
			mail.setTLS(true);
			mail.addTo(mailRecipient, toName, charSet);
			mail.setFrom(fromEmail, fromName, charSet);
			mail.setSubject(subject);
			mail.setHtmlMsg(msg);
			mail.send();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
