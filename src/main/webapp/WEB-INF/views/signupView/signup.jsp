<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- jquery -->
<script src="<c:url value='/resources/js/jquery-3.3.1.min.js'/>"></script>

<!-- signup regex -->
<%-- <script src="<c:url value='/resources/js/signupRegex.js'/>"></script> --%>


<h2 class="col-sm-12" style="text-align: center; margin-bottom:40px;">sign up</h2>
	
	<form class="form-horizontal" role="form" action="<c:url value='/signupView/insert' />" method="POST">
	
	<!-- 1. email -->
	  <div class="form-group" id="email">
	    <label for="inputEmail" class="col-sm-2 control-label">Email</label>
	    <div class="col-sm-9">
	      <input type="text" name="EMAIL" class="form-control" id="inputEmail" placeholder="Email" value="">
	      <span id="emailCheckSymbol"></span>
	      <span id="emailCheckSymbolStatus"></span>
		  <p class="col-sm-1"></p>
	    </div>
	  </div>
	  
	 <!-- 2. email check -->
	  <div class="form-group" id="emailCheck">
	    <label for="inputEmailCheck" class="col-sm-2 control-label">Check-Email</label>
	    <div class="col-sm-9">
	      <input type="text" name="emailCheck" class="form-control" id="inputEmailCheck" placeholder="Check-Email">
	      <span id="emailCheckCheckSymbol"></span>
	      <span id="emailCheckCheckSymbolStatus"></span>
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  
	  <!-- 3. pw -->
	  <div class="form-group" id="PASSWORD">
	    <label for="inputPassword" class="col-sm-2 control-label">Password</label>
	    <div class="col-sm-9">
	      <input type="password" name="PASSWORD"  class="form-control" id="inputPassword" placeholder="영문대문자, 소문자, 숫자, 특수문자 1개 이상, 총 8자리 이상" value="">
	      <span id="passwordCheckSymbol"></span>
	      <span id="passwordCheckSymbolStatus"></span>
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  
	  <!-- 4. pw check -->
	  <div class="form-group" id="passwordCheck">
	    <label for="inputPasswordCheck" class="col-sm-2 control-label">Check-Password</label>
	    <div class="col-sm-9">
	      <input type="password" name="passwordCheck"  class="form-control" id="inputPasswordCheck" placeholder="Check-Password">
   	      <span id="passwordCheckCheckSymbol"></span>
	      <span id="passwordCheckCheckSymbolStatus"></span>
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  
	  <!-- 5. name -->
	  <div class="form-group">
	    <label for="inputName" class="col-sm-2 control-label">Name</label>
	    <div class="col-sm-9">
	      <input type="text" name="NAME" class="form-control" id="inputName" placeholder="Name" value="">
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  
	  <!-- 6. birthday -->
	  <div class="form-group">
	    <label for="inputBirthday" class="col-sm-2 control-label">Birthday</label>
	    <div class="col-sm-9">
	      <input type="date" name="USER_BIRTH" class="form-control" id="inputBirthday" placeholder="Birthday" value="">
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  
	  <!-- 7. Telephone Number -->
	  <div class="form-group">
	    <label for="inputTelNum" class="col-sm-2 control-label">Tel</label>
	    <div class="col-sm-9">
	      <input type="tel" name="PHONE" class="form-control" id="inputTelNum" placeholder="Telephone Num." value="">
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


			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">sign up</button>
					<button type="submit" class="btn btn-default">cancel</button>
				</div>
			</div>
	</form>