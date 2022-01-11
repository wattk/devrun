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
</style>
<div class="about-container container">
	<div class="about-page">
		<h2 class="about-title mb-5">더 나은 개발 라이프를 위한 적절한 해결책</h2>
		<img src="${pageContext.request.contextPath }/resources/images/developer.jpg" alt="" class="w-75 img-thumbnail about-title-img d-block mx-auto"/>
		<div class="about-detail">
			<strong>데브런은 개발자 개개인의 보다 나은 개발 라이프를 지원합니다.</strong> 
			<br />
			수많은 개발자들이 다수의 편의를 위해 일에 매진하지만, 개개인의 편의에 대해서는 잠시 잊어버리곤 합니다.
			<br />
			단순히 개발자를 위한다는 말보다는 진심으로 개발자에게 필요한 물품이 무엇인지, 개발자에게 필요한 지식은 무엇인지 고민합니다.
			<br />
			당신의 더 나은 개발 라이프를 위해 데브런이 함께 하겠습니다.
		</div>
		<div class="about-detail">
			<strong>Run Productive Lives</strong>
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
			<strong>Learn Development Better</strong>
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
                <div class="testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonial-ico">
                  <span class="ion-ios-quote"></span>
                </div>
                <div class="testimonials-content">
                  <p class="testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box">
                  <img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="testimonial-avatar">
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
                <div class="testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonial-ico">
                  <span class="ion-ios-quote"></span>
                </div>
                <div class="testimonials-content">
                  <p class="testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box">
                  <img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="testimonial-avatar">
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
                <div class="testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonial-ico">
                  <span class="ion-ios-quote"></span>
                </div>
                <div class="testimonials-content">
                  <p class="testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box">
                  <img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="testimonial-avatar">
                  <h5 class="testimonial-author">김다현</h5>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="carousel-item-a">
          <div class="testimonials-box">
            <div class="row">
              <div class="col-sm-12 col-md-6">
                <div class="testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonial-ico">
                  <span class="ion-ios-quote"></span>
                </div>
                <div class="testimonials-content">
                  <p class="testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box">
                  <img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="testimonial-avatar">
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
                <div class="testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonial-ico">
                  <span class="ion-ios-quote"></span>
                </div>
                <div class="testimonials-content">
                  <p class="testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box">
                  <img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="testimonial-avatar">
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
                <div class="testimonial-img">
                  <img src="${pageContext.request.contextPath }/resources/images/650x450.jpg" alt="" class="img-fluid">
                </div>
              </div>
              <div class="col-sm-12 col-md-6">
                <div class="testimonial-ico">
                  <span class="ion-ios-quote"></span>
                </div>
                <div class="testimonials-content">
                  <p class="testimonial-text">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, cupiditate ea nam praesentium
                    debitis hic ber quibusdam
                    voluptatibus officia expedita corpori.
                  </p>
                </div>
                <div class="testimonial-author-box">
                  <img src="${pageContext.request.contextPath }/resources/images/80x80.jpg" alt="" class="testimonial-avatar">
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
