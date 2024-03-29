<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>MyResume Bootstrap Template - Index</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="resources/img/favicon.png" rel="icon">
  <link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="resources/vendor/aos/aos.css" rel="stylesheet">
  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <link href="resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="resources/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="resources/css/style.css" rel="stylesheet">
  
  <!--jQuery && Ajax -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
  
  <!-- BootStrap CDN-->
  <!-- Popper JS -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <!-- Latest compiled JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	
	
  <!-- include summernote css/js : 글쓰기 API 사용-->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  
  
  
    
  <!-- =======================================================
  * Template Name: MyResume - v4.7.0
  * Template URL: https://bootstrapmade.com/free-html-bootstrap-template-my-resume/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
  <script>
  // JOIN 버튼으로 슬라이더가 움직이도록 하는 jQuery
  // 움직일 때 백엔드 구현이 위로 올라가는 현상을 없앤다. (잠시 사라지거나 등)
  	$(function(){
  		console.log("자바스크립트 초기화");
  		//슬라이딩 관련 변수
  		let login_toggle = 1; // 슬라이딩 효과에 toggle 기능을 추가
  		let join_toggle = 2;
		let last_toggle = 0;
		
  		//로그인 관련 변수
  		let id_check = false; // 아이디가 적합한지 체크해주는 변수
  		let name_check = false; // 이름이 중복되지 않는지 체크해주는 변수
  		
  		//내 정보 열람 관련 변수
  		let my_page = 1;
  		let last_page = 0;
  		
  		/*
  			슬라이딩 부분: 내가 이동할 페이지를 다시 누르면 원래 홈페이지로 돌아가도록 구성
  		*/
  		$('#login').on("click", function(){
  			if(login_slider(login_toggle, last_toggle)){
  				last_toggle = 0;	
  			}else{
  				last_toggle = 1;
  			};
  			
  			window.scrollTo(0,0);
  		})
  		
  		//엔터버튼 누르면 로그인
  		$('#login-userPwd').on("keyup",function(e){
  			if(e.keyCode == 13){
  				$('#login-btn').click();
  			 }
  		});
  		
  		$('#join').on("click", function(){
  			if(join_slider(join_toggle, last_toggle)){
  				last_toggle = 0;
  			}else{
  				last_toggle = 2;	
  			}
  			
  			window.scrollTo(0,0);
  		})
  		
  		// 원래 true false 형식으로 만들었다가 이전 페이지 값을 기록하는 식으로 바꿔 더 개선
  		function login_slider(now, last){
  			if(now!=last){
  				$('#login').attr("data-slide-to", "1");
  				$('')
  				return false
  			} else {
  				$('#login').attr("data-slide-to", "0");
  				return true;
  			}
  		}
  		
  		function join_slider(now, last){
  			if(now!=last){
  				$('#join').attr("data-slide-to", "2");
  				return false;
  			}else {
  				$('#join').attr("data-slide-to", "0");
  				return true;
  			}
  		}
  		
  		/*
  			로그인 이동 부분
  		*/
  		$('#login-btn').on("click", function(){
  			
  			if(!$('#login-userId').val()) return; //로그인 부분이 빈칸이거나 비밀번호를 적지 않았다면 전송하지 않는다.
  			if(!$('#login-userPwd').val()) return; // 아직 메시지는 설정하지 않음
  			
  			// 비동기 로그인을 위해 필요한 객체
  			  let data = { 
  						 userId : $('#login-userId').val(),
  						 userPwd: $('#login-userPwd').val()
  						}
  			
  		       async_login(data);
  			
  		})
		
  		//로그아웃 버튼은 location을 이용
  		$('#logout-btn').on("click", function(){
  			location.href="${root}/user/logout"
  		})
  		
  		// ajax 비동기 로그인: 단점이 많아 동기방식을 섞어서 사용
  	  	function async_login(data){	
  			console.log(JSON.stringify(data));
  			$.ajax({
  				url:'${root}/user/login',  
  				type:'POST',
  				contentType:'application/json; charset=utf-8',
				data: JSON.stringify(data),
  				dataType:'json',
  				error:function(xhr, status, error){
  					console.log("상태값 : " + xhr.status + "\tHttp 에러메시지 : " + xhr.responseText);
  				},
  				statusCode: {
  					204: function() {
  						alert("아이디와 비밀번호를 확인해주세요.");
  						return;
  					},
  					200: function(){
  						location.href = "${root}";
  						return;
  					},
  					500: function() {
  						alert("서버에러.");
  					},
  					404: function() {
  						alert("페이지없다.");
  					}
  				}
  			//success: 항목을 추가하지 않는 이유: 로그인 실패시 또한 DB 접속 성공이므로 204로 표기했다 = success가 또 다시 실행된다.
  			});
  		}
  		
  		/*
  			회원가입 부분
  		*/
  		
  		/* 
  		 id_check 변수 관련해 메시지를 출력한다.
  		 id_check = 1: 아이디의 최소길이를 만족하지 못하는 상태
  		 id_check = 2: 아이디에 특수문자가 들어간 경우
  		 id_check = 3: DB 검색결과 아이디의 중복이 일어났을 경우
  		*/
  		
  		$('#register-userId').on("change", function(){
  			let id_temporary = $('#register-userId').val(); //그 값을 가져와 변수화
  			if(id_temporary.length < 4 || id_temporary.length > 12){
  				id_check = false;
  				register_message("아이디의 길이는 4자 이상 12자 이하만 가능합니다.");
  				return;
  			}
  			
  			//아스키코드를 이용한 특수문자 구분
  			for(let i=0; i<id_temporary.length; i++){
  				
  				let num = id_temporary.charCodeAt(i);

  				if((48 <= num && num <= 57) || (65<= num && num <=90) || (97 <= num && num <= 122)) continue;
  				else {
  					id_check = false;
  					register_message("아이디에 특수문자는 사용할 수 없습니다.");
  					return;
  				}
  			}
  			
  			//비동기로 DB 상 id를 검색해서 중복확인
  			$.ajax({
  				url:'${root}/user/idcheck?',
  				type: "GET",
  				data: {"checkId" : id_temporary},
  				dataType: 'json',
  				success:function(res) { // ajax에서 비동기 통신으로 받아주는 function 인자값은 곧 서버에서 던져준 리턴값이다.
  					if(res == 1){
  						id_check = false;
  						register_message("이미 존재하는 아이디입니다.");
  						return;
  					}
					 //아이디 조회결과가 0인 경우
  						id_check = true;
						register_message("사용 가능한 아이디입니다."); //초록불 들어오게 만들어보기
						return;
  					
  				},
  				error:function(xhr, status, error){
  					console.log("상태값 : " + xhr.status + "\tHttp 에러메시지 : " + xhr.responseText);
  				},
  				statusCode: {
  					500: function() {
  						alert("서버에러.");
  					},
  					404: function() {
  						alert("아이디 검사에 실패했습니다.");
  					}
  				}
  			})
  			
  		})
  		
  		//회원가입 버튼 클릭
  		$('#user-register-btn').on("click", function(){
  			let pwd_temporary = $('#register-userPwd').val();
  			if(pwd_temporary.length < 4 || pwd_temporary.length > 20){
  				register_message("비밀번호는 4자 이상 20자 이하의 길이를 가져야합니다.");
  				return;
  			}
  			
  			if(pwd_temporary != $('#register-userPwd2').val()){
  				register_message("비밀번호가 일치하지 않습니다.");
  				return;
  			}
  			
  			if(!$('#register-userPwd').val()){
  				register_message("닉네임을 입력해주세요.");
  				return;
  			}
  			
  			if(!$('input[name=userGender]:checked').val() || !$('#register-userEmail').val()){
  				register_message("모든 정보를 입력해주세요.");
  				return;
  			}
  			
  			
  			if(id_check){
  				let data = {
  							 "userId": $('#register-userId').val(),
  							 "userName": $('#register-userName').val(),
  							 "userPwd": $('#register-userPwd').val(),
  							 "email": $('#register-userEmail').val(),
  							 "gender": $('input[name=userGender]:checked').val()
  						   }
  				//비동기로 회원가입 구현: 싱글페이지를 이용해 회원가입을 완료하면 로그인 페이지로 이동시키기 위해
  				$.ajax({
  					url: "${root}/user/register",
  					type: "POST",
  					dataType: 'json',
  					data: JSON.stringify(data),
  					contentType:'application/json; charset=utf-8',
  					success:function(){
  						console.log("뭐임 성공임?");
  					},
  					statusCode:{
  	  					200: function(){
  	  						alert("회원가입 성공!! ");
  	  						//성공시 값을 초기화해주어야 한다.
	  	  						$('#register-userId').val("");
	  	  						$('#register-userName').val("");
	  	  						$('#register-userPwd').val("");
	  	  						$('#register-userPwd2').val("");
	  	  						$('#register-userEmail').val("");
  	  						$('#login').click();
  	  						return;
  	  					},
  	  					406: function() { // DB단에서 받지 못했으면 406을 던져준다.
	  						alert("회원가입 실패: 알맞지 않은 형식입니다.");
	  						return;
	  					},
  	  					500: function() {
  	  						alert("서버에러.");
  	  					},
  	  					404: function() {
  	  						alert("페이지없다.");
  	  					}
  					}
  				})
  			}
  			
  			
  		})
  		
  		//회원가입시 메시지를 사용하기 위한 메서드
  		function register_message(msg){
  			 $('#register-msg').text(msg);
  		}
  		
  		
  		/*
  			내 정보 열람
  		*/
  		
  		$("#my-info").on("click", function(){
  				
  				if(my_page == last_page){
  	  				$(this).attr("data-slide-to", "0");
  	  				last_page = 0;
  	  			}else {
  	  				$(this).attr("data-slide-to", "1");
  	  				last_page = my_page;
  	  			}
  				
  				
  		})
  		
  		$('#id-nim').on("click", function(){
  			$("#my-info").click();
  		});
  		
  		$('#new-pass-btn').on("click", function(){
  			let pwd_input = $('#original-pwd').val();
  			let pwd_temporary = $('#new-pwd1').val();
  			let pwd_temporary2 = $('#new-pwd2').val();
  			
  			//DB를 통해 비밀번호가 일치하는지 체크
  			
  			if(pwd_temporary.length <4 || pwd_temporary.length > 20 || pwd_temporary2.length < 4 || pwd_temporary2.length > 20){
  				myinfo_message("비밀번호는 4자 이상 20자 이하의 길이를 가져야합니다.");
  				return;
  			}
  			
  			if(pwd_temporary != pwd_temporary2){
  				myinfo_message("비밀번호가 일치하지 않습니다.");
  				return;
  			}
			
  			if(pwd_temporary == pwd_input){
  				myinfo_message("이전과 같은 비밀번호입니다.");
  				return;
  			}
  		
  			//  여기부터 2022.4.28(목)
  			
  			let data = {
						 "userId": $('#userId').val(),
						 "userPwd": pwd_input,
						 "newPwd" : pwd_temporary
  					   }
  			
	  				
	  				//비동기로 회원가입 구현: 싱글페이지를 이용해 회원가입을 완료하면 로그인 페이지로 이동시키기 위해
	  				$.ajax({
	  					url: "${root}/user/resetpwd",
	  					type: "POST",
	  					dataType: 'json',
	  					data: JSON.stringify(data),
	  					contentType:'application/json; charset=utf-8',
	  					statusCode:{
	  	  					200: function(){
	  	  						alert("비밀번호가 변경되었습니다. ");
	  	  						//성공시 값을 초기화해주어야 한다.
		  	  						$('#original-pwd').val("");
		  	  						$('#new-pwd1').val("");
		  	  						$('#new-pwd2').val("");
	  	  						return;
	  	  					},
	  	  					204: function() { // DB단에서 현재 비밀번호가 일치하지 않았다면
		  						alert("현재 비밀번호와 일치하지 않습니다.");
		  						return;
		  					},
		  					423: function() { // DB단에서 현재 비밀번호가 일치하지 않았다면
		  						alert("데이터 전송에 실패했습니다.");
		  						return;
		  					},
	  	  					500: function() {
	  	  						alert("서버에러.");
	  	  					},
	  	  					404: function() {
	  	  						alert("페이지없다.");
	  	  					}
	  					}
	  				})
	  			
  			})
  			
  			//회원탈퇴, 비밀번호 변경시 메시지로 알려주는 메서드
  	  		function myinfo_message(msg){
  	  			 $('#my-info-msg').text("※ "+msg);
  	  		}
  		
  		
  		/*
  			게시판 영역
  		*/
  		
  		
  		/*
  			1. 로그인 성공시 로드
  		*/
  		//로그인 성공시 한번만 게시판 로드: 아이디는 4자리 이상인 것을 이용해 검사
  		let userid = $('#board-register-userid').val();
		let platform = $('#board-register-platform').val();
		
  		board_list(0);
  	  		
  	  	//리스트 갱신해주는 메서드
  		function board_list(page){
  			$('#board-content').empty();
  			let url = "${root}/board/list";
  			if(typeof(page)=='number'){
  				url += `/${'${page}'}`;
  			}
  			
  			$.ajax({
					url: url,
					type: "GET",
					contentType:'application/json; charset=utf-8',
					statusCode:{
	  					200: function(boardList){
	  						//내 아이디와 같으면 글을 수정하거나 삭제할 수 있는 버튼 생성
	  						for(let i=0; i<boardList.length; i++){
	  							let txt = `<tr>
	  						        <td>${'${boardList[i].subject}'}</td>
	  						        <td>${'${boardList[i].content}'}</td>
	  						        <td>${'${boardList[i].username}'}</td>
	  						        `;
	  						   	
	  						   	//console.log(`${'${boardList[i].userid}'}`);
	  						    if(`${'${boardList[i].userid}'}` == userid && `${'${boardList[i].platform}'}` == platform){
	  						        txt += `<td><button type="button" id="board-edit-btn-${'${boardList[i].id}'}" class="btn btn-outline-primary" data-toggle="modal" data-target="#myModal2">수정</button>`;
	  						   		
	  						    }else{
	  						   		txt += `<td></td`;
	  						   	}
	  						   	
	  						     txt +=  `</tr>`;
	  							$('#board-content').append(txt);
	  							
	  							// appen후 이벤트를 등록해준다.
	  							$(`#board-edit-btn-${'${boardList[i].id}'}`).on("click", function(){
  						   			//console.log("등록 성공");
  						   			$('#board-register-id2').val(`${'${boardList[i].id}'}`);
  						   			$('#board-register-subject2').val(`${'${boardList[i].subject}'}`);
  						   			$("#summernote2").summernote("code", `${'${boardList[i].content}'}`);
  						   		});
  						   		
	  						}
	  						
	  						return;
	  					},
	  					202: function() { 
  						alert("게시판을 불러오지 못했습니다.");
  						return;
  						},
	  					500: function() {
	  						alert("서버에러.");
	  					},
	  					404: function() {
	  						alert("페이지없다.");
	  					}
					}
				})
  		}
  	  	
  	  //글 작성 API 연결
  	  $('#summernote').summernote({
  		// 에디터 높이
  		height: 250,
  		
  		//placeholder option
  		placeholder: '글 내용 입력...',
  	    toolbar:[

  	      // This is a Custom Button in a new Toolbar Area
  	      ['custom', ['examplePlugin']],

  	      // You can also add Interaction to an existing Toolbar Area
  	      ['style', ['style' ,'examplePlugin']],
  	    ]
  	  });
  	  
  	 //글 수정 API 연결
  	  $('#summernote2').summernote({
  		// 에디터 높이
  		height: 250,
  	    toolbar:[
  	      // This is a Custom Button in a new Toolbar Area
  	      ['custom', ['examplePlugin']],

  	      // You can also add Interaction to an existing Toolbar Area
  	      ['style', ['style' ,'examplePlugin']],
  	    ]
  	  });
  	 
  	 
  	  //글 등록 버튼
  	  $('#board-register-btn').on("click", function(){
  		 let subject = $('#board-register-subject').val();
  		 let content = $($("#summernote").summernote("code")).text();
  		 //console.log(subject, content);
  		 
  		 if(!subject){
  			board_register_message("글 제목을 입력해주세요.  ");
  			return;
  		 }
  		 
  		if(!content){
  			board_register_message("글 내용을 입력해주세요.  ");
  			return;
  		 }
  		
  		let regist = confirm("글을 등록하시겠습니까?");
  		console.log($('#board-register-userid').val());
  		if(regist){
				$.ajax({
					url: "${root}/board/write",
					type: "POST",
					dataType: 'json',
					data: JSON.stringify({
						'subject': subject,
						'content': content,
						'userid': $('#board-register-userid').val(),
						'username': $('#board-register-username').val(),
						'platform': $('#board-register-platform').val()
					}),
					contentType:'application/json; charset=utf-8',
					statusCode:{
	  					200: function(){
	  						board_list(0);
	  						$('#board-register-close').click();
	  						$('#board-register-subject').val(""); 
	  						$("#summernote").summernote('reset');
	  						return;
	  					},
	  					204: function() {
	  						alert("글을 등록하는데 실패했습니다.");
  							return;
  						},
	  					304: function() {
	  						alert("세션이 만료되었습니다.");
	  						location.href="${root}/"
  							return;
  						},
	  					423: function() { 
	  						return;
	  					},
	  					406: function(){ //유효성 검사 실패
	  						alert("글의 길이나 형식을 확인해주세요.")
	  						return;
	  					},
	  					500: function() {
	  						alert("서버에러.");
	  					},
	  					404: function() {
	  						alert("페이지없다.");
	  					}
					}
				})
  		}
  		
  	  })
  	  
  	  //글 등록 관련 메시지 보여주기
  	  function board_register_message(msg){
  		$('#board-register-msg').text("※ "+msg);  
  	  }
  	  
  	  //글 수정 버튼 클릭 
  	  $('#board-edit-btn').on("click", function(){
  		 let subject = $('#board-register-subject2').val();
 		 let content = $("#summernote2").summernote("code");
 		 //console.log(subject, content);
 		 if(!subject){
 			board_edit_message("글 제목을 입력해주세요.  ");
 			return;
 		 }
 		 
 		if(!content){
 			board_edit_message("글 내용을 입력해주세요.  ");
 			return;
 		 }
 		
 		let edit = confirm("글을 수정하시겠습니까?");
 		
 		if(edit){
			$.ajax({
				url: "${root}/board/edit",
				type: "POST",
				dataType: 'json',
				data: JSON.stringify({
					'id': $('#board-register-id2').val(),
					'userid': $('#board-register-userid').val(),
					'username': $('#board-register-username').val(),
					'platform': $('#board-register-platform').val(),
					'subject': subject,
					'content': content
				}),
				contentType:'application/json; charset=utf-8',
				statusCode:{
  					200: function(){
  						board_list(0);
  						$('#board-register-close2').click();
  						$('#board-register-subject2').val(""); 
  						$("#summernote2").summernote('reset');
  						alert("글이 수정되었습니다.");
  						return;
  					},
  					204: function() {
  						alert("글을 수정하는데 실패했습니다.");
					    return;
						},
					304: function() {
  						alert("세션이 만료되었습니다.");
  						location.href="${root}/"
					    return;
						},
  					423: function() { 
  						return;
  					},
  					406: function(){ //유효성 검사 실패
  						alert("글의 길이나 형식을 확인해주세요.")
  						return;
  					},
  					500: function() {
  						alert("서버에러.");
  					},
  					404: function() {
  						alert("페이지없다.");
  					}
				}
			})
		}
  	  })
  	  
  	//글 수정 관련 메시지 보여주기
  	  function board_edit_message(msg){
  		$('#board-edit-msg').text("※ "+msg);  
  	  }
  	  
  	//글 삭제 버튼 클릭
    	$('#board-delete-btn').on("click",function(){
  		let del = confirm("해당 글을 삭제하시겠습니까?");
  		
  		if(del){
  			$.ajax({
  				url: "${root}/board/delete/" + $('#board-register-id2').val(),
  				type: "POST",
  				dataType: 'json',
  				contentType:'application/json; charset=utf-8',
  				statusCode:{
    					200: function(){
    						$('#board-register-close2').click();
    						alert("글이 삭제되었습니다.");
    						board_list(0);
    						return true;
    					},
    					204: function() {
    						alert("글을 삭제하는데 실패했습니다.");
  							return false;
  						},
    					304: function() {
    						alert("세션이 만료되었습니다.");
    						location.href="${root}/"
  							return false;
  						},
    					423: function() { 
    						return;
    					},
    					500: function() {
    						alert("서버에러.");
    					},
    					404: function() {
    						alert("페이지없다.");
    					}
  				}
  			})
  		}
    	});
  	
  	
    	var ws;
  		
    	/* 소켓 부분 */
    	function wsOpen(roomNumber){
    		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
    		ws = new WebSocket("ws://" + location.host + "/meedawn/chatting/"+roomNumber);
    		wsEvt();
    	}
    		
    	function wsEvt() {
    		ws.onopen = function(data){
    			//소켓이 열리면 동작
    		}
    		
    		ws.onmessage = function(data) {
    			//메시지를 받으면 동작
    			var msg = data.data;
    			if(msg != null && msg.trim() != ''){
    				var d = JSON.parse(msg);
    				if(d.type == "getId"){
    					var si = d.sessionId != null ? d.sessionId : "";
    					if(si != ''){
    						$("#sessionId").val(si); 
    					}
    				}else if(d.type == "message"){
    					if(d.sessionId == $("#sessionId").val()){
    						$("#chat-box").append("<p class='me'>나 :" + d.msg + "</p>");	
    					}else{
    						$("#chat-box").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
    					}
    						
    				}else{
    					console.warn("unknown type!")
    				}
    			}
    		}

    		document.addEventListener("keypress", function(e){
    			if(e.keyCode == 13){ //enter press
    				send();
    			}
    		});
    	}

    	function send() {
    		var option ={
    			type: "message",
    			roomNumber: $("#roomNumber").val(),
    			sessionId : $("#sessionId").val(),
    			userName : $("#userName").val(),
    			msg : $("#chatting").val()
    		}
    		ws.send(JSON.stringify(option))
    		$('#chatting').val("");
    	}
    	
    	$('#chatting-send-btn').on("click", function(){
			send();    		
    	})
    	
    	/* 방 부분 */
    	//방 실제 생성
    	function startRoom(roomNumber, roomName){
    		$('#roomList').hide();
    		$('#roomNumber').val(roomNumber);
    	 	$('#chat-box').show();
    		$('#create-room-bar').hide();
    		$('#chatting-bar').show();
    		$('#room-title-content').text("[ "+roomName+" ]");
    		$('#room-title').show();
    		wsOpen(roomNumber);
    	}
    	
    	//방 실제 입장
    	function openRoom(roomNumber, roomName){
    		$('#roomList').hide();
    		$('#roomNumber').val(roomNumber);
    		$('#chat-box').show();
    		$('#create-room-bar').hide();
    		$('#chatting-bar').show();
    		$('#room-title-content').text("[ "+roomName+" ]");
    		$('#room-title').show();
    		wsOpen(roomNumber);
    	}
    	
    	//방 들어갈 수 있는지 확인
    	function goRoom(number){
    		console.log(number+" 방에 입장 시도");
    		
    		$.ajax({
  				url: "${root}/chat/goRoom?roomNumber=" + number, //방 번호를 던져준다.
  				type: "POST",
  				dataType: 'json',
  				contentType:'application/json; charset=utf-8',
  				statusCode:{
    					200: function(result){
    						console.log(result+" 방정보 획득")
    						openRoom(result.roomNumber, result.roomName);
    					},
    					304: function() {
    						alert("세션이 만료되었습니다.");
    						location.href="${root}/"
  							return false;
  						},
  						406: function() { 
  							alert("방의 인원이 꽉찼습니다.");
    						return;
    					},
    					409: function() { 
  							alert("방에 참여하지 못했습니다.");
  							getRoom();
    						return;
    					},
    					500: function() {
    						alert("서버에러.");
    					},
    					404: function() {
    						alert("페이지없다.");
    					}
  				}
  			})
    	}	
    	
    	//방 목록 불러오기
    	function getRoom(){
    		$.ajax({
  				url: "${root}/chat/getRoom",
  				type: "POST",
  				dataType: 'json',
  				contentType:'application/json; charset=utf-8',
  				statusCode:{
    					200: function(result){
    						if(result != null){
    			    			var tag = `<thead>
		    							      <tr>
				    					        <th style="width:10%">번호</th>
				    					        <th style="width:55%">방 이름</th>
				    					        <th style="width:15%">정원</th>
				    					        <th style="width:20%"></th>
				    					      </tr>
    					    			  </thead>			    
			    					      <tbody id="roomContainer">
			    					    
			    					      </tbody>`;
			    				$("#roomList").empty().append(tag);
			    				
			     				result.forEach(function(d){
    			    				let rn = d.roomName.trim();
    			    				let roomNumber = d.roomNumber;
    			    				let participatePerson = d.participatePerson;
    			    				tag = `<tr>
    			    							<td class='num'>${'${roomNumber+1}'}</td>
    			    							<td class='room'>${'${rn}'}</td>
    			    							<td class='participatePerson'>${'${participatePerson}'}/5</td>
    			    							<td class='go'><button type='button' class='btn btn-primary' id='goRoom-${'${roomNumber}'}'>참여</button></td>
    			    						</tr>`;
    			    					
    			    				$("#roomList").append(tag);
  									
     			    				$(`#goRoom-${'${roomNumber}'}`).on("click", function(){
      						   			goRoom(`${'${roomNumber}'}`);
      						   		}); 
    			    			});
	 	
    			    			console.log("방 정보 로드");
    			    		}else{
    			    			console.log("방 정보를 불러오지 못했습니다.");	    			
    			    		}
    					},
    					404: function() {
    						console.log("방을 불러오지 못했습니다.");
    					}
  				}
  			})
    	}		    				
		
    	//방 만들기 버튼 클릭
   		$("#createRoom").click(function(){
   			var msg = {	roomName : $('#roomName').val()	};

   			$.ajax({
  				url: "${root}/chat/createRoom?roomName=" + $('#roomName').val(), //방 이름을 던져준다.
  				type: "POST",
  				dataType: 'json',
  				contentType:'application/json; charset=utf-8',
  				statusCode:{
    					200: function(result){
    						startRoom(result.roomNumber, result.roomName);
    						return true;
    					},
    					304: function() {
    						alert("세션이 만료되었습니다.");
    						location.href="${root}/"
  							return false;
  						},
  						429: function() { 
  							alert("방이 꽉찼습니다.");
    						return;
    					},
    					500: function() {
    						alert("서버에러.");
    					},
    					404: function() {
    						alert("페이지없다.");
    					}
  				}
  			})

   			$("#roomName").val("");
   		});	
    	
    	//나가기 버튼: 들어가기의 반대
    	$('#chatting-exit-btn').on("click", function(){
    		$('#roomList').show();
    	 	$('#chat-box').hide();
    	 	$('#chat-box').val("");
    		$('#create-room-bar').show();
    		$('#chatting-bar').hide();
    		$('#room-title-content').text("");
    		$('#room-title').hide();
    		console.log("방 나가기 버튼 클릭 : "+$('#roomNumber').val());
    		$.ajax({
  				url: "${root}/chat/exitRoom?roomNumber=" + $('#roomNumber').val(), //방 번호를 던진다
  				type: "POST",
  				dataType: 'json',
  				contentType:'application/json; charset=utf-8',
  				statusCode:{
    					200: function(result){
    						$('#roomNumber').val("");
    					},
  						429: function() { 
    					},
    					500: function() {
    						alert("서버에러.");
    					},
    					404: function() {
    						alert("페이지없다.");
    					}
  				}
  			})
    		getRoom();
    	});
    	
    	
    	
    	getRoom();
		
    	
    	
    	/******************
    		Snapshot
    	 ******************/
    	 
    	 /* form: 집어넣는 이미지 html 틀 */    	 
    	 
    	 function snapshotMake(filename, path, type, order){
			let txt = `
			<div class="portfolio-item filter-${'${type}'}">
				<div class="m-3 portfolio-wrap" style="width:30%; height:150px; float: left; display:flex;
		            justify-content:center; align-items:center; border-radius: 1em;">
					<img src="${'${path}'}"
						class="img-fluid" alt="" style="display: block; margin: 0px auto;">
					<div class="portfolio-info">
						<h4>${'${filename}'}</h4>
						<p>${'${type}'}</p>
						<div class="portfolio-links">
							<a href="${'${path}'}"
								data-gallery="portfolioGallery" class="portfolio-lightbox"
								title="${'${filename}'}"><i class="bx bx-plus"></i></a>
								
							<span class="portfolio-details-lightbox snapshot-img-download" id="snapshot-img-download-${'${order}'}"
								title="Portfolio Details"><i
								class="bx bx-link"></i></span>
							<!--	
							<span class="portfolio-details-lightbox snapshot-img-delete" id="snapshot-img-delete-${'${order}'}"
								title="Portfolio Details"><i
								class="bx bx-trash"></i></span>
							-->
						</div>
					</div>
				</div>
			</div>
			`;
			return txt;
    	 }
    	 
    	function snapshot_add_event(){
    		$('.snapshot-img-download').on('click', function(){
    			let order = $(this).attr('id').replace('snapshot-img-download-','');
    			
       		 		let data = {
							 	order: order,
							 	userId: $('#userId').val(),
							 	platform : $('#board-register-platform').val()
				 			};
       		 		location.href="${root}/snapshot/download?userId="+$('#userId').val()+"&order="+order+"&platform="+platform;
       		 	
    		})
    	};
    	
    	
    	 $('#my-capture-btn').on("click", function(){
    		 $('#my-capture-edit-btn').show();
    		 $('#my-capture-add-btn').show();
    		 $('#my-capture-btn').hide();
    		 
    		 $('#snapshot-main-container').empty();
    	 });
    	
    	
    	 $('#basic-capture-btn').on("click", function(){
    		 $('#my-capture-edit-btn').hide();
    		 $('#my-capture-add-btn').hide();
    		 $('#my-capture-btn').show();
    		 
    		 $.ajax({
   				url: "${root}/snapshot/basic",
   				type: "POST",
   				dataType: 'json',
   				contentType:'application/json; charset=utf-8',
   				statusCode:{
     					200: function(result){
     						$('#snapshot-main-container').empty();
     						let txt_all = '';
     						result.forEach(function(data){
			    				let filename = data.filename.trim();
			    				let path = data.path;
			    				let type = data.type;
			    				let order = data.order;
			    				txt_all += snapshotMake(filename, path, type, order);
     						});
     						
			    			$('#snapshot-main-container').append(txt_all);
			    			snapshot_add_event();
     					},
   						429: function() { 
     					},
     					500: function() {
     						alert("서버에러.");
     					},
     					404: function() {
     						alert("페이지없다.");
     					}
   				}
   			})
    	 });
    	 $('#my-capture-btn').on("click", function(){
    		 let data = {
    					 	userId: $('#userId').val(),
    					 	platform: $('#board-register-platform').val()
    		 			};
    		 $.ajax({
    				url: "${root}/snapshot/user",
    				type: "POST",
    				dataType: 'json',
    				contentType:'application/json; charset=utf-8',
    				data: JSON.stringify(data),
    				statusCode:{
      					200: function(result){
      						$('#snapshot-main-container').empty();
      						let txt_all = '';
      						result.forEach(function(data){
 			    				let filename = data.filename.trim();
 			    				let path = data.path;
 			    				let type = data.type;
 			    				let order = data.order;
 			    				txt_all += snapshotMake(filename, path, type, order);
      						});
      						
 			    			$('#snapshot-main-container').append(txt_all);
 			    			snapshot_add_event();
      					},
    					429: function() { 
      					},
      					500: function() {
      						alert("서버에러.");
      					},
      					404: function() {
      						alert("페이지없다.");
      					}
    				}
    			});
    	 });
    	 
    	 $('#snapshot-modal-register').on("click", function(){
    		 //파일과 JSON을 묶어 보내기
    		 let data = {
    						filename: $('#snapshot-add-title').val(),
    						type: $('#snapshot-add-type').val()
    		 			};
    		
    		 let formData = new FormData();
    		 
    		 formData.append('file', $('#snapshot-file-upload')[0].files[0]); //파일을 넣고
    		 formData.append('key', new Blob([ JSON.stringify(data) ], {type : "application/json"})); //data를 다시 넣어줌
    		 
    		 console.log(formData);
    		 $.ajax({
    				url: "${root}/snapshot/register",
    				type: "POST",
    				processData: false,
    	            contentType:false,
    	            data: formData,
    				statusCode:{
      					200: function(result){
      						$('#snapshot-add-title').val("");
      						$('#snapshot-add-type').val("");
      						$('#snapshot-file-upload').val("");
      						alert("파일 업로드 성공");
      					},
    					429: function() { 
      					},
      					500: function() {
      						alert("서버에러.");
      					},
      					404: function() {
      						alert("페이지없다.");
      					}
    				}
    			});
    			
    	 });
    	 
    	 $('#basic-capture-btn').click();
  	})
  	
	
  </script>
  
</head>