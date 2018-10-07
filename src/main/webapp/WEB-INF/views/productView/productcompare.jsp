<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!--  Product Details -->


<script>
	$(function() {
		var test = '${resultMap.product_name}';
		console.log('test '+test);
	});
	
</script>
				<div class="product product-details clearfix">
					<div class="col-md-6">
						<div id="product-main-view">
							<div class="product-view">
								<img src="${resultMap.product_img}" style="width:555px; height:555px;" alt="">
							</div>
							
						</div>

					</div>
					<div class="col-md-6">
						<div class="product-body">
							<h2 class="product-name">${resultMap.product_name}</h2>
							<h3 class="product-price" style="color:#F44336">최저가 ${resultMap.product_lprice}</h3>
							<div>
								<div class="product-rating">
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star-o empty"></i>
								</div>
								<a href="#">3 Review(s) / Add Review</a>
							</div>
							<p><strong>Availability:</strong> In Stock</p>
							<p><strong>Brand:</strong> E-SHOP</p>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
								.</p>

               <table class="table table-striped table-hover">
                <caption><span class="blind">쇼핑몰별 최저가 리스트</span></caption>
                <thead>
					<tr style="background-color:#FF9100; color:white;">
					  <th >판매처</th>
					  <th >판매가</th>
					  <th >배송비</th>
					  <th >부가정보</th>
					  <th >사러가기</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${resultMap.seller}" var="resultData"	varStatus="loop">
				<c:if test="${(loop.index)%2==0 }">
					<tr class="warning">
				</c:if>
				<c:if test="${(loop.index)%2!=0 }">
					<tr>
				</c:if>
					  <td >             
					     <div class="text_over">
							<span class="mall"><a href="${resultData.path}" target="_blank">
                                 <c:choose>
                                    <c:when test="${resultData.img == '' }">
                                    <p>${resultData.name}</p>
                                     </c:when>
                                     <c:otherwise><img src="${resultData.img}" height="15"></c:otherwise>
                                     </c:choose>
                                    </a></span>
                       </div>
                      </td>
					  <td ><a href="${resultData.path}" target="_blank">${resultData.price}</a></td>
					  <td >${resultData.gift}</td>
					  <td >${resultData.info}</td>
					  	<form action="<c:url value='/myBasket/add' /> " method="POST">
				
					 	 <td ><button style="background-color:#FF9100; color:white;" type="submit"><i class="fa fa-shopping-cart"></i> Add to Cart</button></td>
					 	 <input type="hidden" name="action" value="touch" >
					 	 <input type="hidden" name="forwardView" value="/myBasket/list" >
					 	 <input type="hidden" name="PRODUCT_IMG" value="${resultMap.product_img}" >
					 	 <input type="hidden" name="PRODUCT_NAME" value="${resultMap.product_name}" >
					 	 <input type="hidden" name="PRODUCT_PRICE" value="${resultData.price}" >
					 	 <input type="hidden" name="URI" value="${resultData.path}" >
					 	 <input type="hidden" name="SITE_NAME" value="${resultData.name}" >
					 	 <!--clap add in 7/22 -->
						<sec:authentication property="principal" var="principalBean"/>
				 	 	<sec:authorize access="isAuthenticated()">
					 	 <input type='hidden' name="MEMBER_SEQ" value="${principalBean.memberSeq}" >
						</sec:authorize>
					  	</form> 
					</tr>
					
				</c:forEach>
				</tbody>
			
			</table>
                
            </div>
		</div>
					</div>
					<div class="col-md-12">
						<div class="product-tab">
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
								<li><a data-toggle="tab" href="#tab1">Details</a></li>
								<li><a data-toggle="tab" href="#tab2">Reviews (3)</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active">
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
										irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
								</div>
								<div id="tab2" class="tab-pane fade in">

									<div class="row">
										<div class="col-md-6">
											<div class="product-reviews">
												<div class="single-review">
													<div class="review-heading">
														<div><a href="#"><i class="fa fa-user-o"></i> John</a></div>
														<div><a href="#"><i class="fa fa-clock-o"></i> 27 DEC 2017 / 8:0 PM</a></div>
														<div class="review-rating pull-right">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
														</div>
													</div>
													<div class="review-body">
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
													</div>
												</div>

												<div class="single-review">
													<div class="review-heading">
														<div><a href="#"><i class="fa fa-user-o"></i> John</a></div>
														<div><a href="#"><i class="fa fa-clock-o"></i> 27 DEC 2017 / 8:0 PM</a></div>
														<div class="review-rating pull-right">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
														</div>
													</div>
													<div class="review-body">
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
													</div>
												</div>

												<div class="single-review">
													<div class="review-heading">
														<div><a href="#"><i class="fa fa-user-o"></i> John</a></div>
														<div><a href="#"><i class="fa fa-clock-o"></i> 27 DEC 2017 / 8:0 PM</a></div>
														<div class="review-rating pull-right">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
														</div>
													</div>
													<div class="review-body">
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
													</div>
												</div>

												<ul class="reviews-pages">
													<li class="active">1</li>
													<li><a href="#">2</a></li>
													<li><a href="#">3</a></li>
													<li><a href="#"><i class="fa fa-caret-right"></i></a></li>
												</ul>
											</div>
										</div>
										<div class="col-md-6">
											<h4 class="text-uppercase">Write Your Review</h4>
											<p>Your email address will not be published.</p>
											<form class="review-form">
												<div class="form-group">
													<input class="input" type="text" placeholder="Your Name" />
												</div>
												<div class="form-group">
													<input class="input" type="email" placeholder="Email Address" />
												</div>
												<div class="form-group">
													<textarea class="input" placeholder="Your review"></textarea>
												</div>
												<div class="form-group">
													<div class="input-rating">
														<strong class="text-uppercase">Your Rating: </strong>
														<div class="stars">
															<input type="radio" id="star5" name="rating" value="5" /><label for="star5"></label>
															<input type="radio" id="star4" name="rating" value="4" /><label for="star4"></label>
															<input type="radio" id="star3" name="rating" value="3" /><label for="star3"></label>
															<input type="radio" id="star2" name="rating" value="2" /><label for="star2"></label>
															<input type="radio" id="star1" name="rating" value="1" /><label for="star1"></label>
														</div>
													</div>
												</div>
												<button class="primary-btn">Submit</button>
											</form>
										</div>
									</div>



								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- /Product Details -->
                

