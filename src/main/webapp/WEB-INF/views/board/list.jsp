<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
 
 <%@ include file="../includes/header.jsp" %> 
 

 				<div id="profile">
		            <ul id="user">
		                <li id="user_photo">
		                    
		                </li>
				        <li id="nickname">
							<input name="nickname" value='<c:out value="${profile.nickname}"/>' readonly>
						</li>
						<li id="user_info">
							<input name="user_info" value='<c:out value="${profile.user_info}"/>' readonly>
						</li>
						<li id="modi_icon">
							<span class="iconify" data-icon="entypo:pencil"></span>
						</li>
		                <li id="new_star">
		                    <button>새별쓰기</button>
		                </li>
						<li id="friend_request">
							<form role="form" id="profileForm" action="/friend/addFriend" method="post">
								<input type="hidden" name="from_user" value="<c:out value="${login.email}"/>">
								<input type="hidden" name="email" value="<c:out value="${profile.email}"/>">
								<button type="submit">친구 요청하기</button>
							</form>
						</li>
		            </ul>
		        </div>
		       
				<!-- 게시글 표시 ------------------------------------->
			 	<div id="board_con">
			 		<ul id="board_list">
						<c:forEach items="${list}" var="board">
							<a class="move" href='/board/get?bno=<c:out value="${board.bno}"/>&email=<c:out value="${board.email}"/>'>
								<li class="list_img" 
								data-type='<c:out value="${board.post_type}"/>'
								data-path='<c:out value="${board.thumbnail.uploadPath}"/>'
								data-uuid='<c:out value="${board.thumbnail.uuid}"/>'
								data-filename='<c:out value="${board.thumbnail.fileName}"/>'
								>
									<!-- <img src="/display?fileName=<c:out value="${board.thumbnail.uploadPath}"/>/<c:out value="${board.thumbnail.uuid}"/>_<c:out value="${board.thumbnail.fileName}"/>">
			                  		-->
			                  		<c:if test="${board.post_type eq '1'}">
			                  			<h3 id="unlock"><span class="iconify" data-icon="bx:bxs-lock-open"></span></h3>
			                  		</c:if>
			                  		<c:if test="${board.post_type eq '2'}">
			                  			<h3 id="lock"><span class="iconify" data-icon="la:user-friends"></span></h3>
			                  		</c:if>
			                  		<c:if test="${board.post_type eq '3'}">
			                  			<h3 id="lock"><span class="iconify" data-icon="bx:bxs-lock"></span></h3>
			                  		</c:if>
			                  		<h1><c:out value="${board.title}"/></h1>
			                  		<h2><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></h2>
			                  		<p><c:out value="${board.userVO.nickname}"/></p>
			                  	</li>
			                </a>
			             </c:forEach>
					 </ul>
					 
					 <!-- Paging -->
	                <div class="paging">
	                	<ul class="paging_bar">
	                	
	                		<c:if test="${pageMaker.prev}">
	                			<li class="paginate_button previous">
	                			<a href="${pageMaker.startPage -1 }"><span class="iconify" data-icon="bi:arrow-left-square"></span></a>
	                			</li>
	                		</c:if>
	                		
	                		<c:forEach var="num" begin="${pageMaker.startPage }"
	                		end="${pageMaker.endPage }">
	                			<li class="paginate_button ${pageMaker.cri.pageNum == num ?"active":""} ">
	                			<a href="${num}">${num}</a>
	                			</li>
	                		</c:forEach>	
	                		
	                		<c:if test="${pageMaker.next }">
	                			<li class="paginate_button next">
	                			<a href="${pageMaker.endPage +1 }"><span class="iconify" data-icon="bi:arrow-right-square"></span></a>
	                			</li>
	                		</c:if>		
	                	</ul>
	                </div>
	                <form id='actionForm' action="/board/list" method="get">
	                	<input type="hidden" id="email" name="email" value='<c:out value="${pageMaker.cri.email}"/>'>
	                	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	                	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
	                </form>
					<!-- Paging -->
					
				</div>
				<!-- 게시글 표시 ------------------------------------->
	
	<script>
	$(document).ready(function(){
		/* 친구 여부 확인 *********************************************************/
		var friendArr = [];
		<c:forEach items="${friendList}" var="friend">
		 	friendArr.push("${friend.email}");
		</c:forEach>
		
		var friendResult = friendArr.includes("${login.email}");
		
 		if ( friendResult == true) {
			$("#profileForm > button").hide();
		} else {
			$("#profileForm > button").show();
		}
 		/* 친구 여부 확인 */
 		
 		/* 친구 신청 여부 확인 *********************************************************/
 		var requestArr = [];
 	 	<c:forEach items="${requestList}" var="request">
	 		requestArr.push("${request.to_user}");
	 		requestArr.push("${request.from_user}");
	 	</c:forEach>
	 	
	 	var requestResult = requestArr.includes("${login.email}");
	 	
 	 	if (requestResult == true) {
	 		// 요청이 있을 경우 친구요청 버튼 숨김
 	 		$("#profileForm > button").hide();
	 	}
 		/* 친구 신청 여부 확인 */
 		
 		/* 본인 여부 확인 *********************************************************/
 		var profileUser = "<c:out value='${profile.email}'/>";
		var postUser = [];
 		var loginUser = "<c:out value='${login.email}'/>";
		<c:forEach items="${list}" var="board">
			postUser.push("${board.email}");
		</c:forEach>
 		
		var identify = postUser.includes("${login.email}");
 		
 		if (profileUser === loginUser) {
 			$("#profileForm > button").hide();
 		}
 		/* 본인 여부 확인 */
 		
 		/* 게시글 공개 범위 설정 *********************************************************/
 		$(".move").on("click", function(e){
			// 공개여부
 			var postType = $(this).find('.list_img').attr('data-type');
 			// 비공개글
			if(postType == 3 && identify == false) {
 				e.preventDefault();
 				alert("비공개 글입니다.");
 				return;
 			} else if(postType == 2 && friendResult == false && identify == false) { //친구공개글
				e.preventDefault();
				alert("친구 공개 글입니다.");
 				return;
 			}
 		});
 		/* 게시글 공개 범위 설정 */
 		
		$("#new_star").on("click",function(){
			self.location="/board/register";
		});
		$("#friend_request").on("click",function(){
			self.location="";
		});
		
		$("#edit").on("click",function(){
            
		});
		
		//user 로그인에 따른 버튼 보여주고 숨기기 //////////////////////////////
		(function(){
			var l_user = "${login.email}";
			var b_user = "${profile.email}";
			if(l_user == b_user){
				$("#modi_icon").show();
				$("#friend_request").hide();
			} else {
				$("#modi_icon").hide();
				$("#new_star").hide();
			}
		})(); 
		
        $("#modi_icon").on("click", function(){
        	self.location="/user/userUpdateView";
        });
        /////////////////////////////////////////////////////////////
        
      //페이지번호 클릭하면 이동
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		/* 프로필 사진 출력 ************************************************************************/
	   (function(){	                            		   
			var email = "${profile.email}"                          		   
			$.getJSON("/user/getAttachList", {email: email}, function(arr){	                            		     
			   var str = "";	                            		       
			   $(arr).each(function(i, attach){	                            		       
				 //image type
				 if(attach.bno == null){
				   var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/"+attach.uuid +"_"+attach.fileName);
				   str += "<img src='/display?fileName="+fileCallPath+"'>";
				 }
			   });
			   if(str.length == 0) {
				   str += "<img src='/resources/img/userPhoto.png'>";
				   $("#user_photo").html(str);
			   }else {
				   $("#user_photo").html(str);
			   }
			 });
		  })(); 
		/* 프로필 사진 출력 */
		
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
	});
	</script>

        
 <%@include file="../includes/footer.jsp" %>   