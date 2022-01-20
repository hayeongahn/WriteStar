<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>         
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>별을쓰다</title>
       
    <link rel="stylesheet" href="/resources/css/reset.css" />
    <link rel="stylesheet" href="/resources/css/style.css">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
    <script src="https://code.iconify.design/2/2.1.0/iconify.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div id="wrapper">
	        <nav class="main_box">
	            <ul id="gnb">
	                <li><a href="/">Home</a></li>
	                <li><a href="/board/list?email=${login.email}">My star</a></li>
	                <li><a href="/friend/friendRequestPage?to_user=${login.email}">Other Planet</a></li>
	                <li>
	                  <form id='searchForm' action="/search/searchResult" method='get'>
	                  	<input id="search" type="text" name="keyword" placeholder="검색어를 입력하세요.">
	                  	<button type="submit" id="search_icon"><span class="iconify" data-icon="bx:bx-search-alt"></span></button>
	                  	
	                  </form>
	                </li>
	                <div id="gnb_right">
	                	<li id="user_update"><a href="/user/userUpdateView">${login.nickname} 님의 <span class="iconify" data-icon="noto-v1:shooting-star"></span></a></li>
	                    <li id="join"><a href="/user/userRegister">Join <span class="iconify" data-icon="noto-v1:shooting-star"></span></a></li>
	                    <li id="login"><a href="/user/login">Log In >>>> <span class="iconify" data-icon="noto-v1:shooting-star"></span></a></li>
	                    <li id="logout"><a href="/user/logout">Log Out <<<< <span class="iconify" data-icon="noto-v1:shooting-star"></span></a></li>
	                </div>
	           </ul>
	        </nav>
	        <div id="logo_wrap">
		        <div id="logo">
		        <div><img src="/resources/img/logo.png" alt="logo"></div>
		        </div>
	        </div>
	        
	        <script type="text/javascript">
				$(document).ready(function(){
					
					//로그인 상태에 따라서 로그인, 로그아웃 변경//////////////////////////////
					var checking = "${login.email}";
					console.log(checking);
                    if (checking == ""){
                    	console.log("로그인 안된 상태");
                    	$("#login").show();
                    	$("#logout").hide();
                    	$("#user_update").hide();
                    	$("#gnb_right").css("margin-left","150px");
                    } else {
                    	console.log("로그인 상태");
                    	$("#join").hide();
                    	$("#login").hide();
                    	$("#logout").show();
                    	$("#user_update").show();
                    }
					////////////////////////////////////////////////
                 	
					//검색 action ///////////////////////////////////
                    var searchForm = $("#searchForm");
	    			var keyword = $('#searchForm').find("input[name='keyword']").val();
	    			console.log("alert");
					////////////////////////////////////////////////
				
				});
                    
                    
                    
                    
		    </script>