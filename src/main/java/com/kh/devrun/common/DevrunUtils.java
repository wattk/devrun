package com.kh.devrun.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.product.model.vo.ProductEntity;
import com.kh.devrun.shop.model.vo.Review;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class DevrunUtils {

	
	/**
	 * 페이징바 메소드
	 * 
	 * @param cPage
	 * @param numPerPage
	 * @param totalContents
	 * @param url
	 * @return
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContents, String url) {
		StringBuilder pagebar = new StringBuilder();

		// 전체페이지수
		int totalPage = (int) Math.ceil((double) totalContents / numPerPage);

		// 페이지번호를 클릭했을때 링크
		String delimeter = url.contains("?") ? "&" : "?";
		url = url + delimeter + "cPage="; // /spring/board/boardList.do?cPage=

		// 페이지바크기
		int pagebarSize = 5;

		/*
		 * 1 2 3 4 5 >>
		 * 
		 * << 6 7 8 9 10 >>
		 * 
		 * << 11 12
		 * 
		 * pageStart : 시작하는 pageNo - cPage와 pagebarSize에 의해 결정
		 */
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;

		int pageNo = pageStart;

		pagebar.append("<nav class=\"pagebar\" aria-label=\"Page navigation example\">\n"
				+ "		  <ul class=\"pagination justify-content-center\">\n");

		// 1.이전
		if (pageNo == 1) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\">\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append(
					"<li class=\"page-item \">\r\n" + "		      <a class=\"page-link\" href=\"javascript:paging("
							+ (pageNo - 1) + ")\" aria-label=\"Previous\" >\r\n"
							+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
							+ "		        <span class=\"sr-only\">Previous</span>\r\n" + "		      </a>\r\n"
							+ "		    </li>\n");
		}

		// 2.pageNo
		while (pageNo <= pageEnd && pageNo <= totalPage) {
			if (pageNo == cPage) {
				// 현재페이지인 경우 링크 제공안함.
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo
						+ "<span class=\"sr-only\">(current)</span></a></li>\n");
			} else {
				// 현재페이지가 아닌 경우 링크를 제공.
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo
						+ ")\">" + pageNo + "</a></li>\n");
			}

			pageNo++;
		}

		// 3.다음
		if (pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		} else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:paging(" + pageNo
					+ ")\" aria-label=\"Next\">\r\n" + "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n" + "		      </a>\r\n"
					+ "		    </li>\n");
		}

		pagebar.append("		  </ul>\r\n" + "		</nav>\r\n" + "		<script>\r\n"
				+ "		const paging = (cPage) => {\r\n" + "			location.href = '" + url + "' + cPage;\r\n"
				+ "		}\r\n" + "		</script>\n");

		return pagebar.toString();
	}

	public static String getRenamedFilename(String originalFilename) {
		// 확장자 가져오기
		String ext = "";
		int dot = originalFilename.lastIndexOf(".");
		if (dot > -1)
			ext = originalFilename.substring(dot); // .txt .jpg .png

		// 형식지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000"); // 30 -> 030

		// 새파일명
		return sdf.format(new Date()) + df.format(Math.random() * 999) + ext;
	}

	/**
	 * chat_dfslk23lskd341d
	 * 
	 * @return
	 */
	public static String getRandomNo() {
		Random rnd = new Random();
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < 15; i++) {
			if (rnd.nextBoolean()) {
				// 영문자 : 대문자 65~90, 소문자 97~122
				boolean isUpperCase = rnd.nextBoolean();
				char ch = (char) ((isUpperCase ? 65 : 97) + rnd.nextInt(26));
				sb.append(ch);
			} else {
				// 숫자
				sb.append(rnd.nextInt(10));
			}
		}

		return sb.toString();
	}

	/**
	 * chat_dfslk23lskd341d
	 * 
	 * @return
	 */
	public static String getRandomChatId() {
		Random rnd = new Random();
		StringBuffer sb = new StringBuffer();
		sb.append("chat_");
		for (int i = 0; i < 15; i++) {
			if (rnd.nextBoolean()) {
				// 영문자 : 대문자 65~90, 소문자 97~122
				boolean isUpperCase = rnd.nextBoolean();
				char ch = (char) ((isUpperCase ? 65 : 97) + rnd.nextInt(26));
				sb.append(ch);
			} else {
				// 숫자
				sb.append(rnd.nextInt(10)); // 0 ~ 9 사이의 숫자 생성되어 추가된다.
			}
		}

		return sb.toString();
	}

	/**
	 * 상품 정렬 후 다시 띄우기
	 * 
	 * @param productList
	 * @param url
	 * @returnL
	 */
	public static String getProductList(List<ProductEntity> productList, String url) {
		DecimalFormat fmt = new DecimalFormat("###,###");
		StringBuilder sb = new StringBuilder();

		for (ProductEntity product : productList) {
			sb.append("<div class=\"card-box-d col-md-3 p-5\">\n"
					+ "<div class=\"card-img-d shop-item-img position-relative\">\r\n" + "<img src=\"" + url
					+ "/resources/upload/product/" + product.getThumbnail()
					+ "\" alt=\"\" class=\"img-d img-fluid\">\r\n"
					+ "<i class=\"shop-like-icon fas fa-heart position-absolute\"></i>\r\n" + "</div>\r\n"
					+ "<a href=\"" + url + "/shop/itemDetail/" + product.getProductCode() + "\">\r\n" + "<div>\r\n"
					+ "<p class=\"m-0\">" + product.getName() + "</p>\r\n" + "<strong>&#8361;"
					+ fmt.format(product.getPrice()) + "</strong>\r\n" + "</div>\r\n" + "</a>" + "</div>");
		}

		return sb.toString();

	}

	/**
	 * 게시글 읽음 여부 확인
	 */
	public static boolean hasRead(HttpServletRequest request, HttpServletResponse response, String code, String param) {

		Cookie[] cookies = request.getCookies();
		boolean hasRead = false;
		String boardValue = "";

		if (cookies != null) {
			for (Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();

				if (param.equals(name)) {
					boardValue = value;

					if (value.contains("|" + code + "|")) {
						hasRead = true;
					}
					break;
				}
			}
		}

		if (!hasRead) {
			Cookie cookie = new Cookie(param, boardValue + "|" + code + "|");// 그냥 숫자만 쓰면 혼동이 올 수 있으므로 no에 대한 padding문자
																				// 추가
			cookie.setMaxAge(365 * 24 * 60 * 60);
			if ("promotion".equals(param))
				cookie.setPath(request.getContextPath() + "/shop/promotionDetail.do");// 해당 경로 요청 시에만 쿠키 전송
			response.addCookie(cookie);
		}

		return hasRead;
	}

	/**
	 * 리뷰 비동기 처리
	 */
	public static String getReview(List<Review> reviewList, Member member,String url) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
		StringBuilder reviewSb = new StringBuilder();
		log.debug("비웠나여? : {}",reviewList.isEmpty());
		
		if(reviewList.isEmpty()) {
			reviewSb.append("<span id=\"reviewNone\">등록된 리뷰가 없습니다.</span>");
		}

		for(Review review : reviewList) {
			StringBuilder sb = new StringBuilder();
			String proPhotoName = review.getId();
			
			reviewSb.append("			<!--리뷰시작-->\n"
					+ "				<div class=\"aReviewDiv forFont\">\n"
					+ "				  <div class=\"shop-review row\">\n"
					+ "					<div class=\"reviewProfile\">\n"
					+ "					  <img class=\"rounded-circle mt-3\" src=\""+url+"/resources/upload/profilePhoto/"+ proPhotoName +".png" +"\" alt=\"\">\n"
					+ "					</div> \n"
					+ "					<div class=\"reviewContent ml-3\">");
			
			for(int i=0; i<review.getRate(); i++) {
				sb.append("<i class=\"fas fa-star\"></i>");
			}
			reviewSb.append(sb.toString());
			reviewSb.append("					  <br><span>"+review.getId() +"</span> | <span> "+sdf.format(review.getRegDate())+"</span> | \n"
					+ "					  <!-- Button trigger modal -->\n"
					+ "					  <button type=\"button\" class=\"btn btn-primary report-btn\" data-toggle=\"modal\" data-target=\"#exampleModal\">신고</button>\n"
					+ "					  <div class=\"reviewP mt-3\">\n"
					+ "					  "+review.getContent()+"\n"
					+ "					  </div>  \n"
					+ "					</div>\n"
					+ "					<!-- 리뷰 첨부파일 있을 시에만 사진 띄우기 처리 시작 -->");
			if(review.getAttach().getReviewAttachNo() != 0) {
				reviewSb.append("						<div class=\"reviewPhoto\">\n"
						+ "						  <img src=\""+url+"/resources/upload/review/"+review.getAttach().getRenamedFilename()+ "\" alt=\"\" onclick=\"expandPic(event)\">\n"
						+ "						  <div  class=\"reviewLikeBtn text-center border border-success rounded mt-1\">\n"
						+ "							<i class=\"far fa-heart\">3</i>\n"
						+ "						  </div>\n"
						+ "						</div>");
			}
			if(review.getAttach().getReviewAttachNo() < 1) {
				reviewSb.append("						<div class=\"reviewPhoto\">\n"
						+ "						  <div  class=\"reviewLikeBtn text-center border border-success rounded mt-1\">\n"
						+ "							<i style=\"width:100px\" class=\"far fa-heart\">3</i>\n"
						+ "						  </div>\n"
						+ "						</div>"
						+"					<!-- 리뷰 첨부파일 있을 시에만 사진 띄우기 처리 끝 -->\n");
			}
			if(member !=null) {
				if(review.getId().equals(member.getId())) {
					reviewSb.append("					<!-- 삭제버튼 시작 -->\n"
							+ "						<button type=\"button\" class=\"btn btn-danger reviewDelBtn\" value=\""+review.getReviewNo()+"\">삭제</button>");
				}				
			}
			reviewSb.append("				  </div>\n"
					+ "				</div>");
			

		}
	
		return reviewSb.toString();
	}

}
