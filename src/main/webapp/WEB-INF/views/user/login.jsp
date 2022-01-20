<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../includes/header.jsp" %> 

	<div id="user_box">
	<form action="/user/loginPost" method="post" name="loginForm">
		<table id="table">
			<tr>
				<td>
					<input type="email" id ="email" name="email" placeholder="Email 입력">
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" id="pw" name="password" placeholder="비밀번호 입력" >
				</td>
			</tr>
			<tr>
				<td style="text-align:center;">
					<input type ="submit" id="start" value="내 별로 이동" onclick="return loginCheck()"></input>
					<input type ="button" id="cancel" value="취소" onClick="location.href='/'"></input>
				</td>
			</tr>
			
		</table>
	</form>
	</div>
	<script>
	function loginCheck(){	

		if(document.loginForm.email.value.length==0){
			alert("이메일을 입력하세요");
			document.loginForm.email.focus();
			return false;
		}
		if(document.loginForm.password.value.length==0){
			alert("비밀번호를 입력하세요");
			document.loginForm.password.focus();
			return false;
		}
	}
	</script>
	
 <%@include file="../includes/footer.jsp" %>   