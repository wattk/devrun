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


<div id ="memberLevelContainer">
	<h2>회원 등급 관리</h2>
	 <div id="searchContainer">
	 	<div id="serchTypeContainer">
	        <span>검색 타입</span>
	        <select id="searchType">
	            <option value="MemberAll">전체 회원</option>		
	            <option value="MemberNo">회원 번호</option>		
	            <option value="MemberId">회원 아이디</option>
	            <option value="MemberName">회원 이름</option>
	            <option value="MemberRole">회원 권한</option>
	        </select>
	 	</div>
	 	
	 	<div id = "searchKeywordContainer">
	   
	        <div id="searchMemberNo" class="search-type">
	            <form>
	                <input type="hidden" name="searchType" value="member_no"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 회원 번호를 입력하세요." value=""/>
	                <button type="submit"id="searchBymemberNo" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        <div id="searchMemberId" class="search-type other">
	            <form action="<%=request.getContextPath()%>/admin/memberFinder">
	                <input type="hidden" name="searchType" value="id"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 회원 아이디를 입력하세요" value=""/>
	                <button type="submit" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        
	        <div id="searchMemberName" class="search-type other">
	            <form action="<%=request.getContextPath()%>/admin/memberFinder">
	                <input type="hidden" name="searchType" value="name"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요." value=""/>
	                <button type="submit" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        
	        <div id="searchMemberRole" class="search-type other">
	            <form action="<%=request.getContextPath()%>/admin/memberFinder">
			        <input type="checkbox" class="btn-check" name="searchKeyword" id="option1" value="" autocomplete="off" >
					<label class="btn btn-success" for="option1">관리자</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="option2" autocomplete="off" >
					<label class="btn btn-success" for="option2">지식인</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="option3" autocomplete="off" >
					<label class="btn btn-success" for="option3">일반회원</label>
	                <button type="submit" class=btn-blue>검색</button>
	            </form>
	        </div>
	    </div>
	  </div>
	<div id="memberListContainer">
	  <br /><hr /><br />
		<!-- 상품 리스트 테이블 -->
		<table id="productList">
			<tr>
				<th>회원 번호</th>
				<th>회원 아이디</th>
				<th>회원 이름</th>
				<th>가입입</th>
				<th>권한</th>
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
			.filter("#search" + searchTypeVal)
			.css("display", "inline-block");
	});

	$(".search-btn").click(e=>{
		e.preventDefault(); 
		
		var $searchType = $(e.target).parent().children("input[name=searchType]").val();
		var $searchKeyword = $(e.target).parent().children("input[name=searchKeyword]").val();
		
		console.log($searchType);
		console.log($searchKeyword);
		
		const search = {
			"searchType" : $searchType,
			"searchKeyword" : $searchKeyword
		};


		console.log(search);
		
		$.ajax({
			url:`${pageContext.request.contextPath}/admin/memberManage/searchMember.do`,
			data:search,
			contentType:"application/json; charset=utf-8",
			success(data){
				console.log(data);
			},
			error:console.log
			
		});
		
	});
	
	
	
	
</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


