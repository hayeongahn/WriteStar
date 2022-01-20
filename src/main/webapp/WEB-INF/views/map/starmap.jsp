<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
 
 <%@ include file="../includes/header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
    <link rel="stylesheet" href="header.footer.css">
    <link rel="stylesheet" href="starmap.css">
<title>Insert title here</title>
</head>
<body>
<div id="wrap">

     <div id="content" class="clear">
       <h3>지도에서 별 보기 좋은 곳 찾기</h3>
       <hr class="divider">
       <section id="star_map">
           <h4>아래 지도에서 지역을 선택하세요.</h4>
           <img src="image/south korea 1.png" alt="1">
       </section>
       <section id="map_api">
        <div id="map" style="width:600px;height:300px;"></div>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	3daacfa3e2a7ecbea9882493425045aa"></script>
        <script>
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level: 3
            };
    
            var map = new kakao.maps.Map(container, options);
        </script>
       </section>
       <section id="weather">
           <img src="image/weather.png" alt="2">
       </section>
       <section id="place" class="clear">
        <hr class="divider">
         <h3>검색 지역 내 별 보기 좋은 곳</h3>
           <ul class="list">
               <li>
                   <a href="#">
                       <img src="image/list01.png" alt="1">
                   </a>
	                   <p class="title">혼별혼별</p>
	                   <p class="views01">조회수:1,256</p>
	                   <p class="write">새벽녘에 잠에서 깼더니 다시 잠이 오지 않아서<br>
	                    밖으로 나갔다가 보게된 하늘의 별............</p>
               </li>
               <li>
	               <a href="#">
	                   <img src="image/list01.png" alt="1">
	               </a>
	                   <p class="title">혼별혼별</p>
	                   <p class="views02">조회수:1,256</p>
	                   <p class="write">새벽녘에 잠에서 깼더니 다시 잠이 오지 않아서<br>
	                    밖으로 나갔다가 보게된 하늘의 별............</p>
	            </li>
	            <li>
		            <a href="#">
		                <img src="image/list01.png" alt="1">
		            </a>
		                <p class="title">혼별혼별</p>
		                <p class="views03">조회수:1,256</p>
		                <p class="write">새벽녘에 잠에서 깼더니 다시 잠이 오지 않아서<br>
		                    밖으로 나갔다가 보게된 하늘의 별............</p>
	            </li>
           </ul>
    </section>
</div>
</body>
</html>
 <%@include file="../includes/footer.jsp" %>   