<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name=""/>
</jsp:include>
<title>ShopMainPage</title>

<style>

 /*실시간 순위 시작*/
#content {
    margin: 20px;
    padding: 10px;
    background: #393;
}

#rank-list a {
    color: #FFF;
    text-decoration: none;
}

#rank-list a:hover {
    text-decoration: underline;
}

#rank-list {
    overflow: hidden;
    width: 160px;
    height: 20px;
    margin: 0;
}

#rank-list dt {
    display: none;
}

#rank-list dd {
    position: relative;
    margin: 0;
}

#rank-list ol {
    position: absolute;
    top: 0;
    left: 0;
    margin: 0;
    padding: 0;
    list-style-type: none;
}

#rank-list li {
    height: 20px;
    line-height: 20px;
}
/*실시간 순위 끝*/

#shopSerachDiv input {
    width: 500px;
}
#sideMenuBtn{
    padding-left: 15px;
    padding-top: 10px;
}
#shopSerachDiv, #shopMainEventBtnDiv{
    margin: auto 0 ;
}
#shopMainEventBtnDiv{
    margin-left: 100px;
}
#shopMainEventBtn{
    color: white;
    font-weight: bold;
}
#sideMenuBtn:hover{
    cursor: pointer;
}
#sideMenuBtn {
    border-radius: 30;
}
#iconBoxDiv{
    margin-left: 50px;
    border: solid;
    width: 95%;
}
.icon {
    width: 70px;
    height: 70px;
    margin: auto 80px;
}
#shopIconCategoryDiv{
    margin: 50px 0;
}

</style>

<body>
    <div id="shopMainOuter">
        <div class = "row " id="shopHeaderBarDiv" style="background-color: #f8f9fa">
            <div class = "col-md-1" id="sideMenuBtnDiv">           
                <img id="sideMenuBtn" src="https://i.ibb.co/zFxp8tw/3.png" alt="" >
            </div>
            <div class = "col-md-3" id="shopTop-10Div">
                <div id="content">
                    <dl id="rank-list">
                        <dt>실시간 급상승 검색어</dt>
                        <dd>
                            <ol>
                                <li><a href="#">1 순위</a></li>
                                <li><a href="#">2 순위</a></li>
                                <li><a href="#">3 순위</a></li>
                                <li><a href="#">4 순위</a></li>
                                <li><a href="#">5 순위</a></li>
                                <li><a href="#">6 순위</a></li>
                                <li><a href="#">7 순위</a></li>
                                <li><a href="#">8 순위</a></li>
                                <li><a href="#">9 순위</a></li>
                                <li><a href="#">10 순위</a></li>
                            </ol>
                        </dd>
                    </dl>
                </div>
            </div>
            <div id="shopSerachDiv">
                <nav class="navbar navbar-light bg-light">
                    <form class="form-inline"> 
                        <!-- 쇼핑몰 검색도 카테고리 나눌 건가?
                        <select class="form-select" aria-label="Default select example">
                            <option selected>Open this select menu</option>
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                          </select> -->
                      <input class="form-control mr-sm-2" type="search" placeholder="검색어를 입력하세요" aria-label="Search">
                      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                  </nav>
            </div>
            <div id="shopMainEventBtnDiv">
                <button type="button" class="btn btn-warning" id= "shopMainEventBtn" style="width: 200px">이벤트보러가기</button>
            </div>
        </div>
 
        <!--구분-->

        <div id="shopitemsDiv">
            <div id="shopEventSlideDiv">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img class="d-block w-100" src="https://i.ibb.co/cDFYP1c/image.jpg" alt="First slide">
                      </div>
                      <div class="carousel-item">
                        <img class="d-block w-100" src="https://i.ibb.co/cDFYP1c/image.jpg" alt="Second slide">
                      </div>
                      <div class="carousel-item">
                        <img class="d-block w-100" src="https://i.ibb.co/cDFYP1c/image.jpg" alt="Third slide">
                      </div>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                      <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                      <span class="carousel-control-next-icon" aria-hidden="true"></span>
                      <span class="sr-only">Next</span>
                    </a>
                  </div>
            </div>
            <div id="shopIconCategoryDiv">
                <div id="iconBoxDiv">
                    <img class="icon" src="https://i.ibb.co/7zcnV7J/monitor.png" alt="">
                    <img class="icon" src="https://i.ibb.co/vvXdtzx/keyboard.png" alt="">
                    <img class="icon" src="https://i.ibb.co/WxvDnGD/mouse.png" alt="">
                    <img class="icon" src="https://i.ibb.co/z4n9ZXF/desk.png" alt="">
                    <img class="icon" src="https://i.ibb.co/HGP3PCL/chair.png" alt="">
                    <img class="icon" src="https://i.ibb.co/N386GVd/gitf.png" alt="">
                </div>
            </div>
            <div id="shopDisplayDiv">
                <div id="shopItemsSlideByCategoryDiv">
                </div>
                <div id="shopMainMidEventBannerDiv">
                </div>
                <div id="shopMostSearchedKeywordDiv">
                </div>
                <div id="shopMainBestReviewsDiv">
                </div>
                <div id="shopItemsAccordionDiv">
                </div>
            </div>
        </div>
    </div>
<script>
/*실시간 순위 시작*/
$(function() {
    var count = $('#rank-list li').length;
    var height = $('#rank-list li').height();

    function step(index) {
        $('#rank-list ol').delay(2000).animate({
            top: -height * index,
        }, 500, function() {
            step((index + 1) % count);
        });
    }
    step(1);
});

/*실시간 순위 끝*/
</script>
</body>
</html>