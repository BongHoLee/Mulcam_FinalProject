<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Main -->
<h2 class="col-sm-12" style="text-align: center; margin-bottom: 40px;">MEMBER LIST</h2>

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
							style="width:50px;" aria-sort="ascending">NAME</th>	
						<th class="sorting_asc" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="no: activate to sort column descending"
							style="width:300px;" aria-sort="ascending">EMAIL</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="title: activate to sort column ascending"
							style="width:60px;">PHONE</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="written date: activate to sort column ascending"
							style="width:60px;">AUTHORITY</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="written date: activate to sort column ascending"
							style="width:120px;">REGISTER DATE</th>
							<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="written date: activate to sort column ascending"
							style="width:120px;">DELETE</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList}" var="resultData"	varStatus="loop">
						<tr	class="${(loop.index+1)%2 == 2 ? 'odd gradeX' : 'even gradeC'}">
							<td>${resultData.NAME}</td>
							<td>${resultData.EMAIL}</td>
							<td>${resultData.PHONE}</td>
							<td>${resultData.AUTHORITY}</td>
							<td>${resultData.REGISTERDATE}</td>
							<c:if test="${resultData.AUTHORITY == 'USER'}">
							<td class="text-center vertical-center"><a href="<c:url value='/setting/delete?EMAIL=${resultData.EMAIL}' />"><button type='button' class='btn btn-danger'>DELETE</button></a></td>
							</c:if>
							<c:if test="${resultData.AUTHORITY == 'MANAGER'}">
							<td class="text-center vertical-center">-</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<!-- pagination example -->

</div>
<!-- /table -->
