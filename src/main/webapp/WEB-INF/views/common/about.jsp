<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="about" name="title"/>
</jsp:include>
<style>
.about-container{
	padding-top : 5%;	
}
.about-detail{
	width : 50%;
	margin : 5% 0 5% 10%;
}
.about-title{
	margin-left : 10%;
	font-weight : 700;
}
.about-text{
	word-break : keep-all;
}
.about-thumbnail {
	width : 80px;
	height : 80px;
	overflow : hidden;
	/* border : 1px solid rgba(0,0,0,.125); */
}
.about-main-img{
	overflow : hidden;
	width : 525px;
	height : 363.45px;
	border-radius : 10px;
	border : 1px solid rgba(0,0,0,.125);
}
.about-thumbnail img, .about-main-img img{
	width : 100%;
	height : 100%;
	object-fit : cover;
}

</style>
<div class="about-container container">
	<div class="about-page">
		<h2 class="about-title mb-5">더 나은 개발 라이프를 위한 적절한 해결책</h2>
		<img src="${pageContext.request.contextPath }/resources/images/developer.jpg" alt="" class="w-75 img-thumbnail about-title-img d-block mx-auto"/>
		<div class="about-detail">
			<h3>데브런은 개발자 개개인의 보다 나은 개발 라이프를 지원합니다.</h3> 
			<br />
			수많은 개발자들이 다수의 편의를 위해 일에 매진하지만, 개개인의 편의에 대해서는 잠시 잊어버리곤 합니다.
			<br />
			단순히 개발자를 위한다는 말보다는 진심으로 개발자에게 필요한 물품이 무엇인지, 개발자에게 필요한 지식은 무엇인지 고민합니다.
			<br />
			당신의 더 나은 개발 라이프를 위해 데브런이 함께 하겠습니다.
		</div>
		<div class="about-detail">
			<h3>Run Productive Lives</h3>
			<br />
			<strong>당신의 생산성 높은 개발 환경 조성을 돕는 개발자 전문 쇼핑몰</strong>
			<br />
			개발자는 그 자체로 생산적인 존재입니다.
			<br />
			데브런은 개발자의 생산성에 편안함을 더하고 싶습니다.
			<br />
			개발자들이 쓰는 제품, 개발자들이 선호하는 제품을 한 데 모았습니다.
		</div>
		<div class="about-detail">
			<h3>Learn Development Better</h3>
			<br />
			<strong>당신의 지식을 함께 공유하고 성장하는 개발자 전문 커뮤니티</strong>
			<br />
			개발자에게 오픈 소스는 뗄레야 뗄 수 없는 관계입니다.
			<br />
			데브런이 개발자 간의 커뮤니케이션을 돕겠습니다.
			<br />
			같이 가치를 이해하고, 공유하는 사람들과 의견을 나누어 보세요.
			
		</div>
		
	</div>
	<section class="section-testimonials section-t8 nav-arrow-a">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="title-wrap d-flex justify-content-between">
            <div class="title-box">
              <h2 class="">Created By CodeName200</h2>
            </div>
          </div>
        </div>
      </div>
      <div id="testimonial-carousel" class="owl-carousel owl-arrow">
        <div class="carousel-item-a">
          <div class="testimonials-box">
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="about-main-img testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/about/hyejin1.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">

                 <div class="testimonial-ico pb-3">
                  <span class="ion-ios-quote"></span>
                </div>
           
 				<div class="testimonials-content">
                  <p class="about-text testimonial-text">
                    천방지축 어리둥절 빙글빙글 돌아가는 코드네임200의 하루 속,
                    유치원 선생님을 맡고 있는 권혜진입니다.
                  </p>
                </div>
                <div class="testimonial-author-box d-flex align-items-center">
                  <div class="about-thumbnail testimonial-avatar ">
                  	<img src="${pageContext.request.contextPath }/resources/images/about/hyejin2.png" alt="" class="">
                  </div>
                  <h5 class="testimonial-author">권혜진</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item-a">
          <div class="testimonials-box">
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="about-main-img testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/about/jiyeong1.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonials-content">
                  <p class="about-text testimonial-text">
                    같이 일하고 싶은 개발자가 되고 싶은 염지영 입니다 : )
                    <br />
					세미 때 웹소켓을 이용해 보고 싶었는데 
					파이널에 구현할 수 있게 되어 뿌듯하네요!
					많은 것을 배우고 느끼게 된 7개월이 정말 값져서 
					끝날 때가 되니 많이 아쉽지만 여러분들 끝이 아니라고 믿어요! 
					신입 개발자로 다시 만납시다!
					<br />
					자정에 퇴근해도 일찍 퇴근하는 것만 같은 
					쉽지 않았던 우리의 작업들 속에서
					웃으면서 할 수 있었던 건 여러분들 덕분이었어요!
                  </p>
                </div>
                <div class="testimonial-author-box d-flex align-items-center">
                  <div class="about-thumbnail  testimonial-avatar">
                  	<img src="${pageContext.request.contextPath }/resources/images/about/jiyeong2.png" alt="" class="">
                  </div>
                  <h5 class="testimonial-author">염지영</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item-a">
          <div class="testimonials-box">
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="about-main-img testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonials-content">
                  <p class="about-text testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box d-flex align-items-center">
                  <div class="about-thumbnail  testimonial-avatar">
                  	<img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="">
                  </div>
                  <h5 class="testimonial-author">김다현</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item-a">
          <div class="testimonials-box">
            <div class="row align-items-center">
              <div class="col-sm-12 col-md-6">
                <div class="about-main-img testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/about/taeyoung1.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonials-content">
                  <p class="about-text testimonial-text">
                    안녕하세요. back-end 개발자를 꿈꾸는 있는 민태영입니다.

					항상 마음속 한 켠에 코딩에 대한 호기심이 있었지만 전공을 하지 않았다는 이유로
					
					용기가 나지 않아 시작조차 못하고 있었지만 학원에 들어오고 지난 7개월 동안
					
					정말 많은 것을 배우고 가서 의미가 깊습니다! 그리고 파이널 프로젝트를 진행 하면서
					
					그동안 배웠던 거의 모든 것들을 다시 한번 공부하는 계기가 되었고, 많이 힘들기도 했지만
					
					직접 서비스를 구현한다는 재미를 느낄 수 있는 기회가 되었습니다.
					
					DEV-RUN 팀원분들 정말 고생하셨고 감사합니다~!
                  </p>
                </div>
                <div class="testimonial-author-box d-flex align-items-center">
                  <div class="about-thumbnail testimonial-avatar">
                  	<img src="${pageContext.request.contextPath }/resources/images/about/taeyoung2.jpg" alt="" class="">
                  </div>
                  <h5 class="testimonial-author">민태영</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item-a">
          <div class="testimonials-box">
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="about-main-img testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/about/jongseo1.png" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
              	<div class="testimonial-ico pb-3">
                  <span class="ion-ios-quote"></span>
                </div>
                <div class="testimonials-content">
                  <p class="about-text testimonial-text">
                    내가 가는 이길이 어디로 가는지 어디로 날 데려가는지 그곳은 어딘지 알 수 없지만 개발자라는 꿈이라는 터널속을 유랑하는 방랑자 박종서입니다.
                  </p>
                </div>
                <div class="testimonial-author-box d-flex align-items-center">
                  <div class="about-thumbnail testimonial-avatar">
                  	<img src="${pageContext.request.contextPath }/resources/images/about/jongseo2.jpg" alt="" class="">
                  </div>
                  <h5 class="testimonial-author">박종서</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item-a">
          <div class="testimonials-box">
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="about-main-img testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonials-content">
                  <p class="about-text testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box d-flex align-items-center">
                  <div class="about-thumbnail testimonial-avatar">
                  	<img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="">
                  </div>
                  <h5 class="testimonial-author">최지원</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
