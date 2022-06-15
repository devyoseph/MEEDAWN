
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%-- include 형식으로 header 문서 삽입 --%>

<body>
	<%-- NavBar: 스크롤을 위로 올릴 때 나오도록 조정해보기 --%>
	<nav
		class="navbar fixed-top justify-content-end navbar-expand-sm  navbar-light">
		<!-- Brand -->
		<ul class="navbar-nav">

			<!-- 세션에 로그인정보가 없을 때 로그인, 가입 메뉴 보여주기 -->
			<c:if test="${userInfo eq null }">
				<li class="nav-item">
					<a class="nav-link" href="#" id="login" data-target="#hero">LOGIN</a>
				</li>
				<li class="nav-item">
					<a id="join" class="nav-link" data-target="#hero">JOIN</a>
				</li>
			
			<!--  로그인 성공했을 때 닉네임을 올려주고 클릭 시 내 정보를 볼 수 있도록 하기 -->
			</c:if >
			
			
			<c:if test="${userInfo ne null }">
				<li class="nav-item">
					<a class="nav-link" data-target="#hero" style="font-weight: bolder;">${userInfo.userName } 님</a>
				</li>
			</c:if>
			
			<li class="nav-item"><a class="nav-link" href="#">POPULAR</a></li>

			<!-- Dropdown -->
			<!-- 세션에 로그인정보가 있을 때 회원 관련 메뉴 사용하도록 하기 -->
			<c:if test="${userInfo ne null }">
				<li class="nav-item dropdown" id="login-menu1">
					<a class="nav-link dropdown-toggle dropdown-toggle-split" href="#" id="navbardrop" data-toggle="dropdown">
						MyPage
					</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" id="my-info" data-target="#hero">회원정보</a>
						<a class="dropdown-item" href="#">장바구니</a>
						<a id="logout-btn" class="dropdown-item" href="#">로그아웃</a>
					</div></li>
			</c:if>
		</ul>
	</nav>

	<!-- NavBar End-->


	<!-- ======= Mobile nav toggle button ======= -->
	<!-- <button type="button" class="mobile-nav-toggle d-xl-none"><i class="bi bi-list mobile-nav-toggle"></i></button> -->
	<i class="bi bi-list mobile-nav-toggle d-xl-none"></i>
	<!-- ======= Header ======= -->
	<header id="header" class="d-flex flex-column justify-content-center">

		<nav id="navbar" class="navbar nav-menu">
			<ul>
				<li><a href="#hero" class="nav-link scrollto active"><i
						class="bx bx-home"></i> <span>Home</span></a></li>
				<!-- <li><a href="#about" class="nav-link scrollto"><i
						class="bx bx-user"></i> <span>About</span></a></li> -->
				<li><a href="#communication" class="nav-link scrollto"><i
						class="bx bx-file-blank"></i> <span>Communication</span></a></li>
				<li><a href="#portfolio" class="nav-link scrollto"><i
						class="bx bx-book-content"></i> <span>Portfolio</span></a></li>
				<li><a href="#contact" class="nav-link scrollto"><i
						class="bx bx-envelope"></i> <span>Chat</span></a></li>
				<li><a href="#services" class="nav-link scrollto"><i
						class="bx bx-server"></i> <span>Services</span></a></li>
			</ul>
		</nav>
		<!-- .nav-menu -->

	</header>
	<!-- End Header -->

	<!-- ======= Hero Section ======= -->

	<!-- 슬라이딩 참고 깃:  https://github.com/seiyria/bootstrap-slider -->
	<section id="hero" class="d-flex flex-column justify-content-center carousel slide" data-ride="carousel" data-interval="false">
		<div id="slider" class="carousel-inner">

			<div id="start-container" class="carousel-item active">
				<div class="container" data-aos="zoom-in" data-aos-delay="100">

					<c:if test="${userInfo eq null }">
						<h1 id="logout-msg1">백엔드 구현</h1>
					</c:if>

					<c:if test="${userInfo ne null }">
						<h1 id="login-msg1">${userInfo.userName }님 환영합니다!</h1>
					</c:if>

					<p>
						This is <span class="typed" data-typed-items="My Spring project, My Ambitious Trial for Back-end"></span>
					</p>
					<div class="social-links">
						<a href="#" class="twitter"><i class="bx bxl-twitter"></i></a> <a
							href="#" class="facebook"><i class="bx bxl-facebook"></i></a> <a
							href="#" class="instagram"><i class="bx bxl-instagram"></i></a> <a
							href="#" class="google-plus"><i class="bx bxl-skype"></i></a> <a
							href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
					</div>
				</div>
			</div>
			
			<c:if test="${userInfo ne null }">
				<!-- ======= 내 정보  ======= -->
				<div id="my-info-container"  class="carousel-item">
					<div id="my-info-container2" class="container">
						
				<div class="section-title">
					<h2>PROFILE</h2>
					<p><strong>${userInfo.userName }</strong>님은 현재 다이아 등급입니다.</p>
					</br>
				</div>

				<div class="row">
					<div class="col-lg-4">
						<img src="resources/img/portfolio/flower.png" class="img-fluid" alt="">
					</div>
					<div class="col-lg-8 pt-4 pt-lg-0 content">
						<h2>회원정보</h2>
						<div>
							<p class="fst-italic">ID: ${userInfo.userId }</p>
							</br>
							<c:if test="${userInfo.platform eq 'site'}">
							<p class="fst-italic">비밀번호 변경</p>
							<form class="form-group">
								<input type="hidden" id="userId" value="${userInfo.userId }">
								<input type="hidden" id="userName" value="${userInfo.userName }">
								<p> - 현재 비밀번호</p><input type="password" class="form-control" id="original-pwd">
								<p> - 변경 비밀번호</p><input type="password" class="form-control" id="new-pwd1">
								<p> - 비밀번호 확인</p><input type="password" class="form-control" id="new-pwd2">
								
								</br>
								<a id="my-info-msg"></a>
								</br>
								<div class="text-center">
									<button type="button" class="btn btn-outline-primary mt-2" id="new-pass-btn">변경하기</button>
								</div>
								
								<div class="text-right">
									<a id="user-out-btn" style="text-decoration: underline;">회원탈퇴</a>
								</div>
							</form>
							</c:if>
						</div>
				</div>

			</div>
		<!-- End About Section -->
						
						
						
					</div>
				</div>
			</c:if>
			
			
			<c:if test="${userInfo eq null }">
				<div class="carousel-item">
					<div class="container">
						<form id="login-form" action="" method="post">

							<div class="form-group text-left">
								<label for="login-userId">아이디</label><br>
								<input type="text" class="form-control" id="login-userId" name="userId">
							</div>

							<div class="form-group text-left">
								<label for="login-userPwd">비밀번호</label><br>
								<input type="password" class="form-control" id="login-userPwd" name="userPwd">
							</div>
							
							<div class="form-group text-center">
								<button type="button" class="btn btn-outline-primary" id="login-btn">로그인</button>
							</div>
							<!--로그인 버튼을 누르면 로그인이 되고 있다는 자바스크립트 사용
              <button class="btn btn-primary" disabled>
              <span class="spinner-grow spinner-grow-sm"></span>
                Loading..
              </button>-->
						</form>
					</div>
				</div>


				<div class="carousel-item">
					<div class="container">

						<form id="register-form" method="post">

							<div class="form-group text-left">
								<label for="register-userId">아이디</label><br>
								<input type="text" class="form-control" id="register-userId" name="userId">
							</div>

							
							<div class="form-group text-left">
								<label for="register-userName">닉네임</label><br>
								<input type="text" class="form-control" id="register-userName" name="userName">
							</div>
				
							<div class="form-group text-left">
								<label for="register-userPwd">비밀번호</label><br>
								<input type="password" class="form-control" id="register-userPwd" name="userPwd">
							</div>

							<div class="form-group text-left">
								<label for="register-userPwd2">비밀번호 확인</label><br>
								<input type="password" class="form-control" id="register-userPwd2" name="userPwd2">
							</div>
							
							<div class="form-group text-left">
								<label for="register-gender">성별</label>
								<div class="d-flex justify-content-around">
								<div><input type="radio"  id="register-gender-m" name="userGender" value="M" style="margin-right:5px;"><label for="register-gender-m">남자</label></div>
								<div><input type="radio"  id="register-gender-w" name="userGender" value="W" style="margin-right:5px;"><label for="register-gender-w">여자</label></div>
								</div>
							</div>
							
							<div class="form-group text-left">
								<label for="register-userEmail">이메일</label><br>
								<input type="email" class="form-control" id="register-userEmail" name="userEmail">
							</div>

							<div class="form-group">
								<a id="register-msg"></a>
							</div>
							
							<!-- 회원가입 버튼 -->
							<div class="form-group">
								<button type="button" class="btn btn-outline-primary float-right" id="user-register-btn">회원가입</button>
							</div>
							<!-- 네이버 로그인, 카카오 로그인-->
							<div class="form-group">
								<a href="${root }/naver/register" class="float-right"><img src="resources/img/naver/btnW.png" style="width: 20%;"></a>
							</div>
							<!-- 카카오 로그인-->
							<div class="form-group">
								<a href="${root }/kakao/register" class="float-left"><img src="resources/img/kakao/ko/kakao_login_medium_narrow.png" style="width: 80%;"></a>
							</div>
							
							<!--로그인 버튼을 누르면 로그인이 되고 있다는 자바스크립트 사용
              <button class="btn btn-primary" disabled>
              <span class="spinner-grow spinner-grow-sm"></span>
                Loading..
              </button>-->
						</form>
					</div>
				</div>
			</c:if>
		</div>

	</section>
	<!-- End Hero -->

	<main id="main">


		<!-- ======= Facts Section ======= -->
		<!-- <section id="facts" class="facts">
			<div class="container" data-aos="fade-up">

				<div class="section-title">
					<h2>Facts</h2>
					<p>Magnam dolores commodi suscipit. Necessitatibus eius
						consequatur ex aliquid fuga eum quidem. Sit sint consectetur
						velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit
						suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem
						hic quas.</p>
				</div>

				<div class="row">

					<div class="col-lg-3 col-md-6">
						<div class="count-box">
							<i class="bi bi-emoji-smile"></i> <span
								data-purecounter-start="0" data-purecounter-end="232"
								data-purecounter-duration="1" class="purecounter"></span>
							<p>Happy Clients</p>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 mt-5 mt-md-0">
						<div class="count-box">
							<i class="bi bi-journal-richtext"></i> <span
								data-purecounter-start="0" data-purecounter-end="521"
								data-purecounter-duration="1" class="purecounter"></span>
							<p>Projects</p>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 mt-5 mt-lg-0">
						<div class="count-box">
							<i class="bi bi-headset"></i> <span data-purecounter-start="0"
								data-purecounter-end="1463" data-purecounter-duration="1"
								class="purecounter"></span>
							<p>Hours Of Support</p>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 mt-5 mt-lg-0">
						<div class="count-box">
							<i class="bi bi-award"></i> <span data-purecounter-start="0"
								data-purecounter-end="25" data-purecounter-duration="1"
								class="purecounter"></span>
							<p>Awards</p>
						</div>
					</div>

				</div>

			</div>
		</section> -->
		<!-- End Facts Section -->

		<!-- ======= Skills Section ======= -->
	<!-- 	<section id="skills" class="skills section-bg">
			<div class="container" data-aos="fade-up">

				<div class="section-title">
					<h2>Skills</h2>
					<p>Magnam dolores commodi suscipit. Necessitatibus eius
						consequatur ex aliquid fuga eum quidem. Sit sint consectetur
						velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit
						suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem
						hic quas.</p>
				</div>

				<div class="row skills-content">

					<div class="col-lg-6">

						<div class="progress">
							<span class="skill">HTML <i class="val">100%</i></span>
							<div class="progress-bar-wrap">
								<div class="progress-bar" role="progressbar" aria-valuenow="100"
									aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>

						<div class="progress">
							<span class="skill">CSS <i class="val">90%</i></span>
							<div class="progress-bar-wrap">
								<div class="progress-bar" role="progressbar" aria-valuenow="90"
									aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>

						<div class="progress">
							<span class="skill">JavaScript <i class="val">75%</i></span>
							<div class="progress-bar-wrap">
								<div class="progress-bar" role="progressbar" aria-valuenow="75"
									aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>

					</div>

					<div class="col-lg-6">

						<div class="progress">
							<span class="skill">PHP <i class="val">80%</i></span>
							<div class="progress-bar-wrap">
								<div class="progress-bar" role="progressbar" aria-valuenow="80"
									aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>

						<div class="progress">
							<span class="skill">WordPress/CMS <i class="val">90%</i></span>
							<div class="progress-bar-wrap">
								<div class="progress-bar" role="progressbar" aria-valuenow="90"
									aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>

						<div class="progress">
							<span class="skill">Photoshop <i class="val">55%</i></span>
							<div class="progress-bar-wrap">
								<div class="progress-bar" role="progressbar" aria-valuenow="55"
									aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>

					</div>

				</div>

			</div>
		</section> -->
		<!-- End Skills Section -->

		<!-- ======= communication Section ======= -->
		<section id="communication" class="communication">
			<div class="container" data-aos="fade-up">

				<div class="section-title">
					<h1>소통 공간</h1>
					<p> &lt;공지사항은 게시판 맨 위 아래 내용은 많으면 짤라서 보여주기&gt;</p>
				</div>

			  <h2>자유게시판</h2>
			  <p>※ 자유게시판 이용수칙을 지켜주시기 바랍니다. 욕설, 비방, 광고 등 금지</p>            
			  <table id="board-entire" class="table table-hover">
			    <thead>
			      <tr>
			        <th style="width:20%">제목</th>
			        <th style="width:35%">내용</th>
			        <th style="width:10%">닉네임</th>
			        <th style="width:5%"></th>
			      </tr>
			    </thead>
			    <tbody id="board-content">
			    </tbody>
			  </table>
			  
		<c:if test="${userInfo ne null }">
			  <div class="form-group text-right">
				<button type="button" class="btn btn-outline-warning" data-toggle="modal" data-target="#myModal">글작성</button>
			  </div>
		</c:if>
			</div>
	
		</section>
		<!-- End Resume Section -->
		
		<c:if test="${userInfo ne null }">
		<!-- The Modal: 글쓰기용 모달 -->
		<form class="modal" id="myModal">
		  <input type="hidden" id="board-register-userid" value="${userInfo.userId }">
		  <input type="hidden" id="board-register-username" value="${userInfo.userName }">
		  <input type="hidden" id="board-register-platform" value="${userInfo.platform }">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">글 작성</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body container">
		       	<div class="form-group">
					<input type="text" class="form-control" placeholder="글 제목을 입력하세요" id="board-register-subject" name="board-register-subject">
				</div>
				<div id="summernote"></div>
		      </div>
		
		      <!-- Modal footer -->
		      
		      <div class="modal-footer">
		      	<a id="board-register-msg" style="color:gray; font-weight: bolder;"></a>
		      	<button type="button" class="btn btn-outline-primary" id="board-register-btn">등록</button>
		        <button type="button" class="btn btn-outline-danger"  id="board-register-close" data-dismiss="modal">닫기</button>
		      </div>
			  
		    </div>
		  </div>
		</form>
		
		
		<!-- The Modal: 글수정용 모달 -->
		<form class="modal" id="myModal2">
		  <input type="hidden" id="board-register-id2">
		  <input type="hidden" id="board-register-userid2" value="${userInfo.userId }">
		  <input type="hidden" id="board-register-username2" value="${userInfo.userName }">
		 
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">글 수정</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body container">
		       	<div class="form-group">
					<input type="text" class="form-control" placeholder="글 제목을 입력하세요" id="board-register-subject2" name="board-register-subject">
				</div>
				<div id="summernote2"></div>
		      </div>
		
		      <!-- Modal footer -->
		      
		      <div class="modal-footer">
		      	<a id="board-edit-msg" style="color:gray; font-weight: bolder;"></a>
		      	<button type="button" class="btn btn-outline-primary" id="board-edit-btn">수정</button>
		      	<button type="button" class="btn btn-danger" id="board-delete-btn">삭제</button>
		        <button type="button" class="btn btn-outline-danger"  id="board-register-close2" data-dismiss="modal">닫기</button>
		      </div>
			  
		    </div>
		  </div>
		</form>
		</c:if>
		
		
		
		<!-- ======= Portfolio Section ======= -->
		<section id="portfolio" class="portfolio section-bg">
			<div class="container" data-aos="fade-up">

				<div class="section-title">
					<h2>Portfolio</h2>
					<p>Magnam dolores commodi suscipit. Necessitatibus eius
						consequatur ex aliquid fuga eum quidem. Sit sint consectetur
						velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit
						suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem
						hic quas.</p>
				</div>

				<div class="row">
					<div class="col-lg-12 d-flex justify-content-center"
						data-aos="fade-up" data-aos-delay="100">
						<ul id="portfolio-flters">
							<li data-filter="*" class="filter-active">All</li>
							<li data-filter=".filter-app">App</li>
							<li data-filter=".filter-card">Card</li>
							<li data-filter=".filter-web">Web</li>
						</ul>
					</div>
				</div>

				<div class="row portfolio-container" data-aos="fade-up"
					data-aos-delay="200">

					<div class="col-lg-4 col-md-6 portfolio-item filter-app">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-1.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>App 1</h4>
								<p>App</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-1.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="App 1"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-web">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-2.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>Web 3</h4>
								<p>Web</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-2.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="Web 3"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-app">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-3.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>App 2</h4>
								<p>App</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-3.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="App 2"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-card">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-4.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>Card 2</h4>
								<p>Card</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-4.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="Card 2"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-web">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-5.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>Web 2</h4>
								<p>Web</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-5.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="Web 2"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-app">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-6.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>App 3</h4>
								<p>App</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-6.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="App 3"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-card">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-7.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>Card 1</h4>
								<p>Card</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-7.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="Card 1"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-card">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-8.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>Card 3</h4>
								<p>Card</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-8.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="Card 3"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 portfolio-item filter-web">
						<div class="portfolio-wrap">
							<img src="resources/img/portfolio/portfolio-9.jpg"
								class="img-fluid" alt="">
							<div class="portfolio-info">
								<h4>Web 3</h4>
								<p>Web</p>
								<div class="portfolio-links">
									<a href="resources/img/portfolio/portfolio-9.jpg"
										data-gallery="portfolioGallery" class="portfolio-lightbox"
										title="Web 3"><i class="bx bx-plus"></i></a> <a
										href="portfolio-details.html"
										class="portfolio-details-lightbox"
										data-glightbox="type: external" title="Portfolio Details"><i
										class="bx bx-link"></i></a>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
		</section>
		<!-- End Portfolio Section -->
		
		<!-- ======= Contact Section ======= -->
		<section id="contact" class="contact">
			<div class="container" data-aos="fade-up">

				<div class="section-title">
					<h2>Chat</h2>
				</div>
				
				<table id="roomList" class="table table-hover text-center">
				    <thead>
				      <tr>
				        <th style="width:100%">채팅방이 존재하지 않습니다</th>
				      </tr>
				    </thead>
			   </table>
				
				<div>
					<table class="inputTable">
						<tr>	
							<th>방 제목</th>
							<th><input type="text" name="roomName" id="roomName"></th>
							<th><button id="createRoom">방 만들기</button></th>
						</tr>
					</table>
				</div>
		
			</div>
		</section>
		<!-- End Contact Section -->
		
		
		
		<!-- ======= Services Section ======= -->
		<section id="services" class="services">
			<div class="container" data-aos="fade-up">

				<div class="section-title">
					<h2>Services</h2>
					<p>Magnam dolores commodi suscipit. Necessitatibus eius
						consequatur ex aliquid fuga eum quidem. Sit sint consectetur
						velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit
						suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem
						hic quas.</p>
				</div>

				<div class="row">

					<div class="col-lg-4 col-md-6 d-flex align-items-stretch"
						data-aos="zoom-in" data-aos-delay="100">
						<div class="icon-box iconbox-blue">
							<div class="icon">
								<svg width="100" height="100" viewBox="0 0 600 600"
									xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5"
										d="M300,521.0016835830174C376.1290562159157,517.8887921683347,466.0731472004068,529.7835943286574,510.70327084640275,468.03025145048787C554.3714126377745,407.6079735673963,508.03601936045806,328.9844924480964,491.2728898941984,256.3432110539036C474.5976632858925,184.082847569629,479.9380746630129,96.60480741107993,416.23090153303,58.64404602377083C348.86323505073057,18.502131276798302,261.93793281208167,40.57373210992963,193.5410806939664,78.93577620505333C130.42746243093433,114.334589627462,98.30271207620316,179.96522072025542,76.75703585869454,249.04625023123273C51.97151888228291,328.5150500222984,13.704378332031375,421.85034740162234,66.52175969318436,486.19268352777647C119.04800174914682,550.1803526380478,217.28368757567262,524.383925680826,300,521.0016835830174"></path>
                </svg>
								<i class="bx bxl-dribbble"></i>
							</div>
							<h4>
								<a href="">Lorem Ipsum</a>
							</h4>
							<p>Voluptatum deleniti atque corrupti quos dolores et quas
								molestias excepturi</p>
						</div>
					</div>

					<div
						class="col-lg-4 col-md-6 d-flex align-items-stretch mt-4 mt-md-0"
						data-aos="zoom-in" data-aos-delay="200">
						<div class="icon-box iconbox-orange ">
							<div class="icon">
								<svg width="100" height="100" viewBox="0 0 600 600"
									xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5"
										d="M300,582.0697525312426C382.5290701553225,586.8405444964366,449.9789794690241,525.3245884688669,502.5850820975895,461.55621195738473C556.606425686781,396.0723002908107,615.8543463187945,314.28637112970534,586.6730223649479,234.56875336149918C558.9533121215079,158.8439757836574,454.9685369536778,164.00468322053177,381.49747125262974,130.76875717737553C312.15926192815925,99.40240125094834,248.97055460311594,18.661163978235184,179.8680185752513,50.54337015887873C110.5421016452524,82.52863877960104,119.82277516462835,180.83849132639028,109.12597500060166,256.43424936330496C100.08760227029461,320.3096726198365,92.17705696193138,384.0621239912766,124.79988738764834,439.7174275375508C164.83382741302287,508.01625554203684,220.96474134820875,577.5009287672846,300,582.0697525312426"></path>
                </svg>
								<i class="bx bx-file"></i>
							</div>
							<h4>
								<a href="">Sed Perspiciatis</a>
							</h4>
							<p>Duis aute irure dolor in reprehenderit in voluptate velit
								esse cillum dolore</p>
						</div>
					</div>

					<div
						class="col-lg-4 col-md-6 d-flex align-items-stretch mt-4 mt-lg-0"
						data-aos="zoom-in" data-aos-delay="300">
						<div class="icon-box iconbox-pink">
							<div class="icon">
								<svg width="100" height="100" viewBox="0 0 600 600"
									xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5"
										d="M300,541.5067337569781C382.14930387511276,545.0595476570109,479.8736841581634,548.3450877840088,526.4010558755058,480.5488172755941C571.5218469581645,414.80211281144784,517.5187510058486,332.0715597781072,496.52539010469104,255.14436215662573C477.37192572678356,184.95920475031193,473.57363656557914,105.61284051026155,413.0603344069578,65.22779650032875C343.27470386102294,18.654635553484475,251.2091493199835,5.337323636656869,175.0934190732945,40.62881213300186C97.87086631185822,76.43348514350839,51.98124368387456,156.15599469081315,36.44837278890362,239.84606092416172C21.716077023791087,319.22268207091537,43.775223500013084,401.1760424656574,96.891909868211,461.97329694683043C147.22146801428983,519.5804099606455,223.5754009179313,538.201503339737,300,541.5067337569781"></path>
                </svg>
								<i class="bx bx-tachometer"></i>
							</div>
							<h4>
								<a href="">Magni Dolores</a>
							</h4>
							<p>Excepteur sint occaecat cupidatat non proident, sunt in
								culpa qui officia</p>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 d-flex align-items-stretch mt-4"
						data-aos="zoom-in" data-aos-delay="100">
						<div class="icon-box iconbox-yellow">
							<div class="icon">
								<svg width="100" height="100" viewBox="0 0 600 600"
									xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5"
										d="M300,503.46388370962813C374.79870501325706,506.71871716319447,464.8034551963731,527.1746412648533,510.4981551193396,467.86667711651364C555.9287308511215,408.9015244558933,512.6030010748507,327.5744911775523,490.211057578863,256.5855673507754C471.097692560561,195.9906835881958,447.69079081568157,138.11976852964426,395.19560036434837,102.3242989838813C329.3053358748298,57.3949838291264,248.02791733380457,8.279543830951368,175.87071277845988,42.242879143198664C103.41431057327972,76.34704239035025,93.79494320519305,170.9812938413882,81.28167332365135,250.07896920659033C70.17666984294237,320.27484674793965,64.84698225790005,396.69656628748305,111.28512138212992,450.4950937839243C156.20124167950087,502.5303643271138,231.32542653798444,500.4755392045468,300,503.46388370962813"></path>
                </svg>
								<i class="bx bx-layer"></i>
							</div>
							<h4>
								<a href="">Nemo Enim</a>
							</h4>
							<p>At vero eos et accusamus et iusto odio dignissimos ducimus
								qui blanditiis</p>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 d-flex align-items-stretch mt-4"
						data-aos="zoom-in" data-aos-delay="200">
						<div class="icon-box iconbox-red">
							<div class="icon">
								<svg width="100" height="100" viewBox="0 0 600 600"
									xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5"
										d="M300,532.3542879108572C369.38199826031484,532.3153073249985,429.10787420159085,491.63046689027357,474.5244479745417,439.17860296908856C522.8885846962883,383.3225815378663,569.1668002868075,314.3205725914397,550.7432151929288,242.7694973846089C532.6665558377875,172.5657663291529,456.2379748765914,142.6223662098291,390.3689995646985,112.34683881706744C326.66090330228417,83.06452184765237,258.84405631176094,53.51806209861945,193.32584062364296,78.48882559362697C121.61183558270385,105.82097193414197,62.805066853699245,167.19869350419734,48.57481801355237,242.6138429142374C34.843463184063346,315.3850353017275,76.69343916112496,383.4422959591041,125.22947124332185,439.3748458443577C170.7312796277747,491.8107796887764,230.57421082200815,532.3932930995766,300,532.3542879108572"></path>
                </svg>
								<i class="bx bx-slideshow"></i>
							</div>
							<h4>
								<a href="">Dele Cardo</a>
							</h4>
							<p>Quis consequatur saepe eligendi voluptatem consequatur
								dolor consequuntur</p>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 d-flex align-items-stretch mt-4"
						data-aos="zoom-in" data-aos-delay="300">
						<div class="icon-box iconbox-teal">
							<div class="icon">
								<svg width="100" height="100" viewBox="0 0 600 600"
									xmlns="http://www.w3.org/2000/svg">
                  <path stroke="none" stroke-width="0" fill="#f5f5f5"
										d="M300,566.797414625762C385.7384707136149,576.1784315230908,478.7894351017131,552.8928747891023,531.9192734346935,484.94944893311C584.6109503024035,417.5663521118492,582.489472248146,322.67544863468447,553.9536738515405,242.03673114598146C529.1557734026468,171.96086150256528,465.24506316201064,127.66468636344209,395.9583748389544,100.7403814666027C334.2173773831606,76.7482773500951,269.4350130405921,84.62216499799875,207.1952322260088,107.2889140133804C132.92018162631612,134.33871894543012,41.79353780512637,160.00259165414826,22.644507872594943,236.69541883565114C3.319112789854554,314.0945973066697,72.72355303640163,379.243833228382,124.04198916343866,440.3218312028393C172.9286146004772,498.5055451809895,224.45579914871206,558.5317968840102,300,566.797414625762"></path>
                </svg>
								<i class="bx bx-arch"></i>
							</div>
							<h4>
								<a href="">Divera Don</a>
							</h4>
							<p>Modi nostrum vel laborum. Porro fugit error sit minus
								sapiente sit aspernatur</p>
						</div>
					</div>

				</div>

			</div>
		</section>
		<!-- End Services Section -->
		
		<!-- ======= Testimonials Section ======= -->
		<section id="testimonials" class="testimonials section-bg">
			<div class="container" data-aos="fade-up">

				<div class="section-title">
					<h2>Testimonials</h2>
				</div>

				<div class="testimonials-slider swiper" data-aos="fade-up"
					data-aos-delay="100">
					<div class="swiper-wrapper">

						<div class="swiper-slide">
							<div class="testimonial-item">
								<img src="resources/img/testimonials/testimonials-1.jpg"
									class="testimonial-img" alt="">
								<h3>Saul Goodman</h3>
								<h4>Ceo &amp; Founder</h4>
								<p>
									<i class="bx bxs-quote-alt-left quote-icon-left"></i> Proin
									iaculis purus consequat sem cure digni ssim donec porttitora
									entum suscipit rhoncus. Accusantium quam, ultricies eget id,
									aliquam eget nibh et. Maecen aliquam, risus at semper. <i
										class="bx bxs-quote-alt-right quote-icon-right"></i>
								</p>
							</div>
						</div>
						<!-- End testimonial item -->

						<div class="swiper-slide">
							<div class="testimonial-item">
								<img src="resources/img/testimonials/testimonials-2.jpg"
									class="testimonial-img" alt="">
								<h3>Sara Wilsson</h3>
								<h4>Designer</h4>
								<p>
									<i class="bx bxs-quote-alt-left quote-icon-left"></i> Export
									tempor illum tamen malis malis eram quae irure esse labore quem
									cillum quid cillum eram malis quorum velit fore eram velit sunt
									aliqua noster fugiat irure amet legam anim culpa. <i
										class="bx bxs-quote-alt-right quote-icon-right"></i>
								</p>
							</div>
						</div>
						<!-- End testimonial item -->

						<div class="swiper-slide">
							<div class="testimonial-item">
								<img src="resources/img/testimonials/testimonials-3.jpg"
									class="testimonial-img" alt="">
								<h3>Jena Karlis</h3>
								<h4>Store Owner</h4>
								<p>
									<i class="bx bxs-quote-alt-left quote-icon-left"></i> Enim nisi
									quem export duis labore cillum quae magna enim sint quorum
									nulla quem veniam duis minim tempor labore quem eram duis
									noster aute amet eram fore quis sint minim. <i
										class="bx bxs-quote-alt-right quote-icon-right"></i>
								</p>
							</div>
						</div>
						<!-- End testimonial item -->

						<div class="swiper-slide">
							<div class="testimonial-item">
								<img src="resources/img/testimonials/testimonials-4.jpg"
									class="testimonial-img" alt="">
								<h3>Matt Brandon</h3>
								<h4>Freelancer</h4>
								<p>
									<i class="bx bxs-quote-alt-left quote-icon-left"></i> Fugiat
									enim eram quae cillum dolore dolor amet nulla culpa multos
									export minim fugiat minim velit minim dolor enim duis veniam
									ipsum anim magna sunt elit fore quem dolore labore illum
									veniam. <i class="bx bxs-quote-alt-right quote-icon-right"></i>
								</p>
							</div>
						</div>
						<!-- End testimonial item -->

						<div class="swiper-slide">
							<div class="testimonial-item">
								<img src="resources/img/testimonials/testimonials-5.jpg"
									class="testimonial-img" alt="">
								<h3>John Larson</h3>
								<h4>Entrepreneur</h4>
								<p>
									<i class="bx bxs-quote-alt-left quote-icon-left"></i> Quis
									quorum aliqua sint quem legam fore sunt eram irure aliqua
									veniam tempor noster veniam enim culpa labore duis sunt culpa
									nulla illum cillum fugiat legam esse veniam culpa fore nisi
									cillum quid. <i class="bx bxs-quote-alt-right quote-icon-right"></i>
								</p>
							</div>
						</div>
						<!-- End testimonial item -->

					</div>
					<div class="swiper-pagination"></div>
				</div>

			</div>
		</section>
		<!-- End Testimonials Section -->


	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<footer id="footer">
		<div class="container">
			<h3>Brandon Johnson</h3>
			<p>Et aut eum quis fuga eos sunt ipsa nihil. Labore corporis
				magni eligendi fuga maxime saepe commodi placeat.</p>
			<div class="social-links">
				<a href="#" class="twitter"><i class="bx bxl-twitter"></i></a> <a
					href="#" class="facebook"><i class="bx bxl-facebook"></i></a> <a
					href="#" class="instagram"><i class="bx bxl-instagram"></i></a> <a
					href="#" class="google-plus"><i class="bx bxl-skype"></i></a> <a
					href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
			</div>
			<div class="copyright">
				&copy; Copyright <strong><span>MyResume</span></strong>. All Rights
				Reserved
			</div>
			<div class="credits">
				<!-- All the links in the footer should remain intact. -->
				<!-- You can delete the links only if you purchased the pro version. -->
				<!-- Licensing information: [license-url] -->
				<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/free-html-bootstrap-template-my-resume/ -->
				Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
			</div>
		</div>
	</footer>
	<!-- End Footer -->

	<div id="preloader"></div>
	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="resources/vendor/purecounter/purecounter.js"></script>
	<script src="resources/vendor/aos/aos.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="resources/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="resources/vendor/typed.js/typed.min.js"></script>
	<script src="resources/vendor/waypoints/noframework.waypoints.js"></script>
	<script src="resources/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="resources/js/main.js"></script>

</body>

</html>


