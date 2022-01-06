package com.kh.devrun.common;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.shop.model.service.ShopService;
import com.kh.devrun.shop.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ShopUtils {

	@Autowired
	private ShopService shopService;
	
	/**
	 * 리뷰 비동기 처리 -다현- 
	 */
	public String getReview(List<Review> reviewList, Member member,String url) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
		StringBuilder reviewSb = new StringBuilder();
		
		int loginMemberNo = -1;
		if (member != null) {
			loginMemberNo = member.getMemberNo();			
		}
		
		
		
		if(reviewList.isEmpty()) {
			reviewSb.append("<span id=\"reviewNone\">등록된 리뷰가 없습니다.</span>");
		}

		for(Review review : reviewList) {
			StringBuilder sb = new StringBuilder();
			String proPhotoName = review.getId();
			int reviewNo = review.getReviewNo();
			
			Map<String, Object>param = new HashMap<>();
			param.put("loginMemberNo", loginMemberNo);
			param.put("reviewNo", reviewNo);
			
			int likeYesNo = shopService.didIHitLikes(param);
			log.debug("이게 1이면 좋아요를 눌렀던 것 : {}", likeYesNo);
			
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
					+ "					  <!-- Button trigger modal -->\n");
			if(member != null) {
				reviewSb.append("<button type=\"button\" class=\"btn btn-primary report-btn\" data-toggle=\"modal\" data-target=\"#exampleModal\" data-content=\""+review.getContent()+"\" data-id=\""+review.getId()+"\" data-review-no=\""+review.getReviewNo() +"\" data-member-no=\""+review.getMemberNo() +"\" >신고</button>\n");
			}
			reviewSb.append(
					  "					  <div class=\"reviewP mt-3\">\n"
					+ "					  "+review.getContent()+"\n"
					+ "					  </div>  \n"
					+ "					</div>\n"
					+ "					<!-- 리뷰 첨부파일 있을 시에만 사진 띄우기 처리 시작 -->");
			reviewSb.append("						<div class=\"reviewPhoto\">\n");
			
			//첨부파일 있을 때 
			if(review.getAttach().getReviewAttachNo() != 0) {
			reviewSb.append("						  <img src=\""+url+"/resources/upload/review/"+review.getAttach().getRenamedFilename()+ "\" alt=\"\" onclick=\"expandPic(event)\">\n");
			}
			
			//첨부파일 없을때

			reviewSb.append("						  <div  class=\"reviewLikeBtn text-center rounded mt-1\">\n"
						+ "							<i style=\"width:93px\"  data-review-no=\""+review.getReviewNo()+"\" data-member-no=\"");if(member != null) {reviewSb.append(member.getMemberNo());} 
			reviewSb.append("\""); 
				
			if(likeYesNo == 1 ) {
				reviewSb.append("data-likesyn=\"Y\" class=\"fas fa-heart likes\">");
			}else {
				reviewSb.append("data-likesyn=\"N\" class=\"far fa-heart likes\">");
			}
			
			reviewSb.append(review.getLikeCount()+"</i>\n"
						+ "						  </div>\n"
						+ "						</div>"
						+"					<!-- 리뷰 첨부파일 있을 시에만 사진 띄우기 처리 끝 -->\n");
			
			
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
	
	//쇼핑몰 페이징바 처리
	public String getPagebar(int cPage, int numPerPage, int totalContents, String url) {
		StringBuilder pagebar = new StringBuilder();

		// request 얻기 위한 코드
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();

		String extraUrl = request.getQueryString();
		log.debug("extraUrl 은? : {}", extraUrl);
		
		// 전체페이지수
		int totalPage = (int) Math.ceil((double) totalContents / numPerPage);

		log.debug("커밋을위한로그");
		
		// 페이지번호를 클릭했을때 링크
		int questionIndex = extraUrl.indexOf("&");
		log.debug("questionIndex : {}", questionIndex);
		if (questionIndex > 0) {
			String x = extraUrl.substring(0, questionIndex);
			log.debug("x 값은 : {}", x);
			extraUrl = x;
		}

		url = url + "?" + extraUrl + "&"+ "cPage="; // /spring/board/boardList.do?cPage=
		log.debug("Utils URL = {}", url);
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
}
