<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- security tag -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>	

	
<sec:authentication property="principal" var="principalBean"/>	

<!-- Main -->
<h2 class="col-sm-12" style="text-align: center; margin-bottom: 40px;">관심상품</h2>
<h4 class="col-sm-12" style="text-align: center; margin-bottom: 40px;">현재 uri를 통한 장바구니 등록은 11번가, G마켓, 옥션에서만 가능합니다.</h4>

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
						<th class="sorting_asc col-centered" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="img: activate to sort column descending"
							style="width: 100px;" aria-sort="ascending">제품이미지</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="productName: activate to sort column ascending"
							style="width: 50px;">쇼핑몰</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="detail: activate to sort column ascending"
							style="width: 300px;">제품명</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="price: activate to sort column ascending"
							style="width: 85px;">가격</th>
						<th class="sorting" tabindex="0" aria-controls="example"
							rowspan="1" colspan="1"
							aria-label="URI: activate to sort column ascending"
							style="width: 85px;">기능</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultMap.resultList}" var="resultData" varStatus="loop"> 
						<c:choose>
							<c:when test="${(loop.index) % 2 == 0}">
								<tr role="row" class="even">
							</c:when>
							<c:otherwise>
								<tr role="row" class="even">
							</c:otherwise>
						</c:choose>
								<td><a href="${resultData.URI}"><img class="center-block" src="${resultData.IMG}" alt="${resultData.GOODS_INFO}" style="width: 100px; height:100px;"></a></td>
								<td class="text-center" style="vertical-align:middle"><a href="${resultData.URI}">${resultData.STORE}</a></td>
								<td class="sorting_1" style="vertical-align:middle"><a href="${resultData.URI}">${resultData.GOODS_INFO}</a></td>
								<td class="text-right col-centered" style="vertical-align:middle">${resultData.PRICE}</td>
								<td class="text-center vertical-center" style="vertical-align:middle">
									<form role="form" action="<c:url value='/myBasket/update' />" method='POST'>
										<input type="hidden" name="MEMBER_SEQ" value="${principalBean.memberSeq}" />
										<input type="hidden" name="BOOKMARK_SEQ" value="${resultData.BOOKMARK_SEQ}" />
										<input type="hidden" name="forwardView" value="/myBasket/list" />
    									<button type="submit" name="action" value="purchased" class="btn primary-btn blue">구매완료</button><br>
   										<button type="submit" name="action" value="delete" class="btn primary-btn">제품삭제</button>
   									</form>
   								</td>
							</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th rowspan="1" colspan="1">이미지</th>
						<th rowspan="1" colspan="1">쇼핑몰</th>
						<th rowspan="1" colspan="1">제품명</th>
						<th rowspan="1" colspan="1">가격</th>
						<th rowspan="1" colspan="1">기능</th>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
<!-- /table -->

<!-- btn // only for manager -->
<div class="section">
	<div class="pull-right">
		<form role="form" action="<c:url value='/myBasket/add' />" method='POST'>
		  <fieldset>
			<input type="hidden" name="MEMBER_SEQ" value="${principalBean.memberSeq}"/>
			<input type="hidden" name="forwardView" value="/myBasket/list" />
			<input type="text" style="height: 40px;" name="URI" placeholder=" Paste product URL"/>
		    <button type="submit" name="action" value="crawl" class="primary-btn btn">신규등록</button>
		  </fieldset>
		</form>
	</div>
</div>
<!-- /btn  -->

