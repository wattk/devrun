<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="회원 등급 관리" name="title"/>
</jsp:include>

<c:if test="${not empty msg}">
<script>
	alert("${msg}");
</script>
</c:if>

<!-- 모달 -->


<div id ="memberLevelContainer">
	<h2>회원 등급 관리</h2>
	 <div id="search-container">
	        검색타입 : 
	        <select id="searchType">
	            <option value="">아이디</option>		
	            <option value="">회원명</option>
	            <option value="">성별</option>
	        </select>
	        <div>
		        <div id="search-memberId" class="search-type">
		            <form action="<%=request.getContextPath()%>/admin/memberFinder">
		                <input type="hidden" name="searchType" value="memberId"/>
		                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." value=""/>
		                <button type="submit">검색</button>			
		            </form>	
		        </div>
		        
		        <div id="search-memberName" class="search-type">
		            <form action="<%=request.getContextPath()%>/admin/memberFinder">
		                <input type="hidden" name="searchType" value="memberName"/>
		                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요." value=""/>
		                <button type="submit">검색</button>			
		            </form>	
		        </div>
		        
		        <div id="search-gender" class="search-type">
		            <form action="<%=request.getContextPath()%>/admin/memberFinder">
		                <input type="hidden" name="searchType" value="gender"/>
		                <input type="radio" name="searchKeyword" value="M"> 남
		                <input type="radio" name="searchKeyword" value="F"> 여
		                <button type="submit">검색</button>
		            </form>
		        </div>
	        </div>
	    </div>
	<div id="memberListContainer">
		<!-- 상품 리스트 테이블 -->
		<table id="productList">
			<tr>
				<th>회원 번호</th>
				<th>회원 아이디</th>
				<th>회원 이름</th>
				<th>가입입</th>
				<th>권한</th>
			</tr>	
			<tr>				
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>		
			</tr>	
		</table>
	</div>
				

	<br />
	${pagebar}
	
</div>

	

<script>

	
	/*  호버 이벤트 */
	$("#productList tr").hover(
		e=>{
			$(e.target).parent("tr").css("background","#0d6efd36");
		},
		e=>{
			$(e.target).parent("tr").css("background","white");
		}
	)
	
	$(searchType).change(function(){
		var searchTypeVal = $(this).val();
		$(".search-type")
			.hide()
			.filter("#search-" + searchTypeVal)
			.css("display", "inline-block");
	});

</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


