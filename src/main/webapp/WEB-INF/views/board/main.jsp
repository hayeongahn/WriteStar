<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  

 <%@ include file="../includes/header.jsp" %> 
 	<!-- 슬라이더 (캐러셀) 부분 - 최신 게시글 5개 ------------------------------------->
 	<div id="slider">
 		<ul id="slide">
			<c:forEach items="${topList}" var="top" begin="0" end="4">
				<li class="slide_img" data-path='<c:out value="${top.thumbnail.uploadPath}"/>' data-uuid='<c:out value="${top.thumbnail.uuid}"/>' data-filename='<c:out value="${top.thumbnail.fileName}"/>'>
                  	<h1><a class="move" href='/board/get?bno=<c:out value="${top.bno}"/>&email=<c:out value="${top.email}"/>'><c:out value="${top.title}"/></a></h1>
                  	<h2><fmt:formatDate pattern="yyyy-MM-dd" value="${top.regdate}"/></h2>
                  	<p><a class="move" href='/board/list?email=<c:out value="${top.email}"/>'><c:out value="${top.userVO.nickname}"/></a></p>
             	</li>
             </c:forEach>
		 </ul>
		 <!-- <ul class="dotList">
            <li class="on">1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
            <li>5</li>
        </ul> -->
	</div>
	<div id="btnBox">
            <button class="prev"><span class="iconify" data-icon="bi:arrow-left-circle-fill"></span></button>
            <button class="next"><span class="iconify" data-icon="bi:arrow-right-circle-fill"></span></button>
    </div>
	<!-- 슬라이더 (캐러셀) 부분 ------------------------------------------------------->
	<!-- 서비스 소개 부분 ------------------------------------------------------->
	<div id="introduction">
		<hr color="#E9E9E9">
		<div id="introduction_text">
			<img src="/resources/img/introduction.png" alt="">
			<p>한번쯤 하늘을 올려다 보신 적이 있나요? <br>
				하늘엔 무수히 많은 별이 떠 있지만 주변의 불빛때문에 별을 보기가 어려워요.<br>
				하지만 도시를 조금만 벗어나면 수많은 별을 볼 수 있다는 것을 알고 계셨나요?<br>
				‘별을쓰다' 를 통해서 별보기 좋은 곳을 다른 사람과 공유해 보세요.<br>
				나만의 별 일기를 쓰고 관리할 수도 있고, 다른 사람들과 공유해서 더 많은 정보를 주고 받을 수 있습니다.<br>
				오늘부터 시작해 보세요.</p>
		</div>
		<hr color="#E9E9E9">
	</div>
	<!-- 서비스 소개 부분 ------------------------------------------------------->
	<!-- 컨텐츠 부분 - 공개된 최근 게시글 중 1번째 부터 5번째까지 표시 ------------------------------->
	<div id="content_title"><p>Other Planet</p></div>
	<div id="content_wrap">
 		<ul id="content">
			<c:forEach items="${otherList}" var="other" begin="0" end="5">
				<a class="move" href='/board/get?bno=<c:out value="${other.bno}"/>&email=<c:out value="${other.email}"/>'>
					<li class="content_img" data-path='<c:out value="${other.thumbnail.uploadPath}"/>' data-uuid='<c:out value="${other.thumbnail.uuid}"/>' data-filename='<c:out value="${other.thumbnail.fileName}"/>'>
                  		<h1><c:out value="${other.userVO.nickname}"/></h1>
                  		<h2>조회 : <c:out value="${other.hits}"/></h2>
                  		<p><c:out value="${other.content}"/></p>
                  	</li>
                </a>
             </c:forEach>
		 </ul>
	</div>
	<!-- 컨텐츠 부분 - 공개된 최근 게시글 중 1번째 부터 5번째까지 표시 ------------------------------->
	
	<script>
		$(function(){
			$('#content').find('li').each(function(i,e){
				var str = "";
				var path = $(this).attr("data-path");
				var uuid = $(this).attr("data-uuid");
				var fileName = $(this).attr("data-filename");
				
				var fileCallPath =  encodeURIComponent(path+ "/"+uuid +"_"+fileName);
				console.log(fileCallPath);
				str += "<img src='/display?fileName="+fileCallPath+"'><br>";
				$(this).prepend(str);
			 });
			
			$('#slide').find('li').each(function(i,e){
				var str = "";
				var path = $(this).attr("data-path");
				var uuid = $(this).attr("data-uuid");
				var fileName = $(this).attr("data-filename");
				
				var fileCallPath =  encodeURIComponent(path+ "/"+uuid +"_"+fileName);
				console.log(fileCallPath);
				str += "<img src='/display?fileName="+fileCallPath+"'><br>";
				$(this).prepend(str);
			 });
			
			// 슬라이더 //////////////////////////////////////////////////
			var imgWidth = $('.slide_img').outerWidth();
			$("button.next").on("click", playNext);
			$("button.prev").on("click", playPrev);
			var move = setInterval(playNext, 3000);
	
			$("button").on({
				mouseenter: function(){
				clearInterval(move);
				console.log("stop!");
				},
				mouseleave: function(){
				move = setInterval(playNext, 3000);
				console.log("play!");
				}
			});
	
			function playNext() {
				$('#slide').stop().animate({left: -imgWidth}, 1000, function(){
					$('.slide_img:first').insertAfter('.slide_img:last');
					$('#slide').css("left", 0);
					var idx = $('.slide_img:first').children('img').attr("alt");
					$('.dotList>li').eq(idx-1).addClass('on').siblings('li').removeClass("on");
				});
			}
			function playPrev() {
				$('#slide').css("left", -imgWidth);
				$('.slide_img:last').insertBefore('.slide_img:first');
				$('#slide').stop().animate({left: 0}, 1000, function(){
					var idx = $('.slide_img:first').children('img').attr("alt");
					$('.dotList>li').eq(idx-1).addClass('on').siblings('li').removeClass("on");
				});
			}
			// 슬라이더 //////////////////////////////////////////////////
		});
	</script>
 <%@include file="../includes/footer.jsp" %>   