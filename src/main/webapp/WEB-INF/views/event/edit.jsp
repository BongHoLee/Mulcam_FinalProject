<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Map" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!--  Product Details -->
<div class="product product-details clearfix">
	<div class="col-md-6">
		<div id="product-main-view">
		<!-- 상품 이미지 삽입 -->
			<div class="product-view">
				<img id="blah" src="<c:url value='/resources/uploads/${resultMap.IMG}' /> "
					alt="">
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="product-body">
			<h2 class="product-name">이벤트</h2>
			<h4 class="text-uppercase">Write Your Event</h4>
			<p>here is only manager</p>
			
			<!-- 이벤트 프리뷰 js -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
			
			<form class="review-form" enctype="multipart/form-data" method="POST"
				action="<c:url value='/event/merge' />">
				<input type="hidden" name="EVENT_SEQ" value='${resultMap.EVENT_SEQ}'>
				<div class="form-group">
					<h4 class="text-uppercase">Select your priority</h4>
					<select class="form-control" name="MAINORSUB">
						<option value="MAIN" <c:if test="${resultMap.MAINORSUB == 'MAIN'}">selected</c:if>>Main</option>
						<option value="SUB1" <c:if test="${resultMap.MAINORSUB == 'SUB1'}">selected</c:if>>Sub1</option>
						<option value="SUB2" <c:if test="${resultMap.MAINORSUB == 'SUB2'}">selected</c:if>>Sub2</option>
					</select>
				</div>
				<div class="form-group">
					<h4 class="text-uppercase">STARTINGDAY</h4>
					<input type='date' class='input'name="STARTINGDAY" value="${resultMap.STARTINGDAY }" data-language='en'/>
				</div>
				<div class="form-group">
					<h4 class="text-uppercase">FINISHINGDAY</h4>
					<input class="input" type="date" name="FINISHINGDAY"
						value="${resultMap.FINISHINGDAY}" placeholder="Event Finish" />
				</div>
				<div class="form-group">
					<h4 class="text-uppercase">TITLE</h4>
					<input class="input" type="text" name="TITLE" value="${resultMap.TITLE}" />
				</div>
				<div class="form-group">
					<h4 class="text-uppercase">KEYWORD</h4>
					<input class="input" type="text" name="KEYWORD" value="${resultMap.KEYWORD}" />
					
				</div> 
				<!--  파일 업로드 버튼 -->
				<div class="form-group">
					<h4 class="text-uppercase">Choose IMG</h4>
					<input type="text" name="IMG" value='${resultMap.IMG}'>
					<input type="file" id="imgInp" name="ATTACHEDFILES01" />
				</div>
				<button type="submit" class="primary-btn">Button</button>
			</form>
		</div>
	</div>

	<!-- /Product Details -->

</div>

<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#blah').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	$("#imgInp").change(function() {
		readURL(this);
	});
</script>
</div>


