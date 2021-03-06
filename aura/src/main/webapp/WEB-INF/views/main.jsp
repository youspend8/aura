<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	<title>All Review</title>
	<style>
		.fade {
		  	transition: opacity 0.4s linear;
		}
	</style>
	<script>
		$(function() {
			var index = 1;
			var images = [
				'/img/main/full_background1.jpg',
				'/img/main/full_background2.png',
				'/img/main/full_background3.png',
				'/img/main/full_background4.png'
			];
			setInterval(() => {
				$('#background').attr('class', 'fade hide')
				setTimeout(() => {
					$('#background').attr('class', 'fade show')
					$('#background').css({
						'background-image': 'url(' + images[index] + ')'
					})
					if (index++ == 3) {
						index = 0;
					}
				}, 500);
			}, 4000);
		});
	</script>
	<div id="header">
		<a href="/main" class="brand_logo">
			<img src="/img/logo/blacklogo.png" width="130px" class="pt-1">
		</a>
		<div id="search_form" class="search_form col-md-6 col-12 p-0">
			<form class="form-check-inline w-100" id="origin_search_form" action="/review/search">
				<select class="form-control search_select" name="type">
					<option value="1">음식점</option>
					<option value="2">병원</option>
					<option value="3">전자제품</option>
				</select>
				
				<input class="form-control search_input" type="text" name="keyword" placeholder="Search" autocomplete="off">
			
				<button type="submit" class="fas text-dark ml-md-2 ml-0 fa-search" style="font-size: 20px; background-color: transparent; border: 0px transparent solid;"></button>
			</form>
		</div>
		<div style="height: 100px;"></div>
	</div>
	
	<script>
		document.onscroll = function() {
			var isSearchFormInNav = false;
			var nav_search_form = $('#navigation_search_form');
			var origin_search_form = $('#origin_search_form');
			var search_form = $('#search_form');
			
			console.log(window.scrollY)
			if (window.scrollY > 200) {
				isSearchFormInNav = true;
				nav_search_form.append(origin_search_form);
				$('#navigation').css({
					'position': 'sticky',
					'top': 0
				})
			} else if (window.scrollY <= 200) {
				isSearchFormInNav = false;
				search_form.append(origin_search_form);
				$('#navigation').css({
					'position': 'sticky',
					'top': 0
				})
			}
		}
	</script>
  <!-- 인기리뷰시작 -->
  
  	<div id="background"></div>
<div style="z-index: 1; background-color: white; position: relative;">
	<div class="container">
	    <h5 class="pt-4 m-0 text-center text-danger" style="font-weight: bold;">Popular Review</h5>
	    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel" data-interval="false">
			<div class="carousel-inner">
				<c:forEach var="i" begin="0" end="2">
					<div class="carousel-item ${i == 0 ? 'active' : ''}">
						<div class="d-flex flex-wrap w-100 justify-content-center tl">
							<c:forEach var="j" begin="${i * 5}" end="${i * 5 + 4}">
								<div class="win">
									<div class="card-jisung">
										<a href="/review/post?num=${popReview[j].num}&type=${popReview[j].type}">
											<div class="cardtitle" style="background-color: #ffffff">
												<div class="my-1 text-primary font-weight-bold" style="font-size: 130%;">
													${popReview[j].title}
<!-- 												    <span class="text-dark ml-1" style="font-size: 60%;"> -->
<%-- 														<c:choose> --%>
<%-- 															<c:when test="${popReview[j].type eq 1}"> --%>
<!-- 																음식점 -->
<%-- 															</c:when> --%>
<%-- 															<c:when test="${popReview[j].type eq 2}"> --%>
<!-- 																병원 -->
<%-- 															</c:when> --%>
<%-- 															<c:when test="${popReview[j].type eq 3}"> --%>
<!-- 																전자제품 -->
<%-- 															</c:when> --%>
<%-- 														</c:choose> --%>
<!-- 													</span> -->
												</div>
											    <span class="float-left font-weight-bolder text-dark">
											    	<c:forEach var="i" begin="0" end="4">
											    		<c:if test="${popReview[j].stars - i >= 1}">
												    		<i style="color: rgb(255, 153, 0);" class="fas fa-star"></i>
										    			</c:if>
										    			<c:if test="${popReview[j].stars - i < 1 && popReview[j].stars - i > 0}">
											    			<i style="color: rgb(255, 153, 0);" class="fas fa-star-half-alt"></i>
											    		</c:if>
											    		<c:if test="${popReview[j].stars - i <= 0}">
												    		<i style="color: rgb(255, 153, 0);" class="far fa-star"></i>
											    		</c:if>
											    	</c:forEach>
											    	<c:if test="${popReview[j].stars != 0}">
											    		<fmt:formatNumber value="${popReview[j].stars}" pattern=".0" />
											    	</c:if>
											    	<c:if test="${popReview[j].stars == 0}">
											    		<fmt:formatNumber value="${popReview[j].stars}" pattern="0" />
											    	</c:if>
											    </span>
											    
											    <span class="float-right text-dark font-weight-bold">
												    <i class="fas fa-thumbs-up"></i>
											    	${popReview[j].goods}
											    </span>
										    </div>
										</a>
										
										<div class="cardcontent">
											<div style="height: 87%; overflow: hidden; font-size: 150%">
												${popReview[j].contents}
											</div>
											<a href="/review/post?num=${popReview[j].num}&type=${popReview[j].type}" style="padding-top: 4%; display: inline-block; font-size: 150%; height: 13%; overflow: hidden; float: right;">
												자세히보기
											</a>
										</div>
										
										<div class="cardpic bg-white text-center">
											<c:if test="${popReview[j].files.size() eq 0 }">
												<img src="/img/NoImg.jpg" style="width: 50%;" />
											</c:if>
											<c:if test="${popReview[j].files.size() ne 0 }">
												<img src="${popReview[j].files[0]}" />
											</c:if>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="col-12 d-flex justify-content-center mb-4">
			<a class="mr-3 text-center d-flex justify-content-center align-items-center" href="#carouselExampleControls" role="button" data-slide="prev"
					style="background-color: orange; border-radius: 50%; width: 40px; height: 40px;">
				<i class="fas fa-chevron-left" style="color: white"></i>
			</a>
			<a class="ml-3 text-center d-flex justify-content-center align-items-center" href="#carouselExampleControls" role="button" data-slide="next"
					style="background-color: orange; border-radius: 50%; width: 40px; height: 40px;">
				<i class="fas fa-chevron-right " style="color: white"></i>
			</a>
		</div>
	</div>

	<hr />
	<!-- 인기리뷰끝 -->
  
	<!-- 최신리뷰시작 -->
	<div class="container ">
		<h5 class="pt-4 m-0 text-center text-danger" style="font-weight: bold;">New Review</h5>
		<div id="carouselExampleControls2" class="carousel slide" data-ride="carousel" data-interval="false">
			<div class="carousel-inner">
				<c:forEach var="i" begin="0" end="2">
					<div class="carousel-item ${i == 0 ? 'active' : ''}">
						<div class="d-flex flex-wrap w-100 justify-content-center tl">
							<c:forEach var="j" begin="${i * 5}" end="${i * 5 + 4}">
								<div class="win">
									<div class="card-jisung">
										<a href="/review/post?num=${newReview[j].num}&type=${newReview[j].type}">
											<div class="cardtitle" style="background-color: #ffffff">
												<div class="my-1 text-primary font-weight-bold" style="font-size: 130%;">
													${newReview[j].title}
												</div>
											    <span>
											    	<c:forEach var="i" begin="0" end="4">
											    		<c:if test="${newReview[j].stars - i >= 1}">
												    		<i style="color: rgb(255, 153, 0);" class="fas fa-star"></i>
										    			</c:if>
										    			<c:if test="${newReview[j].stars - i < 1 && newReview[j].stars - i > 0}">
											    			<i style="color: rgb(255, 153, 0);" class="fas fa-star-half-alt"></i>
											    		</c:if>
											    		<c:if test="${newReview[j].stars - i <= 0}">
												    		<i style="color: rgb(255, 153, 0);" class="far fa-star"></i>
											    		</c:if>
											    	</c:forEach>
											    </span>
											    <span class="ml-1 font-weight-bolder text-dark">
											    	<c:if test="${newReview[j].stars != 0}">
											    		<fmt:formatNumber value="${newReview[j].stars}" pattern=".0" />
											    	</c:if>
											    	<c:if test="${newReview[j].stars == 0}">
											    		<fmt:formatNumber value="${newReview[j].stars}" pattern="0" />
											    	</c:if>
											    </span>
											    <span class="text-dark ml-1" style="font-size: 70%;">
													<c:choose>
														<c:when test="${newReview[j].type eq 1}">
															음식점
														</c:when>
														<c:when test="${newReview[j].type eq 2}">
															병원
														</c:when>
														<c:when test="${newReview[j].type eq 3}">
															전자제품
														</c:when>
													</c:choose>
												</span>
											    <span class="float-right text-dark font-weight-bold">
												    <i class="fas fa-thumbs-up"></i>
											    	${newReview[j].goods}
											    </span>
											</div>
										</a>
											
										<div class="cardcontent">
											<div style="height: 87%; overflow: hidden; font-size: 150%">
												${newReview[j].contents}
											</div>
											<a href="/review/post?num=${newReview[j].num}&type=${newReview[j].type}" style="padding-top: 4%; display: inline-block; font-size: 150%; height: 13%; overflow: hidden; float: right;">
												자세히보기
											</a>
										</div>
										
										<div class="cardpic bg-white text-center">
											<c:if test="${newReview[j].files.size() eq 0 }">
												<img src="/img/NoImg.jpg" style="width: 50%;" />
											</c:if>
											<c:if test="${newReview[j].files.size() ne 0 }">
												<img src="${newReview[j].files[0]}" />
											</c:if>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
     
		<div class="col-12 d-flex justify-content-center mb-4">
			<a class="mr-3 text-center d-flex justify-content-center align-items-center" href="#carouselExampleControls2" role="button" data-slide="prev"
					style="background-color: orange; border-radius: 50%; width: 40px; height: 40px;">
				<i class="fas fa-chevron-left" style="color: white"></i>
			</a>
			<a class="ml-3 text-center d-flex justify-content-center align-items-center" href="#carouselExampleControls2" role="button" data-slide="next"
					style="background-color: orange; border-radius: 50%; width: 40px; height: 40px;">
				<i class="fas fa-chevron-right " style="color: white"></i>
			</a>
		</div>
	</div>
	<hr />
	
	<br>

	<!-- 최신리뷰끝 -->
	
	<!-- 추천 밑 테마 -->
	<div class="container d-flex justify-content-center">
		<div class="thema-flex col-12 d-flex flex-row flex-wrap justify-content-center align-items-start">
			<h5 class="w-100 pt-2 m-0 text-center text-danger" style="font-weight: bold;">All Review Recommend</h5>
			
			<div class="first_recommand m-2 p-0" style="background-image: url('/img/테마별사진/img2.jpg');">
				<a href="/review/search?type=1&keyword=냉면" class="recommand_box d-flex flex-column justify-content-center align-items-center h-100 w-100">
					<b class="mb-3" style="font-size: 150%">냉면맛집 TOP 20</b>
					"더운여름엔 냉면"
				</a>
			</div>
			
			
			<div class="first_recommand m-2 p-0" style="background-image: url('/img/테마별사진/신논.png');">
				<a href="/review/search?type=1&restGroup=score&restLoc=논현동&restLoc=역삼" class="recommand_box d-flex flex-column justify-content-center align-items-center h-100 w-100">
					<b class="mb-3" style="font-size: 150%">신논현역 맛집 TOP 20</b>
					비트캠프 주변 맛집
				</a>
			</div>
			
			<div class="first_recommand m-2 p-0 " style="background-image: url('/img/테마별사진/새우회.png');">
				<a href="/review/search?type=1&restGroup=score&restCategory=6" class="recommand_box d-flex flex-column justify-content-center align-items-center h-100 w-100">
					<b class="mb-3" style="font-size: 150%">커피숍 TOP 5</b>
					요즘 인기있는 커피숍 핫플레이스
				</a>
			</div>
			
			<div class="first_recommand m-2 p-0 " style="background-image: url('/img/테마별사진/이어폰.jpg');">
				<a href="/review/search?type=3&digitalGroup=score&digiCategory1=0&digiCategory2=2&digiCategory3=42&digiCategory3=43" class="recommand_box d-flex flex-column justify-content-center align-items-center h-100 w-100 text-white">
					<b class="mb-3" style="font-size: 150%">이어폰 TOP 5</b>
					"필수 아이템 무선이어폰"
				</a>
			</div>
			
			<div class="first_recommand m-2 p-0" style="background-image: url('/img/테마별사진/성형.jpg');">
				<a href="/review/search?type=2&medGroup=score&medCategory=12" class="recommand_box d-flex flex-column justify-content-center align-items-center h-100 w-100 text-white">
					<b class="mb-3" style="font-size: 150%">성형외과 TOP 10</b>
					"나는야 호빵맨"
				</a>
			</div>
			
			<div class="first_recommand m-2 p-0 " style="background-image: url('/img/테마별사진/제주맛집.jpg');">
				<a onclick="alert('준비중입니다')" class="recommand_box d-flex flex-column justify-content-center align-items-center h-100 w-100 text-white">
					<b class="mb-3" style="font-size: 150%">제주도 맛집 TOP 10</b>
					"제주도 여행가서 가볼만한 음식점"
				</a>
			</div>
		</div>
	</div>
	
	<div class="container d-flex flex-wrap justify-content-center board-section" style="padding: 0 10%; padding-bottom: 20px;">
		<div class="col-md-6 col-12 p-0">
			<h5 class="w-100 font-weight-bold" style="color: red">
				NOTICE
			</h5>
			<table class="content w-100">
				<c:forEach var="notice" items="${noticeList}">
					<tr style="height: 40px;">
						<td class="w-75">
							<a class="boardPost" data-toggle="modal" data-target="#boardModal" value="${notice.num}">${notice.title}</a>
						</td>
						<td class="w-25">
							<fmt:parseDate value="${notice.writerDate}" var="writeDate" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${writeDate}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="col-md-6 col-12 p-0 mt-md-0 mt-5">
			<h5 class="w-100 font-weight-bold" style="color: red">
				EVENT
			</h5>
			<table class="content w-100">
				<c:forEach var="event" items="${eventList}">
					<tr style="height: 40px;">
						<td class="w-75">
							<a class="boardPost" data-toggle="modal" data-target="#boardModal" value="${event.num}">${event.title}</a>
						</td>
						<td class="w-25">
							<fmt:parseDate value="${event.writerDate}" var="writeDate" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${writeDate}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>

<div class="modal fade" id="boardModal" style="top: 5%; z-index: 5000">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header d-flex justify-content-between">
				<h5 id="boardTitle" class="m-0"></h5>
				<button type="button" data-dismiss="modal" style="border: none; background-color: white">
	         	 	<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body p-4" style="height: 400px; overflow-y: scroll">
				<div id="boardContents">
					
				</div>
				<div id="boardImg">
					
				</div>
				<div id="boardDate" class="mt-3 text-right">
					
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
		$('.boardPost').click(function() {
			$('#boardTitle').html('');
			$('#boardContents').html('');
			$('#boardImg').html('');
			$.ajax({
				url: '/notice/getBoard',
				type: 'get',
				data: {
					num: $(this).attr('value')
				},
				dataType: 'json',
				success: function(data) {
					$('#boardTitle').html(data.TITLE);
					data.CONTENTS === '내용없음' ? '' : $('#boardContents').html(data.CONTENTS);
					$('#boardDate').html(data.WRITERDATE);
					data.FILES.forEach((item, index) => {
						var img = $('<img>');
						img.css({
							width: '100%'
						});
						img.attr({
							src: item
						});
						$('#boardImg').append(img);
					})
				}
			})
		})
	})
</script>
<style>
	@media screen and (max-width: 375px) {
		* {
			font-size: 13px;
		}
		.thema-flex {
			height: 100%;
		}
		.first_recommand  {
			width: 80%;
		}
		.board-section {
			margin: 20px 0;
		}
	}
</style>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>