<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html lang="en">
<head>
	<tiles:insertAttribute name="layout.header" />
</head>
<body>
		
			<!-- top -->
			<tiles:insertAttribute name="layout.top" />
			<!-- /top -->
			
			
	<!-- Body -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
			
				
				<tiles:insertAttribute name="layout.body" />

			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /body -->
	
			<!-- footer -->
			<tiles:insertAttribute name="layout.footer" />
			<!-- /footer -->
			

<!-- js -->
	<!-- jquery -->
	<script src="<c:url value='/resources/js/jquery-3.3.1.min.js'/>"></script>
	
	<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
	<script src="<c:url value='/resources/js/nouislider.min.js'/>"></script>
	<!-- script src="<c:url value='/resources/js/slick.min.js'/>"></script-->

	<script src="<c:url value='/resources/js/jquery.zoom.min.js'/>"></script>
	<script src="<c:url value='/resources/js/main.js'/>"></script>
	
	
	<!-- ganadanawa custum -->
<%-- 	<script src="<c:url value='#'/>"></script> --%>
	<!-- js and script dataTable -->
	<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>

	<!-- script data table -->
	<script>
	$(document).ready(function(){ $('#example').DataTable(); });
	</script>

</body>
	
</html>
