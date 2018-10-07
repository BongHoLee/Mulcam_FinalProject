<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



<div class="section">
<div class="container">
		
		
		<c:forEach items="${resultList}" var="resultData" varStatus="loop">
		
		<c:if test="${(loop.index)%4 == 0}">
			<!-- row -->
			<div class="row">
			</c:if>
			
			<c:if test="${(loop.index)==0}">
				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
						<h2 class="title">Picked For You</h2>
					</div>
				</div>
				<!-- section title -->
				</c:if>

				
				<!-- Product Single -->
				<div class="col-md-3 col-sm-6 col-xs-6" style="width:292.5px; height:490px; " >
					<div class="product product-single" style="width:292px; height:477px;">
						<div class="product-thumb" >
							<c:choose>
								<c:when test='${(resultData.productType) == 1}'>
									
									<a href="<c:url value='/productView/productcompare?link=${resultData.link}'/> ">
									
								</c:when>
								<c:otherwise>
									<a href="${resultData.link}" target="_blank">
								</c:otherwise>
								</c:choose>
								<button class="main-btn quick-view"><i class="fa fa-search-plus"></i> Quick view</button>
								<img src="${resultData.image}" style="width:280px; height:300px;"alt="">
							</a>
							
						</div>
						<div class="product-body" >
							<h3 class="product-price">최저가 ${resultData.lprice} </h3>
							<div class="product-rating">
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star-o empty"></i>
							</div>
							
							<h2 class="product-name"><a href="#">${resultData.title}</a></h2>
							
							<div class="product-btns">
								<button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
								<button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
								
							</div>
						</div>
 					</div> 
				</div>
				
				
				<!-- /Product Single -->

				<c:choose>
					<c:when test="${(loop.index+1)%4 == 0 }">
					
					</div>
					
					</c:when>
					<c:when test="${fn:length(resultList)==(loop.index+1)}">
					
					</div>
					
					</c:when>
				</c:choose>
				
				</c:forEach>
				
		

				</div>
				</div>


			
			
