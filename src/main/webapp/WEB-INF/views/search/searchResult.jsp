<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
 
<%@ include file="../includes/header.jsp" %> 
	
	<!-- 검색 페이지 상단 검색창 ------------------------------->
	<div id="search_wrapper">
		<form id='searchForm' action="/search/searchResult" method='get'>
	    	<input id="search_result_page" type="text" name="keyword" placeholder="검색어를 입력하세요.">
	    	<button type="submit" id="search_icon_result"><span>Search</span></button>
	    </form>
	    
	    <!-- 추천 검색어 표시 ------------------------------->
	    <div id="recommand_title"><p>추천 검색어</p></div>
		<div id="recommand">
			<ul id="recommand_list">
				<li>강원도 별 여행</li>
				<li>연인끼리 별 보기 좋은 곳</li>
				<li>아이들과 함께 별 볼 수 있는 여행지</li>
				<li>새해에 해돋이와 함께 별을 볼 수 있는 곳</li>
			</ul>
	    </div>
	    <!-- 추천 검색어 표시 ------------------------------->
	    
    </div>
    <!-- 검색 페이지 상단 검색창 ------------------------------->
    
    
	<!-- 컨텐츠 부분 - 검색결과 표시 ------------------------------->
	<div id="search_title"><p>Search Result</p></div>
	<div id="search_wrap">
 		<ul id="search_list">
			<c:forEach items="${searchList}" var="searchList">
				<a class="move" href='/board/get?bno=<c:out value="${searchList.bno}"/>&email=<c:out value="${searchList.email}"/>'>
					<li class="search_img"
					data-path='<c:out value="${searchList.thumbnail.uploadPath}"/>'
					data-uuid='<c:out value="${searchList.thumbnail.uuid}"/>'
					data-filename='<c:out value="${searchList.thumbnail.fileName}"/>'
					>
						<!-- <img src="/display?fileName=<c:out value="${searchList.thumbnail.uploadPath}"/>/<c:out value="${searchList.thumbnail.uuid}"/>_<c:out value="${searchList.thumbnail.fileName}"/>"><br>
                  		-->
                  		<h1><c:out value="${searchList.userVO.nickname}"/></h1>
                  		<h2>조회 : <c:out value="${searchList.hits}"/></h2>
                  		<p><c:out value="${searchList.content}"/></p>
                  	</li>
                </a>
             </c:forEach>
		 </ul>
	</div>
	<!-- 컨텐츠 부분 - 검색결과 표시 ------------------------------->
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('.move').find('li').each(function(i,e){
				var str = "";
				var path = $(this).attr("data-path");
				var uuid = $(this).attr("data-uuid");
				var fileName = $(this).attr("data-filename");
				
				var fileCallPath =  encodeURIComponent(path+ "/"+uuid +"_"+fileName);
				console.log(fileCallPath);
				str += "<img src='/display?fileName="+fileCallPath+"'><br>";
				$(this).prepend(str);
			 });
			
			//검색 action ///////////////////////////////////
                  var searchForm = $("#searchForm");
   			var keyword = $('#searchForm').find("input[name='keyword']").val();
   			console.log("alert");
			////////////////////////////////////////////////
		
		});
	</script>
        
 <%@include file="../includes/footer.jsp" %>   