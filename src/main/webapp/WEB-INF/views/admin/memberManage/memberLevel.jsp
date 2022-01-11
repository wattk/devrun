<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<jsp:include page="/WEB-INF/views/admin/admin-common/header.jsp">
	<jsp:param value="회원 등급 관리" name="title"/>
</jsp:include>


<!-- Button trigger modal -->
<button id="authorityBtn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw600" id="exampleModalLabel">확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<h5 class="fw600"> <span id="preVal"></span> -> <span id="afterVal"></span>으로 권한을 바꾸시겠습니까?</h5>
      </div>
      <div class="modal-footer">
        <button type="button" id="successBtn" class="btn btn-primary">권한 변경</button>
        <button type="button" id="cancelBtn"class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<div id ="memberLevelContainer" class="container">
	<h2>회원 등급 관리</h2>
	 <div id="searchContainer">
	 	<div id="serchTypeContainer">
	        <span>검색 타입</span>
	        <select id="searchType">
	            <option value="MemberAll">전체 회원</option>		
	            <option value="MemberNo">회원 번호</option>		
	            <option value="MemberId">회원 아이디</option>
	            <option value="MemberName">회원 이름</option>
	            <option value="MemberNickName">회원 별명</option>
	            <option value="MemberRole">회원 권한</option>
	        </select>
	 	</div>
	 	
	 	<div id = "searchKeywordContainer">
    		<div id="searchMemberAll" class="search-type">
	            <form>
	                <input type="hidden" name="searchType" value="all"/>
	                <input type="hidden" name="searchKeyword" value="all"/>
	                <button type="submit"id="searchBymemberAll" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        <div id="searchMemberNo" class="search-type other">
	            <form>
	                <input type="hidden" name="searchType" value="member_no"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 회원 번호를 입력하세요." value=""/>
	                <button type="submit"id="searchBymemberNo" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        <div id="searchMemberId" class="search-type other">
	            <form>
	                <input type="hidden" name="searchType" value="id"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 회원 아이디를 입력하세요" value=""/>
	                <button type="submit" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        
	        <div id="searchMemberName" class="search-type other">
	            <form>
	                <input type="hidden" name="searchType" value="name"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요." value=""/>
	                <button type="submit" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        
	        <div id="searchMemberNickName" class="search-type other">
	            <form action="<%=request.getContextPath()%>/admin/memberFinder">
	                <input type="hidden" name="searchType" value="nickname"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 별명을 입력하세요." value=""/>
	                <button type="submit" class="btn-blue search-btn">검색</button>			
	            </form>	
	        </div>
	        
	        <div id="searchMemberRole" class="search-type other">
	            <form action="<%=request.getContextPath()%>/admin/memberFinder">
	            	<input type="hidden" name="searchType" value="authority"/>
	            	
			        <input type="checkbox" class="btn-check" name="searchKeyword" id="admin" value="ROLE_AM">
					<label class="btn btn-success" for="admin">관리자</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="member1" value="ROLE_M1" >
					<label class="btn btn-success" for="member1">지식인</label>
					
					<input type="checkbox" class="btn-check" name="searchKeyword" id="member2" value="ROLE_M2" >
					<label class="btn btn-success" for="member2">일반회원</label>
	                <button type="submit" class="btn-blue search-btn">검색</button>
	            </form>
	        </div>
		</div>
	</div>
	<div id="totalCountContainer">
		
	</div>
	<div id="memberListContainer">
	  <br /><hr /><br />
		<!-- 상품 리스트 테이블 -->
		<table id="productList" class="mx-auto">
			<thead id ="thead">
				<tr>
					<th style="width : 5vw;">회원 번호</th>
					<th style="width : 10vw;">회원 아이디</th>
					<th style="width : 10vw;">회원 이름</th>
					<th style="width : 15vw;">회원 별명</th>
					<th style="width : 7vw;">가입일</th>
					<th style="width : 7vw;">권한</th>
				</tr>	
			</thead>
			<tbody id = "tbody">
			<c:forEach items="${memberList}" var="member">
				<tr>
					<td>${member.memberNo }</td>
					<td>${member.id }</td>
					<td>${member.name }</td>
					<td>${member.nickname }</td>
					<td> <fmt:formatDate value="${member.enrollDate }" pattern="yyyy-MM-dd"/>  </td>
					<td>
				        <select class="select-authority bg-light border-0 small">
						 	<option value="ROLE_AM" ${member.authorities[0]  =="ROLE_AM" ? "selected" : "" }>관리자</option>
						 	<option value="ROLE_M1" ${member.authorities[0]  =="ROLE_M1" ? "selected" : "" }>지식인</option>
						 	<option value="ROLE_M2" ${member.authorities[0] =="ROLE_M2" ? "selected" : "" }>일반 회원</option>
						 </select>
	        		</td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
	</div>						
	${pagebar}
	
</div>
<form 
	action="${pageContext.request.contextPath}/admin/memberManage/updateAuthority.do" 
	name="memberRoleUpdateFrm"
	method="post">
	<input type="hidden" name="memberNo" />
	<input type="hidden" name="authority" />
</form>	

<script>
	$(successBtn).click(e=>{
		console.log( $(document.memberRoleUpdateFrm).find("[name=memberNo]").val()   );
		console.log( $(document.memberRoleUpdateFrm).find("[name=authority]").val()   );
		
		$(memberRoleUpdateFrm).submit();
				
	});
	var preVal;
	var afterVal;
	
	// select 클릭시 선택값 저장
	$(".select-authority").one("click",function(e){
		preVal = e.target.value;
		console.log("변경 이전 값 = ",preVal);
	});
	
	
 	//권한 변경시 띄울 모달 이벤트 
 	$(document).on("change",".select-authority",(e)=>{
 			
	 	console.log("select값 변경");
		$(authorityBtn).trigger("click");
		afterVal = e.target.value;
		
		var targetMemberNo = $(e.target).parents("tr").children().first().html();
		console.log("타겟 memberNo =", targetMemberNo);
		
		console.log("변경전 값 = ",preVal);
		console.log("변경후 값 = ",afterVal);
		
		// 모달 확인창에 html 추가
		EncoPreVal = preVal == "ROLE_AM" ? "관리자" : (preVal == "ROLE_M1" ? "지식인" : "일반회원");
		EncoAfterVal = afterVal == "ROLE_AM" ? "관리자" : (afterVal == "ROLE_M1" ? "지식인" : "일반회원");
		
			
		$("#preVal").html("["+EncoPreVal+"]");		
		$("#afterVal").html("["+EncoAfterVal+"]");
		
		// 히든폼에 값 채우기
		var $frm = $(document.memberRoleUpdateFrm);
		
		$frm.find("[name = memberNo]").val(targetMemberNo);
		$frm.find("[name = authority]").val(afterVal);
			
	});
 	
 	//취소 선택시 이전 값으로 돌리기  && preVal afterVal 값 초기화
	$(document).on("click","#cancelBtn",(e)=>{	
		$(searchBymemberAll).trigger("click");
			
		console.log("변경전 값 = ",preVal);
		console.log("변경후 값 = ",afterVal);
	
	});
		
 	
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
		
		// 검색타입 바뀔 때 마다 값 초기화
		$searchType = "";
		$searchKeyword = "";
		
		var searchTypeVal = $(this).val();
		$(".search-type")
			.hide()
			.filter("#search" + searchTypeVal)
			.css("display", "inline-block");
	});
	
	/* search 입력값 대입  */
	$("input[name=searchKeyword]").change(e=>{		
		console.log($(e.target).parent().children("input[name=searchType]").val());
		console.log($(e.target).val()); 
		
		$searchType = $(e.target).parent().children("input[name=searchType]").val();
	 	$searchKeyword = $(e.target).val() ;
	});
	
	/* 전역 변수 */
	var $searchType = "";
	var $searchKeyword = "";

		function getPage(cPage){
	
		const $btn = $(".search-btn");
		
		searchType = $searchType;
		searchKeyword =  $searchKeyword;
		var cPage;
		
		
		/* 검색 타입이 권한인 경우 검색 내용에 check된 box들의 value값을 담아준다  */
		if($searchType == "authority"){
			var authority = [];
			$("#searchMemberRole input:checkbox:checked").each(function(){
				var chk = $(this).val();
				authority.push(chk);	
			});
			
			// 배열값으로 넘기지 못해 변환 후 keyword에 저장
			$searchKeyword = authority.toString();
		}
			
		console.log(searchType);
		console.log(searchKeyword);
		
		const search = {
			"searchType" : $searchType,
			"searchKeyword" : $searchKeyword,
			"cPage" : cPage
		};
		

		console.log(search);
		
		$.ajax({
			url:`${pageContext.request.contextPath}/admin/memberManage/searchMember.do`,
			data:search,
			contentType:"application/json; charset=utf-8",
			success(data){
				console.log(data);
										 			
				$("#tbody").html(data["memberStr"]);
				$(".pagebar").detach();
				$("#memberListContainer").after(data["pagebar"]);
				$(totalCountContainer).html(`<span class="countTitle">검색된 회원 수 : </span> <span class="countContent">\${data["totalContent"]}</span>`)			
			},
			error:console.log			
		});
	
	}
	
	$(".search-btn").click(e=>{
		e.preventDefault(); 
		getPage();			
	});
	
	
	
	
</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


