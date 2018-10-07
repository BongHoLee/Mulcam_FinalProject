<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- security tag -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- Main -->
<h2 class="col-sm-12" style="text-align: center; margin-bottom: 40px;">notice</h2>

<!--  table -->
<div id=""
	class="dataTables_wrapper form-inline dt-bootstrap">
	<div class="row">
		<div class="col-sm-12">
			<table id=""
				class="table table-striped table-bordered"
				style="width: 100%;" role="grid" aria-describedby="example_info">
				<thead>
					<tr role="row">
						<th	class="col-sm-1 text-center">글번호</th>
						<th class="col-sm-8 text-center">제목</th>
						<th class="col-sm-3 text-center">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultMap.resultList}" var="resultData" varStatus="loop">
						<tr role="row" >
							<td class="text-center">${resultMap.resultList.size() - loop.index}</td>
							<td><a href="<c:url value='/notice/read?NOTICE_SEQ=${resultData.NOTICE_SEQ}'/> "> &nbsp; ${resultData.TITLE}</a></td>
							<td class="text-center">${resultData.WRITEDATE}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th class="text-center" rowspan="1" colspan="1">글번호</th>
						<th class="text-center" rowspan="1" colspan="1">제목</th>
						<th class="text-center" rowspan="1" colspan="1">작성일</th>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>

	<!-- pagination example -->

</div>
<!-- /table -->

<sec:authorize access="isAuthenticated()">
<!-- btn // only for manager -->
<div class="pull-right">
	<form role="form" action="<c:url value='/notice/edit' />" method='POST'>
	  <fieldset>
		<!-- <input type="hidden" name="action" value="write" /> -->
	    <button type="submit" class="btn btn-primary">공지등록</button>
	  </fieldset>
	</form>
</div>
</sec:authorize>
<!-- /btn  -->