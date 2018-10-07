<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Main -->
<h2 class="col-sm-12" style="text-align: center; margin-bottom: 40px;">EVENT LIST</h2>

<!--  table -->
<div id="example_wrapper"
	class="dataTables_wrapper form-inline dt-bootstrap">
	<div class="row">
		<div class="col-sm-12">
			<table id="example"
				class="table table-striped table-bordered dataTable"
				style="width: 100%;" role="grid" aria-describedby="example_info">
				<thead>
					<tr role="row">
						<th class="sorting_asc" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="no: activate to sort column descending"
							style="width:50px;" aria-sort="ascending">MAINORSUB</th>	
						<th class="sorting_asc" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="no: activate to sort column descending"
							style="width:300px;" aria-sort="ascending">TITLE</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="title: activate to sort column ascending"
							style="width:60px;">STARTINGDAY</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="written date: activate to sort column ascending"
							style="width:60px;">FINISHINGDAY</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="written date: activate to sort column ascending"
							style="width:120px;">WRITEDATE</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultMap.resultList}" var="resultData"	varStatus="loop">
						<tr	class="${(loop.index+1)%2 == 2 ? 'odd gradeX' : 'even gradeC'}">
							<td>${resultData.MAINORSUB}</td>
							<td>
							<a href="<c:url value="/event/read?EVENT_SEQ=${resultData.EVENT_SEQ}" />">${resultData.TITLE}</a>
							</td>
							<td>${resultData.STARTINGDAY}</td>
							<td>${resultData.FINISHINGDAY}</td>
							<td>${resultData.WRITEDATE}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th rowspan="1" colspan="1">글번호</th>
						<th rowspan="1" colspan="1">메인서브</th>
						<th rowspan="1" colspan="1">제목</th>
						<th rowspan="1" colspan="1">시작일</th>
						<th rowspan="1" colspan="1">끝나는날</th>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>

	<!-- pagination example -->

</div>
<!-- /table -->

<!-- btn // only for manager -->
<div class="pull-right">
	<form role="form" action="<c:url value='/event/edit' />" method='POST'>
	  <fieldset>
		<input type="hidden" name="action" value="write" />
	    <button type="submit" class="btn btn-primary">이벤트등록</button>
	  </fieldset>
	</form>
</div>
<!-- /btn  -->