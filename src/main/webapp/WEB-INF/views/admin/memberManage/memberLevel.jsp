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

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

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
    		<div id="searchMemberAll" class="search-type">
	            <form>
	                <input type="hidden" name="searchType" value="all"/>
	                <input type="hidden" name="searchKeyword"  size="25" placeholder="검색할 회원 번호를 입력하세요." value="all"/>
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
	<div id="memberListContainer">
	  <br /><hr /><br />
		<!-- 상품 리스트 테이블 -->
		<table id="productList">
			<thead id ="thead">
				<tr>
					<th>회원 번호</th>
					<th>회원 아이디</th>
					<th>회원 이름</th>
					<th>가입입</th>
					<th>권한</th>
				</tr>	
			</thead>
			<tbody id = "tbody">
			<c:forEach items="${memberList}" var="member">
				<tr>
					<td>${member.memberNo }</td>
					<td>${member.id }</td>
					<td>${member.name }</td>
					<td> <fmt:formatDate value="${member.enrollDate }" pattern="yyyy/MM/dd"/>  </td>
					<td>
						<select class="select-authority">
				            <option value="ROLE_AM" ${member.authority =="ROLE_AM" ? "selected" : "" }>관리자</option>		
				            <option value="ROLE_M1" ${member.authority =="ROLE_M1" ? "selected" : "" }>지식인</option>		
				            <option value="ROLE_M2" ${member.authority =="ROLE_M2" ? "selected" : "" }>일반 회원</option>
				        </select>
	        		</td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
	</div>
				
 
	<br />
	${pagebar}
	
</div>

<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>	

<script>
	
	$(exampleModal)
		.modal()
		.on("")
	
	
	
	/* 권한 변경시 띄울 모달 이벤트 */
/* 	$(document).on("change",".select-authority",()=>{
		console.log("select값 변경");
				
		
	}); */
		
	
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
		
		/* 검색 타입이 권한인 경우 검색 내용에 check된 box들의 value값을 담아준다  */
		if($searchType == "authority"){
			var authority = [];
			$("#searchMemberRole input:checkbox:checked").each(function(){
				var chk = $(this).val();
				authority.push(chk);	
			});
			// 배열값으로 넘기지 못해 변환 후 keyword에 저장
			authority.toString();
			$searchKeyword = authority.toString();
		}
			
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
				$("#tbody").html("");
				
				var memberList = data.memberList;
				
				console.log(memberList);	
				
				for(let i = 0; i < memberList.length; i++){
					$("#tbody").append(`<tr>
					<td>\${memberList[i].memberNo}</td>
					<td>\${memberList[i].id}</td>
					<td>\${memberList[i].name}</td>
					<td>\${memberList[i].enrollDate}</td>
					<td>
						<select class="select-authority">
				            <option value="ROLE_AM" \${memberList[i].authority =="ROLE_AM" ? "selected" : "" }>관리자</option>		
				            <option value="ROLE_M1" \${memberList[i].authority =="ROLE_M1" ? "selected" : "" }>지식인</option>		
				            <option value="ROLE_M2" \${memberList[i].authority =="ROLE_M2" ? "selected" : "" }>일반 회원</option>
			       		</select>						
					</td>				
					</tr>`);
				}						
			},
			error:console.log
			
		});
		
	});
	
	
	
	
</script>

<jsp:include page="/WEB-INF/views/admin/admin-common/footer.jsp"></jsp:include>


