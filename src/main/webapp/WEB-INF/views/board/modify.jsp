<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
    
<%@ include file="../includes/header.jsp" %>    
			<style>
				.uploadResult {width: 100%; }				
	            .uploadResult ul {float:left;}				
	            .uploadResult ul li {}				
	            .uploadResult ul li img {width: 260px; height: 260px; position:relative; border-radius: 20px;}
	            .cancle_btn {width: 30px; height: 30px; background-color: #000; border-radius: 50%;}
	    
	            .bigPictureWrapper {position: absolute; display: none; justify-content: center; align-items: center;
	                                    top:0%; width:100%; height:100%; background-color: gray; z-index: 100;}				
	            .bigPicture {position: relative; display:flex; justify-content: center; align-items: center;}
	            .bigPicture img {width:600px;}
	            #new_star {display:none;}
	            #friend_request {display:none;}
			</style>
			
			<script src="https://code.iconify.design/2/2.1.0/iconify.min.js"></script>
				
            
		        <div id="profile">
		            <ul id="user">
		                <li id="user_photo">
		                    
		                </li>
				        <li id="nickname">
							<input name="nickname" value='<c:out value="${login.nickname}"/>'readonly>
						</li>
						<li id="user_info">
							<input name="user_info" value='<c:out value="${login.user_info}"/>'readonly>
						</li>
						<li id="modi_icon">
							<span class="iconify" data-icon="entypo:pencil"></span>
						</li>
		                <li id="new_star">
		                    <button>새별쓰기</button>
		                </li>
		                <li id="friend_request">
		                    <button>친구 요청하기</button>
		                </li>
		            </ul>
		        </div>
		        <form role="form" action="/board/modify" method="post">
		            <%-- <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
		            <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
                   	<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                   	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'> --%>
                   	<input type="hidden" name="bno" value='<c:out value="${board.bno}"/>'>
                   	<%-- <input type="hidden" id="email" name="email" value='<c:out value="${board.email}"/>'> --%>
		            		
		            <div id="board">
		                <ul id="main">
		                    <li id="article_title"><input name="title" value='<c:out value="${board.title}"/>'></li>
		                    <li id="article_date"><input name="redDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly></li>
		                    <li id="article_nickname">By <input name="email" value='<c:out value="${board.email}"/>' readonly></li>
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
		                    <li id="attach_title">별 사진 수정하기  <input type="file" name='uploadFile' multiple id="file_btn"></li>
		                    <li id="address">
		                        <input name="address" value='<c:out value="${board.address}"/>'>
		                    </li>
		                    <li id="con_text">
		                        <textarea rows="5" name="content"><c:out value="${board.content}"/></textarea>
		                    </li>
		                    <li id="share_title">공개설정</li>
		                    <li id="share">
		                        <input type="radio" name="post_type" id="share_all" value="1" checked="checked"> 전체공개  
		                        <input type="radio" name="post_type" id="share_friend" value="2"> 친구공개  
		                        <input type="radio" name="post_type" id="share_no" value="3"> 비공개 
		                    </li>
		                    <li id="board_btn">
		                        <button type="submit" data-oper="modify">수정하기</button>
		                        <button type="submit" data-oper="remove">삭제하기</button>
		                    </li>
		                </ul>
		            </div>
		        </form>
		   
            <script type="text/javascript">
            	$(document).ready(function(){
            		
                    $("#modi_icon").on("click", function(){
                    	self.location="/user/userUpdateView";
                    });
            		
            		var formObj=$("form");
            		$("button").on("click",function(e){
            			e.preventDefault();//전송방지
            			var operation=$(this).data("oper");
            			
            			if(operation==='remove'){
            				formObj.attr("action", "/board/remove");
            			}else if(operation==='list'){
            				formObj.attr("action","/board/list").attr("method","get");
            				// hidden tag 복제
            				var pageNumTag=$("input[name='pageNum']").clone();
            				var amountTag=$("input[name='amount']").clone();
            				var typeTag=$("input[name='type']").clone();
            				var keywordTag=$("input[name='keyword']").clone();
            				// form태그 내부 자식 태그 모두 삭제
            				formObj.empty();
            				// 다시 hidden tag 추가
            				formObj.append(pageNumTag);
            				formObj.append(amountTag);
            				formObj.append(typeTag);
            				formObj.append(keywordTag);
            			}else if(operation === 'modify'){            		        
            		        var str = "";            		        
            		        $(".uploadResult ul li").each(function(i, obj){            		          
            		          var jobj = $(obj);
            		          
            		          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
            		          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
            		          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
            		          str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";            		          
            		        });
            		        formObj.append(str).submit();
            	        }
            			formObj.submit();

            		});
					
        			
            		/* 공개여부 표시 **********************************************************************/
            		(function(){
            			var share_status = '<c:out value="${board.post_type}"/>';
                		console.log(share_status);
                		if(share_status == 1){
                			$('#share_all').attr("checked", true);
                		} else if (share_status == 2){
                			$('#share_friend').attr("checked", true);
                		} else {
                			$('#share_no').attr("checked", true);
                		}
            		})();
            		/* 공개여부 표시 **********************************************************************/
            		
            		/* 첨부파일 목록 **********************************************************************/
            		(function(){
            		    
            		    var bno = '<c:out value="${board.bno}"/>';
            		    
            		    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){            		    
            		      var str = "";
            		      $(arr).each(function(i, attach){           		          
            		    	//이미지이면 썸네일을 보여준다.
            		    	    if(attach.fileType){
            		    	      var fileCallPath =  encodeURIComponent( attach.uploadPath+"/"+attach.uuid +"_"+attach.fileName);
            		    	      str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
            		    	      str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='cancle_btn'>x</button>";
            		    	      str += "<img src='/display?fileName="+fileCallPath+"'>";
            		    	      str += "</div>";
            		    	      str +"</li>";
            		    	    }else{//파일이면 파일명과 attach.png를 보여준다
            		    	      var fileCallPath =  encodeURIComponent( attach.uploadPath+"/"+ attach.uuid +"_"+attach.fileName);            
            		    	      var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
            		    	          
            		    	      str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
            		    	      str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='cancle_btn'>x</button>";
            		    	      str += "<img src='/resources/img/attach.png'></a>";
            		    	      str += "</div>";
            		    	      str +"</li>";
            		    	    }
            		       });
            		      
            		      $(".uploadResult ul").html(str);            		      
            		    });
            		  })();
            		/* 첨부파일 목록 **********************************************************************/
            		
            		 $(".uploadResult").on("click", "button", function(e){  
            			  if(confirm("파일을 삭제하시겠습니까? ")){            			    
            			      var targetLi = $(this).closest("li");
            			      targetLi.remove();
            			   }
            		});  
            			  
            		 var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            		 var maxSize = 5242880; //5MB
            		 
            		 function checkExtension(fileName, fileSize){            			    
            		   if(fileSize >= maxSize){
            		     alert("파일 사이즈 초과");
            		     return false;
            		   }
            		   
            		   if(regex.test(fileName)){
            		     alert("해당 종류의 파일은 업로드할 수 없습니다.");
            		     return false;
            		   }
            		   return true;
            		 }
            			  
            		 $("input[type='file']").change(function(e){
          			    var formData = new FormData();  			    
            		    var inputFile = $("input[name='uploadFile']");
            			    
            		    var files = inputFile[0].files;
            			    
            		    for(var i = 0; i < files.length; i++){
	            	        if(!checkExtension(files[i].name, files[i].size) ){
	            		        return false;
	            		      }
	            		    formData.append("uploadFile", files[i]);	            		    
	            		}
            			    
            			$.ajax({
            			   url: '/uploadAjaxAction',
            			   processData: false, 
            			   contentType: false,
            			   data:formData,
            			   type: 'POST',
            			   dataType:'json',
            			   success: function(result){
            			   console.log(result); 
            			   showUploadResult(result); //업로드 결과 처리 함수 
           			      }
           			    });            			    
           			  }); 
            		 
            		 function showUploadResult(uploadResultArr){
            			    
            		    if(!uploadResultArr || uploadResultArr.length == 0){ 
            		    	return; 
            		    }            			    
            		    var uploadUL = $(".uploadResult ul");            			    
            		    var str ="";
            		    
            		    $(uploadResultArr).each(function(i, obj){            					
            		    	//이미지이면 썸네일을 보여준다.
        			        if(obj.image){
        			          var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
        			          str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
        			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='cancle_btn'>x</button>";
        			          str += "<img src='/display?fileName="+fileCallPath+"'>";
        			          str += "</div>";
        			          str +"</li>";
        			        }else{//파일이면 파일명과 attach.png를 보여준다
        			          var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
        			          var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
        			              
        			          str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
        			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='cancle_btn'>x</button>";
        			          str += "<img src='/resources/img/attach.png'></a>";
        			          str += "</div>";
        			          str +"</li>";
        			        }
            		    });
            		    
            		    uploadUL.append(str);
            		  }
            		 
            		 /* 프로필 사진 출력 ************************************************************************/
            		   (function(){	                            		   
            				var email = "${login.email}";	                            		   
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
        
 <%@include file="../includes/footer.jsp" %> 