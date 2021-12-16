<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopMainPage</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<style>
    #shopHeaderBarDiv{
        display: flex;
    }

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

</style>

</head>


<body>
    <div id="shopMainOuter">
        <div id="shopHeaderBarDiv">
            <img src="/99.DEVRUN/바.png" alt="">
            <div id="sideMenuBtnDiv">           
            </div>
            <div id="shopTop-10Div">
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
                      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                  </nav>
            </div>
            <div id="shopMainEventbtnDiv">
                <button type="button" class="btn btn-warning">이벤트보기</button>
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