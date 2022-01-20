<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
 
<%@ include file="../includes/header.jsp" %>

	<div id="profile">
		<ul id="user">
			<li id="user_photo">
				<img src="/resources/img/userPhoto.png" alt="#">
			</li>
			<li id="nickname">
				<input name="nickname" value="hyahn" readonly>
			</li>
			<li id="user_info">
				<input name="user_info" value="hyahn@test.com" readonly>
			</li>
			<li id="modi_icon">
				<span class="iconify" data-icon="entypo:pencil"></span>
			</li>
			<li id="confirm_icon">
				<span class="iconify" data-icon="line-md:confirm-circle"></span>
			</li>
				<li id="new_star">
			<button>새별쓰기</button>
			</li>
			<li id="friend_request">
				<button>친구 요청하기</button>
			</li>
		</ul>
	</div>
	
	<c:forEach items="${list}" var="board">
		<ul id="board_list">
			<li class='uploadResult'>
				<!-- 첨부 이미지 정보 불러옴 ----------------->
				<c:out value="${board.thumbnail.fileName}"/>
				<c:out value="${board.thumbnail.uuid}"/>
				<c:out value="${board.thumbnail.uploadPath}"/>
			</li>
			<li>
				<a class="move" href='/board/get?bno=<c:out value="${board.bno}"/>'>
				<c:out value="${board.title}"/>
				</a>
			</li>
			<li><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></li>
			<li><c:out value="${board.email}"/></li>
		</ul>
	</c:forEach>
	
	<script>
		$(document).ready(function(){
			$("#new_star").on("click",function(){
				self.location="/board/register";
			});
			$(".friend_request").on("click",function(){
				self.location="";
			});
			
			$("#edit").on("click",function(){
	            
			});
			
			/* user info 수정 버튼 */
	        $("#confirm_icon").hide();
	        $("#modi_icon").on("click", function(){
	             $("#user_info input").removeAttr("readonly");
	             $("#nickname input").addClass("info_change");
	             $("#user_info input").addClass("info_change");
	             $("#confirm_icon").show();
	             $("#modi_icon").hide();
	             console.log("변경 아이콘 클릭");
	        });
	        $("#confirm_icon").on("click", function(){
	             $("#user_info input").attr("readonly",true);
	             $("#nickname input").removeClass("info_change");
	             $("#user_info input").removeClass("info_change");
	             $("#confirm_icon").hide();
	             $("#modi_icon").show();
	             console.log("컴펌 아이콘 클릭");
	        });
		});
	</script>
        
 <%@include file="../includes/footer.jsp" %>   