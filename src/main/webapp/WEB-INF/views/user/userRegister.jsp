<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../includes/header.jsp" %> 

	<div id="user_box">
		<form action="/user/userRegister" method="post" name="registerForm">
		<table id="table_reg">
			<tr>
				<td>
					<input type="email" id="email_reg" name="email" placeholder="이메일">
                    <button type="button" id="emailCheckBtn" name="emailCheck" value="N">이메일 중복 확인</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" id="pw_reg" name="password" placeholder="비밀번호">
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" id="pw_check" name="passwordConfirm" placeholder="비밀번호 확인">
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="nickname_reg" name="nickname" placeholder="닉네임">
                    <button type="button" id="nicknameCheckBtn" name="nicknameCheck" value="N">닉네임 중복 확인</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="pw_check" name="user_info" placeholder="간단한 소개글을 입력해 주세요.">
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" id="registration" value="가입" onclick="return registerCheck()">
                    <button>취소</button>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<script>
	function registerCheck(){ 
		// 각 입력칸 공란 확인
		if(document.registerForm.email.value.length==0){ 		// 이메일을 입력하지 않았다면 ~
			alert("이메일을 입력하세요"); 							// 경고창 
			document.registerForm.email.focus(); 				// 이메일 입력칸에 커서 이동
			return false; 										// 실행 중지 
		}
		if(document.registerForm.password.value.length==0){
			alert("비밀번호를 입력하세요");
			document.registerForm.password.focus();
			return false;
		}
		if(document.registerForm.nickname.value.length==0){
			alert("닉네임을 입력하세요");
			document.reigsterForm.nickname.focus();
			return false;
		}
		
		// 중복 확인 유무 
		if(document.registerForm.emailCheck.value == 'N'){		// 중복 확인을 안했다면 ~
			alert("이메일 중복 확인을 하세요."); 						// 경고창
			return false;
		}
		
		var password = $("#pw_reg").val();
		// 최소 8자 최소 하나의 문자, 하나의 숫자 및 하나의 특수문자
		var regPassword = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
		if(!regPassword.test(password)) {
			alert("비밀번호 양식이 올바르지 않습니다.");
			document.registerForm.password.focus();
			return false;
		}
		// 비밀번호 일치 확인
		var passwordConfirm  = $("#pw_check").val();
		if(password != passwordConfirm) {
			alert("비밀번호 확인이 일치하지 않습니다.");
			document.registerForm.password.focus();
			return false;
		}
		
		if(document.registerForm.nicknameCheck.value == 'N'){
			alert("닉네임 중복 확인을 하세요.");
			return false;
		}
		
	}
	</script>
	<script>
	$(document).ready(function(){
		// 이메일 중복 확인 버튼 클릭 시 
		$('#emailCheckBtn').click(function(){
			
			// 이메일 입력란 공백 확인
			var email = $("#email_reg").val();						// 입력한 이메일 값
			if(email.length == 0) {								// 이메일을 입력하지 않았다면
				alert("이메일을 입력하세요");						// 경고창
				$("#email_reg").focus();							// 커서 이동
				return false;									// 실행 중지
				}
			
			// 이메일 정규표현식 확인
			var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(!regEmail.test(email)) {
				alert("이메일 입력이 올바르지 않습니다.");
				$("#email_reg").focus();							
				return false;
			}
			
			// 이메일 중복 확인
			$.ajax({
				url : "/user/emailCheck",						// 전송 페이지(action url)
				type : "post",									// 전송 방식(get or post)
				dataType : "json",								// 요청한 데이터 형식 (html,xml,json,text,jsonp)
				data : {"email" : $("#email_reg").val()},			// 전송할 데이터
				success : function(data){						// 전송에 성공하면 실행할 코드
					if(data == 1) {								// 중복되었다면 ~
						alert("중복된 아이디입니다.");				// 중복 경고창
					} else if(data == 0) {						// 중복되지 않았다면 ~
						$("#emailCheckBtn").attr('value','Y');	// 중복 확인 표시
						alert("사용가능한 아이디입니다.");				// 사용 가능 경고창
					}
				}
			})
		});
		
		// 닉네임 중복 확인 버튼 클릭 시 
		$('#nicknameCheckBtn').click(function(){
			
			// 닉네임 공백 확인
			var nickname = $("#nickname_reg").val();
			if(nickname.length == 0) {
				alert("닉네임을 입력하세요");
				$("#nickname_reg").focus();
				return false;
				}
			
			// 닉네임 중복 확인
			$.ajax({
				url : "/user/nicknameCheck",
				type : "post",
				dataType : "json",
				data : {"nickname" : $("#nickname_reg").val()},
				success : function(data){
					if(data == 1) {
						alert("중복된 닉네임입니다.");
					} else if(data == 0) {
						$("#nicknameCheckBtn").attr('value','Y');
						alert("사용가능한 닉네임입니다.");
					}
				}
			})
		});
	});
	</script>
	
 <%@include file="../includes/footer.jsp" %>   