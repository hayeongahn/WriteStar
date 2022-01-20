<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">

 <%@ include file="../includes/header.jsp" %> 

	<div id="wrap">
	<div id="innerwrap">
		<h1 id="r_title">내 별을 초대한 행성 <span class="iconify" data-icon="noto-v1:shooting-star"></span></h1>
		<form role="form" id="form" action="/friend/response" method="post">
			<table id="r_table" width="100%">
			    <c:forEach items="${list}" var="friend" varStatus="status">
			    <tr class="table_item" id="friend_requested_list${status.count}">
			        <td><a href="/board/list?email=<c:out value="${friend.email}"/>" class='path'></a></td>	
			    	<td class="r_nickname"><a href="/board/list?email=<c:out value="${friend.email}"/>"><c:out value="${friend.nickname}"/></a></td>
			    	<td class="r_info"><a href="/board/list?email=<c:out value="${friend.email}"/>"><c:out value="${friend.user_info}"/></a></td>
			    	<td>
			    		<input  type="hidden" class="fromUser" name="from_user" value="<c:out value="${friend.email}"/>">
			    		<input  type="hidden" class="toUser"   name="to_user"   value="<c:out value="${login.email}"/>">
			    		<input  type="hidden" class="hdnInput" name="hdnYN"     value="S" >
			    		<button type="submit" class="approve"  value="Y" data-oper="Y">수락</button>
			    		<button type="submit" class="refuse"   value="N" data-oper="N">거절</button>
			    	</td>
			    </tr>
			    </c:forEach>
			</table>
		</form>
	</div>
	<div>
		<h1 id="f_title">내 행성에 떠있는 별들.. <span class="iconify" data-icon="noto-v1:shooting-star"></span></h1>
		<form role="form" id="form2" action="/friend/removeFriend" method="post">
			<table id="r_table" width="100%">
			    <c:forEach items="${friendList}" var="frList" varStatus="status">
				    <tr class="table_item2" id="friend_list${status.count}">
				        <td><a href="/board/list?email=<c:out value="${frList.email}"/>" class='path'></a></td>
				    	<td class="r_nickname"><a href="/board/list?email=<c:out value="${frList.email}"/>"><c:out value="${frList.nickname}"/></a></td>
				    	<td class="r_info"><a href="/board/list?email=<c:out value="${frList.email}"/>"><c:out value="${frList.user_info}"/></a></td>
				    	<td>
				    		<input type="hidden"  class="friendEmail" name="friend_email" value="<c:out value="${frList.email}"/>">
				    		<input type="hidden"  class="userEmail"   name="user_email"   value="<c:out value="${login.email}"/>">
				    		<button type="submit" class="delete">삭제</button>
				    	</td>
				    </tr>
			    </c:forEach>
			</table>
		</form>
	</div>

	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		let appBtn = document.querySelector("#approve");
	    let refBtn = document.querySelector("#refuse");
	    
	    $(document).ready(function(){
	    	/* 초대 목록 프로필 사진 출력 **********************************/
		 	var inviationList = [];
			invitationList = $('.table_item>td>.fromUser');
			invitationList.each(function(index, item){
				var email = $(this).val();
				console.log(email);
					$.getJSON("/user/getAttachList", {email: email}, function(arr){	                            		     
			 			  var str = "";	  
			 			 console.log(email);
			 			  $(arr).each(function(n, attach){	                            		       
			 			 //image type
			 			 console.log(attach);
			 			 if(attach.bno == null){
			 			   var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/"+attach.uuid +"_"+attach.fileName);
			 			   str += "<img src='/display?fileName="+fileCallPath+"'>";
			 			 }
			 		  });
				 		if(str.length == 0) {
					 		str += "<img src='/resources/img/userPhoto.png'>";
					 		$('.table_item:eq('+index+')').find('.path').html(str);
					 	} else {
					 		$('.table_item:eq('+index+')').find('.path').html(str);
					 	}
			    	});
			});
	    	
	    	/* 친구 목록 프로필 사진 출력 **********************************/
		 	var myFiendList = [];
			myFiendList = $('.table_item2>td>.friendEmail');
			myFiendList.each(function(index, item){
				var email = $(this).val();
				console.log(email);
					$.getJSON("/user/getAttachList", {email: email}, function(arr){	                            		     
			 			  var str = "";	  
			 			 console.log(email);
			 			  $(arr).each(function(n, attach){	                            		       
			 			 //image type
			 			 console.log(attach);
			 			 if(attach.bno == null){
			 			   var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/"+attach.uuid +"_"+attach.fileName);
			 			   str += "<img src='/display?fileName="+fileCallPath+"'>";
			 			 }
			 		  });
				 		if(str.length == 0) {
					 		str += "<img src='/resources/img/userPhoto.png'>";
					 		$('.table_item2:eq('+index+')').find('.path').html(str);
					 	} else {
					 		$('.table_item2:eq('+index+')').find('.path').html(str);
					 	}
			    	});
			});
			
	    	// 수락버튼을 클릭했을 때
	    	$(".approve").on("click",function(e){
	    		var operation = $(this).data("oper");
	    		$(this).parent("td").find(".hdnInput").val(operation);

	    		e.preventDefault();

	    		var fromUser = $(this).parent("td").find(".fromUser").clone();
	    		var toUser   = $(this).parent("td").find(".toUser").clone();
	    		var hdnYN    = $(this).parent("td").find(".hdnInput").clone();
	    		
				$("#form").empty();	
				
				$("#form").append(fromUser);
	    		$("#form").append(toUser);
	    		$("#form").append(hdnYN);
	    			    		
	    		$.ajax({
	                url : '/friend/response',
	                type : 'post',
	                data : {
	                	from_user : $("#form").find(".fromUser").val(),
	                	to_user : $("#form").find(".toUser").val(),
	                	hdnYN : $("#form").find(".hdnInput").val()
	                },
	                success : function(data){
	                    console.log("ajax approve success");
	                },
	                error: function(){
	                    console.log("ajax approve error");
	                }
	            });
	    	});
	    	
	    	// 거절버튼을 클릭했을 때
	    	$(".refuse").on("click",function(e){
	    		var operation = $(this).data("oper");
	    		$(this).parent("td").find(".hdnInput").val(operation);

	    		e.preventDefault();

	    		var fromUser = $(this).parent("td").find(".fromUser").clone();
	    		var toUser   = $(this).parent("td").find(".toUser").clone();
	    		var hdnYN    = $(this).parent("td").find(".hdnInput").clone();
	    		
				$("#form").empty();	
				
				$("#form").append(fromUser);
	    		$("#form").append(toUser);
	    		$("#form").append(hdnYN);
	    		
		    	var formData = $("#form").serialize();
	    		
	    		$.ajax({
	                url : '/friend/response',
	                type : 'post',
	                data : {
	                	from_user : $("#form").find(".fromUser").val(),
	                	to_user : $("#form").find(".toUser").val(),
	                	hdnYN : $("#form").find(".hdnInput").val()
	                },
	                success : function(data){
	                    console.log("ajax approve success");
	                },
	                error: function(){
	                    console.log("ajax approve error");
	                }
	            });
	    	});
	    	
	    	// 삭제버튼을 클릭했을 때
	    	$(".delete").on("click",function(e){
	    		e.preventDefault();
	    		
	    		var confirmResult = confirm("친구를 삭제하시겠습니까?");
	    		
	    		if (confirmResult == true) {
		    		var friendEmail = $(this).parent("td").find(".friendEmail").clone();
		    		var userEmail   = $(this).parent("td").find(".userEmail").clone();
		    		
		    		$("#form2").empty();

					$("#form2").append(friendEmail);
		    		$("#form2").append(userEmail);
		    		
		    		var formData = $("#form2").serialize();
		    		
		    		$.ajax({
		                url : '/friend/removeFriend',
		                type : 'post',
		                data : {
		                	friend_email : $("#form2").find(".friendEmail").val(),
		                	user_email : $("#form2").find(".userEmail").val()
		                },
		                success : function(data){
		                    console.log("ajax approve success");
		                },
		                error: function(){
		                    console.log("ajax approve error");
		                }
		            });
		    		
	    		} else {
	    			return false;
	    		}
	    		
	    	});
	    	
	    });
	</script>


<%@include file="../includes/footer.jsp" %> 