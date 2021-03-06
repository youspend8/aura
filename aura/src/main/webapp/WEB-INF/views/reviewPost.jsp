<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/commons/header.jsp" />
<title>${reviewInfo.TITLE} - All Review</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<style>
	#review_title {
		font-size: 35px;
	}
	#review_category {
		font-size: 20px; 
	}
	#review_tel *, 
	#review_time *,
	#review_menu *,
	#review_contents *,
	#review_addr *,
	#digital_option * {
		font-size: 20px;
	}
	.heartCl * {
		font-size: 40px;
	}
	@media screen and (max-width: 576px) {
		#review_title {
			font-size: 25px;
		}
		#review_category {
			font-size: 15px; 
		}
		#review_tel *, 
		#review_time *,
		#review_menu *,
		#review_contents *,
		#review_addr *,
		#digital_option * {
			font-size: 15px;
		}
		.heartCl * {
			font-size: 25px;
		}
	}
</style>
<!-- 리뷰 항목 설명 및 사진, 지도 -->
<div class="container d-flex flex-wrap p-md-2 px-1">
	<div id="review_title" class="col-12 text-center font-weight-bold my-3 d-flex flex-row align-items-center justify-content-center" style="padding: 25px 0; border-bottom: 2px solid orange">
		${reviewInfo.TITLE}
		<c:if test="${type ne 3}">
			<span id="review_category" class="badge badge-pill badge-success" style="margin-left: 3px;">
				<c:if test="${type eq 1}">
					${reviewInfo.CATEGORY}
				</c:if>
				<c:if test="${type eq 2}">
					${reviewInfo.HOSPITALCATEGORY}
				</c:if>
			</span>
		</c:if>
	</div>
	<div class="col-12 p-0 d-flex justify-content-center align-items-start flex-wrap">
		<c:if test="${reviewInfo.FILES.size() != 0}">
			<div class="d-sm-flex d-none p-1 col-12 text-center">
				<!-- 리뷰 사진 캐러셀 -->
				<div id="carousel-example-2" class="carousel slide col-12 mb-3" data-ride="carousel">
					<div class="carousel-inner" role="listbox">
						<c:forEach var="index" begin="0" end="${reviewInfo.FILES.size() / 3}">
							<div class="carousel-item ${index == 0 ? 'active' : ''}">
								<div class="d-flex">
									<c:forEach var="j" begin="${index}" end="${index + 2}">
										<div class="card-body text-center p-1 col-4">
											<c:if test="${reviewInfo.FILES[j] != null}">
												<img class="w-100" src="${reviewInfo.FILES[j]}" style="width: 100%; height: 300px">
											</c:if>
											<c:if test="${reviewInfo.FILES[j] == null}">
												<img src="/img/NoImg.jpg" style="width: 30%; height: 300px">
											</c:if>
										</div>
									</c:forEach>
								</div>
							</div>
						</c:forEach>
					</div>
					<c:if test="o.FILES.size() > 3}">
						<!--Controls-->
						<a class="carousel-control-prev" href="#carousel-example-2"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"
							style="color: white;"></span>
						</a> <a class="carousel-control-next review-photo-button-right"
							href="#carousel-example-2" role="button" data-slide="next"> <span
							class="carousel-control-next-icon" aria-hidden="true"
							style="color: white;"></span>
						</a>
					</c:if>
				</div>
			</div>
			
			<div class="d-sm-none d-flex p-1 col-12 text-center">
				<!-- 리뷰 사진 캐러셀 -->
				<div id="carousel-example-3" class="carousel slide col-12 mb-3" data-ride="carousel">
					<div class="carousel-inner" role="listbox">
						<c:forEach var="file" items="${reviewInfo.FILES}" varStatus="i">
							<div class="carousel-item ${i.index == 0 ? 'active' : ''}">
								<img class="w-100" src="${file}" style="width: 100%; height: 300px">
							</div>
						</c:forEach>
					</div>
					<!--Controls-->
					<a class="carousel-control-prev" href="#carousel-example-3"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"
						style="color: white;"></span>
					</a>
					<a class="carousel-control-next review-photo-button-right"
						href="#carousel-example-3" role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"
						style="color: white;"></span>
					</a>
				</div>
			</div>
		</c:if>
		
		<div class="col-md-4 col-12 p-0 d-flex flex-wrap align-items-start justify-content-center order-2 ${type eq 3 ? 'order-md-2' : 'order-md-1'}">
			<c:if test="${type eq 1 || type eq 2}">
				<div id="review_addr" class="col-md-12 col-8">
					<div id="map" class="my-4" style="width:100%; height:250px;"></div>
					<div class="font-weight-bold text-center"> ${reviewInfo.ADDR} </div>
				</div>
			</c:if>
			<div class="col-12 d-flex justify-content-center my-4">
			
			<a id="share" onclick="doReview(1)" data-toggle="modal" data-target="#centralModalSm">

				<c:choose>
					<c:when test="${reviewInfo.isShare }">
						<i class="fas fa-share-alt" id="aa" value="${nickname}" style="color: #27ae60" data-toggle="modal" data-target="#basicExampleModal"></i>
					</c:when>
					<c:otherwise>
						<i class="fas fa-share-alt" id="aa" value="${nickname}" data-toggle="modal" data-target="#basicExampleModal"></i>
					</c:otherwise>
				</c:choose>
				</a>
				<a id="share" >
					<c:choose>
						<c:when test="${reviewInfo.isStar }">
						    <i class="fas fa-star mx-4" id="bb" value="${nickname}" style="color: #f9ca24" onclick="doReview(2)"></i>
						</c:when>
						<c:otherwise>
							<i class="fas fa-star mx-4" id="bb" value="${nickname}" onclick="doReview(2)"></i>
						</c:otherwise>
					</c:choose>
			
				</a>
				<a id="share" onclick="doReview(3)">
					<c:choose>
						<c:when test="${reviewInfo.isLike }">
						    <i class="fas fa-thumbs-up" id="cc" value="${nickname}" style="color: #3498db"></i>
						</c:when>
						<c:otherwise>
							<i class="fas fa-thumbs-up" id="cc" value="${nickname}"></i>
						</c:otherwise>
					</c:choose>
				</a>
				<!-- Modal -->
				<div class="modal fade" id="basicExampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				  aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">공유하기</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								  <span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body d-flex justify-content-around">
								<a href="javascript:;" id="kakao-link-btn"> 
									<img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" width="60px"/> <!-- 톡 이미지 부분이고, 전 kakaolink_btn_small.png로 불러왔습니다.   -->
								</a>
								<!-- 페이스북 공유하기  -->
								<a href="javascript:shareFB();" class="fb" title="facebook 공유">
									<img src="/img/all_review_img/facebook.png" width="60px">
								</a>
								<!-- 네이버 공유하기  -->
								<a href="javascript:shareNaver();" class="fa" title="naver공유">
									<img src="/img/all_review_img/naver.PNG" width="60px">
								</a>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<c:choose>
				<c:when test="${nickname ne null}">
					<button type="button" id="review_write_pc" class="d-md-block d-none btn btn-warning review-write">리뷰 작성하기</button>
				</c:when>
				<c:otherwise>
					<button type="button" id="review_write_login" class="d-md-block d-none btn btn-warning review-write">리뷰 작성하기</button>
				</c:otherwise>
			</c:choose>
		</div>
		
		<!-- 리뷰 상세 설명 -->
		<div class="d-flex flex-wrap col-md-8 col-12 order-1 ${type eq 3 ? 'order-md-1' : 'order-md-2'} mx-auto">
			<div id="review_tel" class="col-12 p-0 my-1">
				<i class="col-1 fas fa-star" style="background-color: white"></i>
				<span class="col-11 p-0 font-weight-bold">
			    	<c:forEach var="i" begin="0" end="4">
			    		<c:if test="${reviewInfo.STARS - i >= 1}">
				    		<i style="color: rgb(255, 153, 0);" class="fas fa-star"></i>
		    			</c:if>
		    			<c:if test="${reviewInfo.STARS - i < 1 && reviewInfo.STARS - i > 0}">
			    			<i style="color: rgb(255, 153, 0);" class="fas fa-star-half-alt"></i>
			    		</c:if>
			    		<c:if test="${reviewInfo.STARS - i <= 0}">
				    		<i style="color: rgb(255, 153, 0);" class="far fa-star"></i>
			    		</c:if>
			    	</c:forEach>
				</span>
			    <span style="font-weight:bolder; font-size: 14px;">
			    	<c:if test="${reviewInfo.STARS != 0}">
			    		<fmt:formatNumber value="${reviewInfo.STARS}" pattern=".0" />
			    	</c:if>
			    	<c:if test="${reviewInfo.STARS == 0}">
			    		<fmt:formatNumber value="${reviewInfo.STARS}" pattern="0" />
			    	</c:if>
			    </span>
			    <span class="ml-2" style="font-size:80%;">
			    	${reviewInfo.STARCOUNT}
			    	Reviews
			    </span>
			</div>
			<c:if test="${type eq 1 || type eq 2}">
				<div id="review_tel" class="col-12 p-0 my-1">
					<i class="col-1 fas fa-phone"></i>
					<span class="col-11 p-0 font-weight-bold">${reviewInfo.TEL}</span>
				</div>
				<div id="review_time" class="col-12 p-0 my-1">
					<i class="col-1 far fa-clock"></i>
					<span class="col-11 p-0 font-weight-bold">${reviewInfo.SERVICETIME}</span>
				</div>
				<div id="review_menu" class="col-12 d-flex flex-row p-0 my-1">
					<i class="col-1 pt-1 fas fa-utensils"></i>
					<div class="col-11 pl-1 d-flex flex-wrap font-weight-bold">
						<c:if test="${type eq 1}">
							<c:forEach var="menu" items="${menu}"  varStatus="num">
								<c:if test="${menu.name ne ''}">
									<div class="col-md-6 col-12 p-0 d-flex">
										<div class="col-8 p-0 m-0">
											${menu.name}
										</div>
										<div class="col-4 p-0 m-0 text-center">
											${String.format("%,3d", Integer.parseInt(menu.price))}원
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${type eq 2}">
							<c:forEach var="sub" items="${sub}"  varStatus="num">
								<div class="col-5 p-0 m-0">
									${medCategory.get(sub.intValue())}
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</c:if>
			<c:if test="${reviewInfo.CONTENTS ne '내용없음'}">
				<div id="review_contents" class="col-12 d-flex flex-row p-0 my-1">
					<i class="col-1 pt-1 far fa-comment-alt"></i> 
					<div class="col-11 pl-1 font-weight-bold review-explanation-2">
						${reviewInfo.CONTENTS}				
					</div>
				</div>
			</c:if>
			<c:if test="${type eq 3}">
				<div id="digital_option" class="col-12 d-flex flex-row p-0 my-1">
					<i class="col-1 pt-1 far fa-comment-alt"></i> 
					<div class="col-11 pl-1 font-weight-bold review-explanation-2">
						<c:forEach var="option" items="${options}" varStatus="num">
							<c:if test="${option.key ne ''}">
								<div class="col-12 p-0 d-flex">
									<div class="col-3 p-0 m-0">
										${option.key}
									</div>
									<div class="col-9 p-0 m-0">
										${option.value}
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	
<div class="mt-5 col-12" style="border-bottom: rgb(217, 217, 217) solid 1px;"></div>
	
</div>


<!-- 컨텐트 영역 -->
<div id="contents_area" class="container d-flex flex-wrap">

	<!-- 댓글 작성 양식 -->
	<div id="write_form" class="col-12 flex-column align-items-center">
		<button id="review_write_cancel" type="button"
			class="btn btn-light d-none d-md-block text-center w-100 m-0">
			댓글 작성창 접기 <i class="fas fa-arrow-up"></i>
		</button>

		<div class="col-md-9 col-12 p-0 flex-column mt-5">
			<form id="commentForm" method="post" enctype="multipart/form-data">
				<input id="review_post_num" name="review_post_num" value=${reviewInfo.NUM} style="display: none;">
				<input id="nickname_post" name="nickname_post" value="${nickname}" style="display: none;">
				<input id="grade" name="grade" value="0" style="display: none;">
				
				<textarea rows="5" class="form-control px-2" id="comment" name="comment" autofocus></textarea>
				<div class="d-flex flex-wrap justify-content-between mt-3">
					<div class="star-box d-flex align-items-center">
	<!-- 					마우스가 호버되면 별 색깔 바꾸기 및 호버된 별의 순서에따라 점수를 다르게 주기 -->
						<a class="far fa-star" id="star1" style="font-size: 30px; color: rgb(255, 153, 0);"></a>
						<a class="far fa-star" id="star2" style="font-size: 30px; color: rgb(255, 153, 0);"></a>
						<a class="far fa-star" id="star3" style="font-size: 30px; color: rgb(255, 153, 0);"></a>
						<a class="far fa-star" id="star4" style="font-size: 30px; color: rgb(255, 153, 0);"></a>
						<a class="far fa-star" id="star5" style="font-size: 30px; color: rgb(255, 153, 0);"></a>
					</div>
					<input id="comment_submit" type="button" class="btn btn-light" value="등록하기" onclick="fileSubmit();" disabled>
				
				</div>
				<div id="comment_image" class="d-flex col-12 p-0 my-3">
					<div class="mr-2" style="width: 20%;">
						<label for="comment_file" class="filebox">
							<a>
								<img src="/img/addfile.png" id="img22" class="w-100" style="border: 2px dotted #b8bcc4">
								<input type="file" id="comment_file" name="comment_file" accept="image/*">
							</a>
						</label>
					</div>
					
				</div>
			</form>
		</div>
	</div>
	
		<c:forEach var="commentList" items="${commentList }" varStatus="status" end="4">
			<div class="w-100 d-md-none d-block" style="border-bottom: rgb(217, 217, 217) solid 1px;"></div>
			<div class="col-12 my-3 d-flex flex-wrap fade show active" id="home_${commentList.comment_Num }">
			
			
				<div class="col-2 d-flex flex-column justify-content-center align-items-center align-self-start order-md-1 order-1">
					
					<div class="p-0">
					<c:choose>
						<c:when test="${commentList.profile ne null }">
							<img class="rounded-circle user-profile" src=${commentList.profile }>
						</c:when>
						<c:otherwise>
							<img class="rounded-circle user-profile" src="https://ssl.pstatic.net/static/pwe/address/img_profile.png">
						</c:otherwise>
					</c:choose>
					</div>
	
					<div class="w-100 text-center user-nickname" style="margin-top: 0px">${commentList.nickname }</div>
					
						
					<div class="p-0 d-md-flex d-none  justify-content-center">
						<c:forEach begin="1" end="${commentList.comment_Score }">
							<i class="fas fa-star" style="font-size: 20px; color: rgb(255, 153, 0);"></i>
						</c:forEach>
						<c:forEach begin="1" end="${5-commentList.comment_Score }">
							<i class="far fa-star" style="font-size: 20px; color: rgb(255, 153, 0);"></i>
						</c:forEach>
					</div>
					
				</div>
				
				<div class="col-2 d-md-flex d-none justify-content-center align-items-center p-0 order-md-2 order-3">
					<!-- 유저들이 올린리뷰 후기 사진0-->
					<c:if test="${commentList.files[0] ne null }">
						<div id="carouselExampleFade-${status.index }" class="carousel slide carousel-fade"
							data-ride="carousel">
							<div class="carousel-inner" style="width:168px; height:123px;">
								<div class="carousel-item active sample_image">
									<img class="d-block user-review-img" style="width:168px; height:123px;"
											src="${commentList.files[0].comment_File}">
								</div>
	
								<c:forEach var="files" items="${commentList.files }" begin="1">
									<c:if test="${files ne null}">
										<div class="carousel-item big sample_image">
											<img class="d-block user-review-img" style="width:168px; height:123px;" 
														src="${files.comment_File}">
										</div>
									</c:if>
								</c:forEach>
							</div>
							
							<a class="user-photo-button-left carousel-control-prev"
								href="#carouselExampleFade-${status.index }" role="button" data-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="user-photo-button-right carousel-control-next"
								href="#carouselExampleFade-${status.index }" role="button" data-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
					</c:if>
					<!-- 유저들이 올린리뷰 후기 사진0 End-->
				</div>
	
				<div class="col-md-6 col-9 d-flex flex-wrap flex-row align-items-center order-md-3 order-2">
					<div class="col-12 p-0 d-flex justify-content-between flex-wrap">
						<div class="d-md-none d-flex w-100"  style="font-size: 12px;">
							<fmt:parseDate var="commentDate" value="${commentList.comment_Date}" pattern="yyyy-MM-dd" />
							<fmt:formatDate var="originCommentDate" value="${commentDate}" pattern="yyyy-MM-dd" />
							등록일 : ${originCommentDate}
						</div>
						<div class="p-0 d-md-none d-flex">
							<c:forEach begin="1" end="${commentList.comment_Score }">
								<i class="fas fa-star" style="font-size: 20px; color: rgb(255, 153, 0);"></i>
							</c:forEach>
							<c:forEach begin="1" end="${5-commentList.comment_Score }">
								<i class="far fa-star" style="font-size: 20px; color: rgb(255, 153, 0);"></i>
							</c:forEach>
						</div>
					
					</div>
					
					<div class="col-md-12 p-0 my-4">
						${commentList.comment_Contents }
					 </div>
					 
					<div class="d-md-flex d-none" style="font-size: 12px;">
						<fmt:parseDate var="commentDate" value="${commentList.comment_Date}" pattern="yyyy-MM-dd" />
						<fmt:formatDate var="originCommentDate" value="${commentDate}" pattern="yyyy-MM-dd" />
						등록일 : ${originCommentDate}
					</div>
					
					<div class="d-md-none d-flex col-12 p-0 flex-wrap">
						<c:forEach var="files" items="${commentList.files}">
							<img class="d-block user-review-img mx-1" style="width:90px; height:90px;" src="${files.comment_File}">
						</c:forEach>
					</div>
				</div>
				
				<div class="d-flex p-md-auto p-0 col-md-2 col-1 flex-column align-items-center justify-content-center order-md-4 order-4">
					<a class="heartCl" commentNum="${commentList.comment_Num}">
						<i class="fas fa-heart"></i>
					</a>
					<p value="${commentList.comment_Like }" nickname="${nickname}">
				
						<fmt:formatNumber value="${commentList.comment_Like }" pattern="#,###"/>
						
					</p>
					<c:if test="${nickname eq commentList.nickname}">
						<div id="session_Comment" class="d-flex mt-2 justify-content-center">
							<input type="hidden" value="" name="">
							<input type="hidden" value="" name="">
							
							<button id="delete_Comment" style="border:0; outline:0; opacity: 0.3; padding: 0;"  data-toggle="modal" data-target="#delete_${commentList.comment_Num }" >삭제</button>
							
							
							<!-- Modal -->
							<div class="modal fade" id="delete_${commentList.comment_Num }" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="top:30%" aria-hidden="true">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content text-center">
						      		<div class="modal-body text-center">
								      <div class="text-center mb-3">
							        	<button type="button" class="close justify-content-end" data-dismiss="modal">
							         	 	<span aria-hidden="true">&times;</span>
							       		</button>
							        	<h5 class="modal-title font-weight-bold" id="exampleModalLabel">삭 제</h5>
								      </div>
								      <div class="my-5">
						     		 	 정말 삭제 하시겟습니까?
								      </div>
										<div class="d-flex justify-content-end">
									        <button type="button" class="btn btn-danger data-delete" onclick="comment_delete(${commentList.comment_Num })">삭제</button>
									        <button type="button" class="btn gray delete-cancel" data-dismiss="modal" value="0">취소</button>
										</div>
						      		</div>
							    </div>
							  </div>
							</div>
							
					   </div>
					</c:if>
				</div>
				
			
		
			</div>
		</c:forEach>
		
	<c:if test="${commentList.size() eq 0}">
		<div class="col-12 d-flex justify-content-center p-5">첫 리뷰를 작성해주세요 !</div>
	</c:if>
</div>
	
	<script type="text/javascript">
	//동훈이 짱
	function comment_delete(num){
		$.ajax({
			url : '/comment/delete',
			data: {
				num : num
			},
			type: 'POST',
			datatype :'text',
			success : function(data) {
				window.location.href=window.location.href 
			}
		})
	}
			
		</script>


<div class="my-3 col-12" style="border-bottom: rgb(217, 217, 217) solid 1px;"></div>
<c:if test="${commentList.size() > 5 }">
<div id="review_more" class="d-flex col-12 justify-content-center align-items-center bg-white py-3 my-5">
    <a id="more_button" class="text-center" style="text-decoration: none">
        <img src="/img/more.png" style="width: 20%; border-radius: 100%; border: 1px solid gray">
        <span class="ml-2 text-dark">리뷰 더 보기</span>
    </a>
    <div id="bar" style="display: none;"></div>
</div>
</c:if>



<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=53d46cec9bd19a0835b7c8bc8150a448&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		star();
	})
	function star() {
		var nickname ='${nickname}';
		var test2 = $('.heartCl')
		var userCommentsStr = '${userComments}';
	
	 	if(userCommentsStr != ''){
	 		var userComments = JSON.parse(userCommentsStr);
	 		
			for(var i=0;i<test2.length;i++){
				var commentNum = $(test2[i]).attr('commentNum');
				for(var j =0 ; j<userComments.length;j++){
					if(commentNum==userComments[j].COMMENT_NUM){
						test2[i].style.color='rgb(255, 0, 0)'
						break;
					}
				}
			}
	 	}
	}
	function addComma(num) {
		 var regexp = /\B(?=(\d{3})+(?!\d))/g;
	     return num.toString().replace(regexp, ',');
	}
	$('.heartCl').on('click', function(e){
		if($(this).next().attr('nickname')!=""){
			
				if($(this).find("i").css('color')=='rgb(33, 37, 41)'){ 
					$(this).find("i").css('color','rgb(255, 0, 0)')//빨강
					
					var num1=Number($(this).next().attr('value'))+1;
					var num=addComma(Number($(this).next().attr('value'))+1);
					
					$(this).next().remove();
					$(this).after('<p value=\"'+num1+'\">'+num+'</p>')
					var commentNum = Number($(this).attr('commentNum'));
					
						$.ajax({
				    		url: '/comment/update', // 요청 할 주소 
				    	    type: 'get', // GET, PUT
				    	    dataType: 'text', 
				    	    data: {
				    	    	commentNum : commentNum,
				    	    	type : 1
				    	    },
				    	    success: function(data) {
			    	        },
			    	       error : function (data) {
			    	        	alert('죄송합니다. 잠시 후 다시 시도해주세요.');
				    	        return false;
			    	       }  // 전송할 데이터
				    	})
    	
				}else{
					$(this).find("i").css('color','rgb(33, 37, 41)')//검정

					var num1=Number($(this).next().attr('value'))-1;
					var num=addComma(Number($(this).next().attr('value'))-1);
					
					$(this).next().remove();
					$(this).after('<p value=\"'+num1+'\">'+num+'</p>')
					var commentNum = Number($(this).attr('commentNum'));
					
						$.ajax({
				    		url: '/comment/update', // 요청 할 주소 
				    	    type: 'get', // GET, PUT
				    	    dataType: 'text', 
				    	    data: {
				    	    	commentNum : commentNum,
				    	    	type : 2
				    	    },
				    	    success: function(data) {
			    	        },
			    	       error : function (data) {
			    	        	alert('죄송합니다. 잠시 후 다시 시도해주세요.');
				    	        return false;
			    	       }  // 전송할 데이터
				    	})
				}
		}
		else{
			alert("회원만 이용 가능한 기능입니다. 로그인을 해주세요.")
		}
	})
	
</script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${reviewInfo.ADDR}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
        var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    var imageSize = new daum.maps.Size(24, 35); 
	    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords,
	        image : markerImage
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new daum.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${reviewInfo.TITLE}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
<script type="text/javascript">

    // // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('cec5c87f0e6a1c8fc2daedbc6a4c7d6b');
    // // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
    Kakao.Link.createDefaultButton({
      container: '#kakao-link-btn',  // 컨테이너는 아까 위에 버튼이 쓰여진 부분 id 
      objectType: 'feed',
      content: {  // 여기부터 실제 내용이 들어갑니다. 
        title: '${reviewInfo.TITLE}', // 본문 제목
        description: '${reviewInfo.CONTENTS}',  // 본문 바로 아래 들어가는 영역?
        imageUrl: 'http://13.209.65.90${reviewInfo.FILES[0]}', // 이미지
        link: {
          mobileWebUrl: 'http://13.209.65.90/review/post?num=${reviewInfo.NUM}&type=${reviewInfo.TYPE}',
          webUrl: 'http://13.209.65.90/review/post?num=${reviewInfo.NUM}&type=${reviewInfo.TYPE}'
        }
      },
      social: {  /* 공유하면 소셜 정보도 같이 줄 수 있는데, 이 부분은 기반 서비스마다 적용이 쉬울수도 어려울 수도 있을듯 합니다. 전 연구해보고 안되면 제거할 예정 (망할 google  blogger...) */
        likeCount: ${reviewInfo.GOODS},
         commentCount: 45,
        sharedCount: ${reviewInfo.SHARES}
      },
      buttons: [
        {
          title: '웹으로 보기',
          link: {
            mobileWebUrl: 'http://13.209.65.90/review/post?num=${reviewInfo.NUM}&type=${reviewInfo.TYPE}',
            webUrl: 'http://13.209.65.90/review/post?num=${reviewInfo.NUM}&type=${reviewInfo.TYPE}'
          }
        }
 
      ]
    });
    function shareFB() {
    	window.open('http://www.facebook.com/sharer/sharer.php?u=' + location.href,"zzzzzzzz",
    			"width=700, height=700, toolbar=no, menubar=no, scrollbars=yes, resizable=yes")
    }
    function shareNaver() {
    	window.open('https://share.naver.com/web/shareView.nhn?url=' + location.href + '&title=${reviewInfo.TITLE}','naversharedialog', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600')
    }

</script> 
<script>
var flag1=true;
var flag2=true;

		$("#share i").click(function(e){
			if(flag1){
				flag1=false;
				
			if($(this).attr('value')=='' && ($(this).attr('id')=='bb'||$(this).attr('id')=='cc')){
		
					alert('해당기능은 회원만 이용가능합니다.')
					$(this).attr("data-toggle","")
					
				}else{
				
					if($(this).css("color")!="rgb(33, 37, 41)"){
						$(this).attr("data-toggle","")
						$(this).css("color","rgb(33, 37, 41)")
					}else{
						if($(this).attr('id')=='aa'){
						
							$(this).css("color","#27ae60")
							
						}
						if($(this).attr('id')=='bb'){
							
							$(this).css("color","#f9ca24") // 노랑
						
						}
						if($(this).attr('id')=='cc'){
							
							$(this).css("color","#3498db")
						
						}
					}
					
				}
				setTimeout(() => {
					$(this).attr("data-toggle","modal")
					flag1=true;
				}, 300);
			}
		})

    	function doReview(type, nickname) {
			if(flag2){
				
				flag2=false;
				$.ajax({
		    		url: '/reviewList/reviewPost', // 요청 할 주소 
		    	    type: 'POST', // GET, PUT
		    	    dataType: 'text', 
		    	    data: {
		    	    	postNum : '${reviewInfo.NUM}',
		    	    	nickname: nickname,
		    	    	reviewType: type,
		    	    	type: '${reviewInfo.TYPE}'
		    	    },
		    	    success: function(data) {
	    	        },
	    	       error : function (data) {
	    	        	alert('죄송합니다. 잠시 후 다시 시도해주세요.');
		    	        return false;
	    	       }  // 전송할 데이터
		    	})
		    	setTimeout(() => {
					flag2=true;
				}, 300);
			}
	    
    	}
    
        $(document).ready(function() {
            var state = false;

            
            $('#review_write_pc').on('click', () => {
                $('#write_form').animate({
                    height: '520px'
                }, 400);
                $('#write_form').css('display', 'flex');
                $('#write_form').css('border-bottom', '2px solid #dadee6');
            });

            $('#review_write_cancel').on('click', () => {
                $('#write_form').animate({
                    height: '0px'
                }, 300);
                // $('#write_form').css('visibility', 'hidden');
                setTimeout(() => {
                    $('#write_form').css('display', 'none');
                    $('#write_form').css('border-bottom', '');
                }, 180);
            });
            
            $('#review_write_login').on('click', () => {
            	alert('로그인이 필요합니다.');
            });
            
        });
        
        function update_Form(){
            $('#update_form').css('display', 'flex');
            $('#update_form').css('border-bottom', '2px solid #dadee6');
            $('#update_form').animate({
                height: '520px'
            }, 400);
        };
        
        function update_Form_Cancel(){
        	$('#update_form').animate({
                height: '0px'
            }, 300);
        	setTimeout(() => {
        	$('#update_form').remove();
			}, 200);
        }
        
//         $('#update_write_cancel').on('click', () => {
//         	alert('gdgd');
//             $('#update_form').animate({
//                 height: '0px'
//             }, 300);
//         });
        
        $('#comment').on('keyup', function(){ // 댓글에 내용이 있는지 (확인 CSS 이벤트)
        	
        	var comment = $('#comment').val();
        	var comment_file = $('#comment_file').val();
        	
        	if(comment != ""){
        		$('#comment_submit').removeAttr('disabled');
            	$('#comment_submit').removeClass().addClass('btn btn-warning');
        	} else {
        		$('#comment_submit').prop('disabled', true);
            	$('#comment_submit').removeClass().addClass('btn btn-light');
        	}
        	
        	
        	
        });
        
		$('#star1').click(function(){
			$('#grade').val('1');
			$('#star1').removeClass().addClass('fas fa-star');
			$('#star2').removeClass().addClass('far fa-star');
			$('#star3').removeClass().addClass('far fa-star');
			$('#star4').removeClass().addClass('far fa-star');
			$('#star5').removeClass().addClass('far fa-star');
		});
		
		$('#star2').click(function(){
			$('#grade').val('2');
			$('#star1').removeClass().addClass('fas fa-star');
			$('#star2').removeClass().addClass('fas fa-star');
			$('#star3').removeClass().addClass('far fa-star');
			$('#star4').removeClass().addClass('far fa-star');
			$('#star5').removeClass().addClass('far fa-star');
			
		});
		
		$('#star3').click(function(){
			$('#grade').val('3');
			$('#star1').removeClass().addClass('fas fa-star');
			$('#star2').removeClass().addClass('fas fa-star');
			$('#star3').removeClass().addClass('fas fa-star');
			$('#star4').removeClass().addClass('far fa-star');
			$('#star5').removeClass().addClass('far fa-star');
		});
		
		$('#star4').click(function(){
			$('#grade').val('4');
			$('#star1').removeClass().addClass('fas fa-star');
			$('#star2').removeClass().addClass('fas fa-star');
			$('#star3').removeClass().addClass('fas fa-star');
			$('#star4').removeClass().addClass('fas fa-star');
			$('#star5').removeClass().addClass('far fa-star');
		});
		
		$('#star5').click(function(){
			$('#grade').val('5');
			$('#star1').removeClass().addClass('fas fa-star');
			$('#star2').removeClass().addClass('fas fa-star');
			$('#star3').removeClass().addClass('fas fa-star');
			$('#star4').removeClass().addClass('fas fa-star');
			$('#star5').removeClass().addClass('fas fa-star');
		});


		
    </script>
	<script type="text/javascript" src="/js/radialprogress.js"></script>
<script>
var more_start = 6;

var bar = new RadialProgress(document.getElementById("bar"),{indeterminate:true,colorBg:"white",colorFg:"red",thick:5});

$('#review_more').on('click', function(){
	$('#bar').show();
	$('#more_button').hide();
	
	$.ajax({
		url: '/comment/more',
		type: 'get',
		dataType: 'json',
		data: {
			postNum: '${reviewInfo.NUM}',
			start: more_start,
			end: more_start + 4
		},
		success: function(data) {
			console.log(data);
			if (data.length == 0){
				$('#review_more').text('더 이상 불러올 리뷰가 없습니다.');
			};
			
			data.forEach((item, index) => {
				var more_files = '';
				var reviewFiles = '';
				var mobileFiles = '';
				
				if (item.files.length == 0) {
					more_files ='<div class="carousel-item active sample_image">' +
									'<img class="d-block user-review-img" style="width:168px; height:123px; src="">' +
								'</div>';
				} else {
					item.files.forEach((item, index) => {
						more_files+='<div class="carousel-item' + (index == 0 ? ' active' : '') + ' sample_image">' +
										'<img class="d-block user-review-img" style="width:168px; height:123px;" src="' + item.comment_File + '">' +
									'</div>';
						mobileFiles += '<img class="d-block user-review-img mx-1" style="width:90px; height:90px;" src="' + item.comment_File + '">'
					})
					reviewFiles += '<div id="carouselExampleFade-' + item.comment_Num + '" class="carousel slide carousel-fade" data-ride="carousel">'
								+ '<div class="carousel-inner" style="width:168px; height:123px;">'
									+ more_files
								+ '</div>'
							
								+ '<a class="user-photo-button-left carousel-control-prev" href="#carouselExampleFade-' + item.comment_Num + '" role="button" data-slide="prev">'
									+ '<span class="carousel-control-prev-icon" aria-hidden="true"></span>'
									+ '<span class="sr-only">Previous</span>'
								+ '</a>'
								+ '<a class="user-photo-button-right carousel-control-next" href="#carouselExampleFade-' + item.comment_Num + '" role="button" data-slide="next">'
									+ '<span class="carousel-control-next-icon" aria-hidden="true"></span>'
									+ '<span class="sr-only">Next</span>'
								+ '</a>'
							+ '</div>';
				}
				
				var profile = '';
				var score = '';
				var comment_delete = '';
				
				if (item.profile == null){
					profile = 'https://ssl.pstatic.net/static/pwe/address/img_profile.png';
				} else {
					profile = item.profile;
				}
				
				for (var i = 0; i < 5; i++){
					if (i < item.comment_Score){
						score += '<i class="fas fa-star" style="font-size: 20px; color: rgb(255, 153, 0);"></i>';
					} else {
						score += '<i class="far fa-star" style="font-size: 20px; color: rgb(255, 153, 0);"></i>';
					}
				}
				
				if (item.nickname == $('#session_nickname').text()){
					console.log(item.comment_Num);
					comment_delete =
					'<div id="session_Comment" class="d-flex mt-2 justify-content-center">' +
						'<button id="delete_Comment" style="border:0; outline:0; opacity: 0.3; padding: 0"  data-toggle="modal" data-target="#delete_' + item.comment_Num + '">삭제</button>' +
				   	'</div>' +
				   	'<div class="modal fade" id="delete_' + item.comment_Num + '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="top:30%" aria-hidden="true">' +
					 '<div class="modal-dialog" role="document">' +
					    '<div class="modal-content text-center">' +
				      		'<div class="modal-body text-center">' +
						      '<div class="text-center mb-3">' +
					        	'<button type="button" class="close justify-content-end" data-dismiss="modal">' +
					         	 	'<span aria-hidden="true">&times;</span>' +
					       		'</button>' +
					        	'<h5 class="modal-title font-weight-bold" id="exampleModalLabel">삭 제</h5>' +
						      '</div>' +
						     ' <div class="my-5">' +
				     		 	 '정말 삭제 하시겟습니까?' +
						      '</div>' +
								'<div class="d-flex justify-content-end">' +
							        '<button type="button" class="btn btn-danger data-delete" value="1" onclick="comment_delete(' + item.comment_Num + ')">삭제</button>' +
							       ' <button type="button" class="btn gray delete-cancel" data-dismiss="modal" value="0">취소</button>' +
								'</div>' +
				      		'</div>' +
					    '</div>' +
					 '</div>' +
					'</div>';
				}
				
				var reviewComment = 
					'<div class="w-100 d-md-none d-block" style="border-bottom: rgb(217, 217, 217) solid 1px;"></div>' +
					'<div class="col-12 my-3 d-flex flex-wrap fade show active" id="home_' + item.comment_Num + '">' +
						'<div class="col-2 d-flex flex-column justify-content-center align-items-center align-self-start order-md-1 order-1">' +
							'<div class="p-0">' +
								'<img class="rounded-circle user-profile" src="' + profile + '">' +
							'</div>' +
							'<div class="w-100 text-center user-nickname" style="margin-top: 0px">' + item.nickname + '</div>' +
							'<div class="p-0 d-md-flex d-none justify-content-center">' +
								score +
							'</div>' +
						'</div>' +
						'<div class="col-2 d-md-flex d-none justify-content-center align-items-center p-0 order-md-2 order-3">' +
							reviewFiles +
						'</div>' +
						'<div class="col-md-6 col-9 d-flex flex-wrap flex-row align-items-center order-md-3 order-2">' +
							'<div class="col-12 p-0 d-flex justify-content-between flex-wrap">' +
								'<div class="d-md-none d-flex w-100" style="font-size: 12px;">' +
									'등록일 : ' + item.comment_Date.substring(0, 11) +
								'</div>' +
								'<div class="p-0 d-md-none d-flex">' +
									score +
								'</div>' +
							'</div>' +
							'<div class="col-md-12 p-0 my-4">' +
								item.comment_Contents +
							'</div>' +
							'<div class="d-md-flex d-none" style="font-size: 12px;">' +
								'등록일 : ' + item.comment_Date.substring(0, 11) +
							'</div>' +
							
							'<div class="d-md-none d-flex col-12 p-0 flex-wrap">' +
								mobileFiles + 
							'</div>' +
						'</div>' +
						'<div class="d-flex p-md-auto p-0 col-md-2 col-1 flex-column align-items-center justify-content-center order-md-4 order-4">' +
							'<a class="heartCl" commentNum="' + item.comment_Num + '">' +
								'<i class="fas fa-heart"></i>' +
							'</a>' +
							'<p value="' + item.comment_Like + '" nickname="' + item.nickname + '">' +
								addComma(item.comment_Like) +
							'</p>' +
								comment_delete
						'</div>' +
					'</div>';
							
					document.getElementById('contents_area').innerHTML += reviewComment;
					star();
					
					$('.heartCl').click(function(e){
						if('${nickname}' !=""){
							
							if($(this).find("i").css('color')=='rgb(33, 37, 41)'){ 
								$(this).find("i").css('color','rgb(255, 0, 0)')//빨강
								
								var num1=Number($(this).next().attr('value'))+1;
								var num=addComma(Number($(this).next().attr('value'))+1);
								
								$(this).next().remove();
								$(this).after('<p value=\"'+num1+'\">'+num+'</p>')
								var commentNum = Number($(this).attr('commentNum'));
								
									$.ajax({
							    		url: '/comment/update', // 요청 할 주소 
							    	    type: 'get', // GET, PUT
							    	    dataType: 'text', 
							    	    data: {
							    	    	commentNum : commentNum,
							    	    	type : 1
							    	    },
							    	    success: function(data) {
						    	        },
						    	       error : function (data) {
						    	        	alert('죄송합니다. 잠시 후 다시 시도해주세요.');
							    	        return false;
						    	       }  // 전송할 데이터
							    	})
			    	
							}else{
								$(this).find("i").css('color','rgb(33, 37, 41)')//검정

								var num1=Number($(this).next().attr('value'))-1;
								var num=addComma(Number($(this).next().attr('value'))-1);
								
								$(this).next().remove();
								$(this).after('<p value=\"'+num1+'\">'+num+'</p>')
								var commentNum = Number($(this).attr('commentNum'));
								
								$.ajax({
						    		url: '/comment/update', // 요청 할 주소 
						    	    type: 'get', // GET, PUT
						    	    dataType: 'text', 
						    	    data: {
						    	    	commentNum : commentNum,
						    	    	type : 2
						    	    },
						    	    success: function(data) {
					    	        },
					    	       error : function (data) {
					    	        	alert('죄송합니다. 잠시 후 다시 시도해주세요.');
						    	        return false;
					    	       }  // 전송할 데이터
						    	})
							}
						}
						else{
							alert("회원만 이용 가능한 기능입니다. 로그인을 해주세요.")
						}
						
					})
			});
			
		 	more_start += 5;
		 	$('#bar').hide();
		 	if (data.length < 5){
				$('#review_more').text('더 이상 불러올 리뷰가 없습니다.');
			}else {
				$('#more_button').show();
			};
			
		},
		error: function(request, status, error){
			alert(request.status);
			alert(request.responseText);
		}
	
	});
});
</script>
    
<script>
	var files = new Array();
	var previewIndex = 0;
	var deleteIndex = 0;
	var test = 0;
	var j = 0;
	
	function addPreview(input) {
		
		image_Exists : if (input[0].files) {
			
	        //파일 선택이 여러개였을 시의 대응
	        for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
	            var file = input[0].files[fileIndex];
	            var reader = new FileReader();
	            
	            if (files.length >= 4){
					alert('최대 4개까지 이미지를 등록 할 수 있습니다.');
					break image_Exists;
				}
	            
	            for (var i = 0; i < test; i++){
	            	if (files[i].name == input[0].files[fileIndex].name){
	            		alert(input[0].files[fileIndex].name + ' 는 이미 업로드된 이미지입니다.');
	            		break image_Exists;
	            	}
	            };
	            
	            files[test] = file;
	            reader.readAsDataURL(file);
	            test++;
	            
	            reader.onload = function(img) {
	            	var imgNum = previewIndex++;
	            	var deleteNum = deleteIndex++;
	            	
            		if (files[i].name != null) {
            			$("#comment_image")
                        .append(
                                "<div class=\"preview-box mr-2 view overlay\" style=\"width:20%;\" value=\"" + deleteNum +"\">"
                                        + "<img class=\"thumbnail w-100 img-fluid\" style=\"height:159.13px;\" src=\"" + img.target.result + "\"\/>"
                                        + "<div class=\"mask flex-center waves-effect waves-light rgba-red-strong\" style=\"height:159.13px;\">"
                                        + "<a style=\"font-size:19px; display:flex; justify-content: center; align-items: center\" class=\"white-text w-100 h-100\" id=\"" + deleteNum + "\"  value=\"" + files[imgNum].name + "\" onclick=\"deletePreview(this)\">"
                                        + "삭제" + "</a>" + "</div>" + "</div>");
            		}
	            	
	            };
	        }
	    } else
	        alert('invalid file input'); // 첨부클릭 후 취소시의 대응책 세우지 않았음
	}
	
	$('#comment_file').change(function() {
		addPreview($(this));
	});
	
	function deletePreview(obj) {	// 미리보기 사진 삭제
	var deleteNum = obj.attributes['id'].value;
	var imgId = obj.attributes['value'].value;
	
	for (var i in files){
		if(files[i].name == imgId){
			files.splice(i, 1);
			test--;
			previewIndex--;
		}
	};
	
	$("#comment_image .preview-box[value=" + deleteNum + "]").remove();
	}
	
	
	
	function fileSubmit(){ // 멀티파트 파일 업로더
		
		 if($('#grade').val() == 0){
         	return alert('별점을 주세요');
         };
		
    	var comment = $('#comment').val();
    	var formData = new FormData($('#commentForm')[0]);
    	
    	for (var index = 0; index < Object.keys(files).length; index++){
            formData.append('files',files[index]);
    	};
    	
    	if (comment == "") {
    		alert('내용을 입력해주세요.');
    	} else {
    		$('#comment').val().replace(/\n/g, "<br>");
    		
    		$.ajax({
   	            url : "/comment/write",
   				type : "post",
   				data : formData,
   				processData : false,
   				contentType : false,
   				
   				success: function(data){
   					if (data != ""){
   					alert(data);
   					return;
   					}
   					
   					$('#comment').val('');
   					$('#grade').val('0')
   					location.reload();
   				},
   				error : function(error) {
   					alert("파일업로드 실패");
   					console.log(error);
   					console.log(error.status);
   				}
   	        });
    	}
    }
</script>
<style>
	.filebox input[type="file"] { /* 파일 필드 숨기기 */
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0, 0, 0, 0);
		border: 0;
	}
	
	#comment:focus {
	    border: 1px solid #ffb833;
	    box-shadow: 0 0 0 0.2rem #ffdb99;
	}
	#img22 {
		height: 160px;
	}
	#write_form {
		display: none;
		height: 0px;
	}
	.user-profile {
		height: 75px;
		width: 75px;
	}
	@media (max-width: 767.9px) {
		#img22 {
			height: 100px;
		}
		#write_form {
			display: flex;
			height: 100%;
		}
		.user-profile {
			width: 45px;
			height: 45px;
		}
		.user-nickname {
			font-size: 13px;
		}
		#delete_Comment {
			font-size: 10px;
		}
	}
</style>