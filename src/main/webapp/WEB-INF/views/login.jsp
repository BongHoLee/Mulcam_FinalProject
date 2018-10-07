<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

    <!-- login  -->
	<h2 class="col-sm-12" style="text-align: center; margin-bottom:40px;">log in</h2>
	<form class="form-signin" role="form" action="<c:url value='/j_spring_security_check' />" method="POST">
	  <div class="form-group">
	    <label for="inputEmail" class="col-sm-2 control-label">Email</label>
	    <div class="col-sm-9">
	      <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Email">
	      <p class="col-sm-1"></p>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword" class="col-sm-2 control-label">Password</label>
	    <div class="col-sm-9">
	    <input type="password" name="password" class="form-control" id="inputPassword" placeholder="Password">
    	<br>			
		<p>-admin-</p>
		<p>ID : admin@gmail.com</p>
		<p>PW : 1234</p>
		<p>-user-</p>
		<p>ID : user@gmail.com</p>
		<p>PW : 1234</p>
   				
			<p class="col-sm-10" style="padding-left: 0px;color:red;"> 
   				<c:choose>
				    <c:when test="${paramMap.fail eq 'true'}">
				        로그인실패
				    </c:when>
				    <c:otherwise>
				    </c:otherwise>
				</c:choose>
				
			</p>
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-default">log in</button>
	    </div>
	  </div>
	</form>
