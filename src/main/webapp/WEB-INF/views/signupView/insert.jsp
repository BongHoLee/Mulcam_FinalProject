<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- jquery -->
<script src="<c:url value='/resources/js/jquery-3.3.1.min.js'/>"></script>

<!-- signup regex -->
<script src="<c:url value='/resources/js/signupRegex.js'/>"></script>

<h2 class="col-sm-12" style="text-align: center; margin-bottom:40px;">회원가입 완료!</h2>
	
	<form class="form-horizontal" role="form" action="">
	
	<!-- 1. email -->
	  <div class="form-group" id="email">
	    <label for="inputEmail" class="col-sm-2 control-label">Email</label>
	    <div class="col-sm-9">
	      <input type="text" name="EMAIL" class="form-control" id="inputEmail" placeholder="Email" value="${resultMap.EMAIL}" readonly>
	      <span id="emailCheckSymbol"></span>
	      <span id="emailCheckSymbolStatus"></span>
		  <p class="col-sm-1"></p>
	    </div>
	  </div>

	  

	  
	  <!-- 5. name -->
	  <div class="form-group">
	    <label for="inputName" class="col-sm-2 control-label">Name</label>
	    <div class="col-sm-9">
	      <input type="text" name="NAME" class="form-control" id="inputName" placeholder="Name" value="${resultMap.NAME}" readonly>
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  

	  
	  <!-- 7. Telephone Number -->
	  <div class="form-group">
	    <label for="inputTelNum" class="col-sm-2 control-label">Tel</label>
	    <div class="col-sm-9">
	      <input type="tel" name="PHONE" class="form-control" id="inputTelNum" placeholder="Telephone Num." value="${resultMap.PHONE}" readonly>
	      <p class="col-sm-1"></p>
	    </div>
	  </div>

<!-- 	  <!-- 8. address
	  10 : 경기도
	  20 : 전라도
	  30 : 경상도
	   -->
	 
	  <!-- <div class="form-group">
	    <label for="inputAddr" class="col-sm-2 control-label">Address</label>
	    <div class="col-sm-9">
		    <div class="btn-group btn-group-toggle" data-toggle="buttons" id="inputAddr">
			<label class="btn btn-secondary active">
		    	<input type="radio" name="ADDRESS_SEQ" value="4000" autocomplete="off" checked> 서울
		 	</label>
		    <label class="btn btn-secondary">
		    	<input type="radio" name="ADDRESS_SEQ" value="4001" autocomplete="off"> 부산
		  	</label>
		  	<label class="btn btn-secondary">
		    	<input type="radio" name="ADDRESS_SEQ" value="4002" autocomplete="off"> 대구
		  	</label>
		</div>
	      <p class="col-sm-1"></p>
	    </div>
	  </div> -->
	  
	<!--    9. hobby
	  100 : 수영
	  200 : 음악감상
	  300 : 공부  -->
	  
	 
	  <!-- <div class="form-group">
	    <label for="inputHobbies" class="col-sm-2 control-label">Hobby</label>
	    <div class="col-sm-9">
		    <div class="btn-group btn-group-toggle" data-toggle="buttons" id="inputHobbies">
			<label class="btn btn-secondary">
		    	<input type="checkbox" name="HOBBY_SEQ" value="3000" > 축구
		 	</label>
		    <label class="btn btn-secondary">
		    	<input type="checkBox" name="HOBBY_SEQ" value="3001" > 야구
		  	</label>
		  	<label class="btn btn-secondary">
		    	<input type="checkBox" name="HOBBY_SEQ" value="3002" > 수영
		  	</label>
		</div>
	      <p class="col-sm-1"></p>
	    </div>
	  </div> -->

		<!-- <div class="form-group">
			<label for="inputauthority" class="col-sm-2 control-label">Authorirty</label>
			<div class="col-sm-9">
				<div class="btn-group btn-group-toggle" data-toggle="buttons" id="inputAuthority">
				<label class="btn btn-secondary">
					<select name="AUTH_SEQ">
						<option value="5000">ADMIN</option>
						<option value="5001">MANAGER</option>
						<option value="5002">CEO</option>
						<option value="5003">GUEST</option>
					</select>
				</div>
			</div> -->
	</form>