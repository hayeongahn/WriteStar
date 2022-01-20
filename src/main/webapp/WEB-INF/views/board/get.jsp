<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
    
<%@ include file="../includes/header.jsp" %> 
<%-- <c:out value="${login.email }"/>
<h1> ${login.nickname }</h1>  --%>  
	<style>
		.uploadResult {width: 100%;}				
		.uploadResult ul {float:left;}				
		.uploadResult ul li {}				
		.uploadResult ul li img {width: 260px; height: 260px; position:relative; border-radius: 20px;}
		.cancle_btn {width: 30px; height: 30px; background-color: #000; border-radius: 50%;}

		.bigPictureWrapper {position: absolute; display: none; justify-content: center; align-items: center;
								top:0%; width:100%; height:100%; background-color: gray; z-index: 100;}				
		.bigPicture {position: relative; display:flex; justify-content: center; align-items: center;}
		.bigPicture img {}
	</style>
	
			<div id="profile">
		            <ul id="user">
		                <li id="user_photo">
		                    
		                </li>
				        <li id="nickname">
							<%-- <a href='/board/list?email=<c:out value="${board.email}"/>'><input name="nickname" value='<c:out value="${board.userVO.nickname}"/>'readonly></a> --%>
							<a href='/board/list?email=<c:out value="${board.email}"/>'><p><c:out value="${board.userVO.nickname}"/></p></a>
						</li>
						<li id="user_info">
							<input name="user_info" value='<c:out value="${board.userVO.user_info}"/>'readonly>
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
								<input type="hidden" name="email" value="<c:out value="${board.email}"/>">
								<button type="submit">친구 요청하기</button>
							</form>
						</li>
		            </ul>
		        </div>
			<div id="board">
				<ul id="main">
					<li id="article_title_get"><input name="title" value='<c:out value="${board.title}"/>'readonly></li>
					<li id="article_date"><input name="redDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly></li>
					<li id="article_nickname">By <input name="email" value='<c:out value="${board.userVO.nickname}"/>' readonly></li>
					<li id="article_img">
						<div class='uploadResult'>
							<ul>
							</ul>
						</div>
						<div class='bigPictureWrapper'>
							  <div class='bigPicture'>
							  </div>
						</div>	
					</li>
					<li id="address">
						<input name="email" value='<c:out value="${board.address}"/>'readonly>
					</li>
					<li id="con_text">
						<textarea rows="5" name="content" readonly><c:out value="${board.content}"/></textarea>
					</li>
					<li id="board_btn">
						<button id="modification" type="submit" data-oper="modify">수정하기</button>
						<button id="showList" type="submit" data-oper="list">목록보기</button>
					</li>
				</ul>
				<!-- 댓글목록 ------------------------------------------------------------------------------------------------->
					<button id="addReplyBtn" class="chat">댓글쓰기</button>
					<ul>
						<li id="reply_title">다른 별에서 온 메세지<hr></li>
					</ul>
					<ul id="chatter">
					
					</ul>
					<div class="panel-footer">
					</div>
				<!-- 댓글목록 -->
			</div>
			<form id="operForm" action="/board/modify" method="get">
			   <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
			   <input type="hidden" id="email" name="email" value='<c:out value="${board.email}"/>'>
			</form>
							
					<script type="text/javascript" src="/resources/js/reply.js"></script>
					<script type="text/javascript">
						/* 친구 여부 확인 *********************************************************/
						var friendArr = [];
						<c:forEach items="${friendList}" var="friend">
						 	friendArr.push("${friend.email}");
						</c:forEach>
						
						var friendResult = friendArr.includes("${login.email}");
						
				 		if ( friendResult == true) {
				 			console.log("친구입니다.");
							$("#profileForm > button").hide();
						} else {
							console.log("친구가 아닙니다.");
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
				 	 		console.log("친구요청이 있습니다.");
					 		// 요청이 있을 경우 친구요청 버튼 숨김
				 	 		$("#profileForm > button").hide();
					 	}
				 		/* 친구 신청 여부 확인 */
				 		
				 		/* 본인 여부 확인 *********************************************************/
				 		var profileUser = "<c:out value='${board.email}'/>";
				 		var loginUser = "<c:out value='${login.email}'/>";
				 		
				 		if (profileUser === loginUser) {
				 			$("#profileForm > button").hide();
				 		}
				 		/* 본인 여부 확인 */
						$(document).ready(function(){
							//user 로그인에 따른 버튼 보여주고 숨기기 //////////////////////////////
							(function(){
								var l_user = "${login.email}";
								var b_user = "${board.email}";
								if(l_user == b_user){
									$("#modi_icon").show();
									$("#friend_request").hide();
								} else {
									$("#modi_icon").hide();
									$("#new_star").hide();
									$("#modification").hide();
								}
							})(); 
							
					        $("#modi_icon").on("click", function(){
					        	self.location="/user/userUpdateView";
					        });
					        /////////////////////////////////////////////////////////////
		                     
		                   
							$("#new_star").on("click",function(){
								self.location="/board/register";
							});
							var operForm=$("#operForm");
							$("button[data-oper='modify']").on("click",function(e){
								operForm.attr("action","/board/modify").submit();
							});
							$("button[data-oper='list']").on("click",function(e){
								operForm.find("#bno").remove();
								operForm.attr("action","/board/list");
								operForm.submit();
							});
							
							var bnoValue='<c:out value="${board.bno}"/>';
							var replyUL=$("#chatter");//댓글목록이 출력되는 ul태그
							
							showList(1); 
							
							//댓글 목록을 get page에 표시하기 
							function showList(page){
								replyService.getList({bno:bnoValue,page:page||1},
										function(replyCnt, list){ //reply.js 함수 호출
								
									
								if(page == -1) {
									pageNum = Math.ceil(replyCnt/10.0);
									showList(pageNum);
									return;
								}
								
								var str="";
								
								//댓글의 갯수(list)가 0개이면 replyUL(#chatter)에 추가 내용 없음.
									if(list==null || list.length==0){
										replyUL.html("");
										return;
									}
								    //DB단 댓글 갯수에 맞추어 li tag 추가.
									for(var i=0,len=list.length || 0; i<len; i++){
										str+="<li class='reply_list' data-rno='"+list[i].rno+"'style='cursor:pointer'>";
										str+="<div class='reply_list_con'>"+list[i].content+"</div>";
										str+="<div class='reply_list_nick'>"+list[i].userVO.nickname+"</div>";
										str+="<div class='reply_list_date'>"+replyService.displayTime(list[i].replyDate)+"</div>";
										str+="</div></li>";
									}
									
									replyUL.html(str); //replyUL(#chatter)에 li태그 추가
									
								 	showReplyPage(replyCnt);
								});
							};
							
							var modal = $(".modal");
							var modalInputReply = modal.find("input[name='content']");
							var modalInputReplyer = modal.find("input[name='email']");
							var modalInputReplyDate = modal.find("input[name='replyDate']");
							
							var modalModBtn = $("#modalModBtn");
							var modalRemoveBtn = $("#modalRemoveBtn");
							var modalRegisterBtn = $("#modalRegisterBtn");
							
							//댓글추가 버튼을 누르면 모갈 창 내 close, registration 버튼을 제외한 다른 버튼 숨긴 후 모달창 보여주기.
							$("#addReplyBtn").on("click", function(e){
								modal.find("input[name='content']").val(""); //content input box내 내용 삭제 
								modal.find("button[id !='modalCloseBtn']").hide();                            	        
								modalRegisterBtn.show();                            	        
								modal.show();                            	        
							  }); 
							
							//close 버튼 누르면 모달창 닫기.
							$("#modalCloseBtn").on("click", function(e){                            	    	
								modal.hide();
							}); 

							//댓글 등록 버튼을 누르면, reply.js 내 add function 실행 
						   modalRegisterBtn.on("click",function(e){                            	        
							  var reply = {content: modalInputReply.val(), email:modalInputReplyer.val(), bno:bnoValue};
							  replyService.add(reply, function(result){
								alert(result); //댓글 등록 성공 확인 창 띄움 
								modal.find("input[name='content']").val(""); //content input box내 내용 삭제 
							  	modal.hide(); //Modal 창 숨김 
							  	showList(-1);//등록후 마지막페이지로 이동
							  	//showList(1);//테스트 후 삭제 
							  });                            	        
							}); 
						
							//댓글을 클릭했을 때 
						  $("#chatter").on("click", "li", function(e){                            	          
							  var rno = $(this).data("rno");                            	          
							  replyService.get (rno, function(reply){                            	          
								modalInputReply.val(reply.content);
								modalInputReplyer.val(reply.email);
								modalInputReplyDate.val(replyService.displayTime( reply.replyDate)).attr("readonly","readonly");
								modal.data("rno", reply.rno);
								modal.find("button[id !='modalCloseBtn']").hide();
								modalModBtn.show();
								modalRemoveBtn.show();
								
								modal.show(); 
									
							  });
							}); 
							  
						  //댓글 수정 버튼을 누르면, reply.js 내 update function 실행	
						  modalModBtn.on("click", function(e){
							  var reply = {rno:modal.data("rno"), content: modalInputReply.val()};                            	      
							  replyService.update (reply, function(result){
								modal.hide();
								showList(pageNum); 
								//showList(1);//테스트 후 삭제 
							  });                            	      
							}); 

						  //댓글 삭제 버튼을 누르면, reply.js 내 remove function 실행
						  modalRemoveBtn.on("click", function (e){                            	    	  
								var rno = modal.data("rno");                            	  	  
								replyService.remove(rno, function(result){
									modal.hide();
									showList(pageNum);
									//showList(1);//테스트 후 삭제 
								});                            	  	  
						  });  
							   
						  		//페이징 처리 
							   var pageNum = 1;
							   var replyPageFooter = $(".panel-footer");
								
							   function showReplyPage(replyCnt){
								  
							   var endNum = Math.ceil(pageNum / 5.0) * 10;  
							   var startNum = endNum - 9; 
								  
							   var prev = startNum != 1;
							   var next = false;
								  
							   if(endNum * 10 >= replyCnt){
								  endNum = Math.ceil(replyCnt/5.0);
							   }
								  
							   if(endNum * 10 < replyCnt){
								 next = true;
							   } 
							       
							   var str = "<ul class='paging_bar'>";
								  
								 if(prev){
								   str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'><span class='iconify' data-icon='bi:arrow-left-square'></span></a></li>";
								 }
								  
								 for(var i = startNum ; i <= endNum; i++){	                            	       
								   var active = pageNum == i? "active":"";
								  
								   str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
								 }
								  
								 if(next){
								   str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'><span class='iconify' data-icon='bi:arrow-right-square'></span></a></li>";
								 }
								  
								 str += "</ul></div>";	                            	      
								 
								 
								 replyPageFooter.html(str);
							   } 
							   
							   replyPageFooter.on("click","li a", function(e){
								   e.preventDefault();	                            	       
								   
								   var targetPageNum = $(this).attr("href"); 
								   
								   pageNum = targetPageNum;
								   
								   showList(pageNum);
							   });   
							   
							   /* 첨부파일 목록 ************************************************************************/
							   (function(){	                            		   
									var bno = '<c:out value="${board.bno}"/>';	                            		   
									$.getJSON("/board/getAttachList", {bno: bno}, function(arr){	                            		     
									   var str = "";	                            		       
									   $(arr).each(function(i, attach){	                            		       
										 //image type
										 if(attach.fileType){
										   var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/"+attach.uuid +"_"+attach.fileName);
										   
										   str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
										   str += "<img src='/display?fileName="+fileCallPath+"'>";
										   str += "</div>";
										   str +"</li>";
										 }else{	                            		             
										   str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
										   str += "<span> "+ attach.fileName+"</span><br/>";
										   str += "<img src='/resources/img/attach.png'></a>";
										   str += "</div>";
										   str +"</li>";
										 }
									   });
									   
									   $(".uploadResult ul").html(str); 
									 });
								  })(); 
								/* 첨부파일 목록 */
							   
								/* 썸네일을 클릭했을 때 full screen으로 띄우기 *****************************************************************/
								   function showImage(fileCallPath){
									   $(".bigPictureWrapper").css("display","flex").show();
									   $(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>").animate({width:'100%',height:'100%'},1000);
								   } 
								   /* 썸네일을 클릭했을 때 full screen으로 띄우기 */
								   
								   $(".uploadResult").on("click","li",function(e){
									   var liObj=$(this);
									   var path=encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
									   if(liObj.data("type")){
										   showImage(path.replace(new RegExp(/\\/g),"/"));
									   }else{
										   self.location="/download?fileName="+path;
									   }
								   });
								   
								   $(".bigPictureWrapper").on("click",function(e){
									   $(".bigPicture").animate({width:'0%',height:'0%'},1000,function(){
										$(".bigPictureWrapper").hide();
									});		
								   });
								   
								   /* 프로필 사진 출력 ************************************************************************/
								   (function(){	                            		   
										var email = "${board.email}";	                            		   
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
							     
						});
					</script>
	
					<!-- Modal -------------------------------------------------------------------------------->
					<div class="modal">
						   <div class="modal-main">
								<div class="modal-body">
									<div class="reply_nickname">
										<label>By</label>
										<c:if test="${login.email ne ''}">
			                  				<input type="text" name="modal_nickname" value="${login.nickname}">
			                  				<input type="hidden" name="email" value="${login.email}">
			                  			</c:if> 
									</div>	
									<div class="reply_content">
										<input name="content" placeholder="댓글을 입력해 주세요.">
									</div>  		      
								</div>
								<div class="modal-footer">
									<button id='modalModBtn' type="button">Modify</button>
									<button id='modalRemoveBtn' type="button">Remove</button>
									<button id='modalRegisterBtn' type="button">Register</button>
									<button id='modalCloseBtn' type="button">Close</button>
								  </div>          
						   </div>					       
					  </div> 
					<!-- modal -->
            
            
        
 <%@include file="../includes/footer.jsp" %> 

