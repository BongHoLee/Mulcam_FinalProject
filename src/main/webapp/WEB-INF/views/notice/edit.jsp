<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- security tag -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>

</script>

<!-- Main -->
<h2 class="col-sm-12" style="text-align: center; margin-bottom: 40px;">notice-detail</h2>

<!--  table -->
<div class="container">
	<table class="table table-bordered">
	   <tbody>
	       <form id="EditFormId" action="<c:url value='/notice/save' />" method="post">
	           <tr>
	               <th>제목: </th>
	               <td><input id="inputTitle" type="text" value="" placeholder="제목을 입력하세요." name="TITLE" class="form-control" /></td>
	           </tr>
	           <tr>
	               <th>내용: </th>
	               <td><textarea id="inputContent" cols="10" name="CONTENT" class="form-control" style="height:300px;" ></textarea></td>
	           </tr>
	           <tr>
	               <th>작성자: </th>
	               	<sec:authentication property="principal" var="principalBean"/>
	               <td><input id="inputName" type="text" value="${principalBean.memberName}" class="form-control" readonly/></td>
	           </tr>
	           <tr>
	               <td colspan="3">
	                   <button type="submit" name="action" value="" class="btn btn-default pull-right">
	                   공지등록</button>
	                   
	                   <!-- 추가버튼을 넣을 자리 -->
	                   <span id="saveBtn"></span>
	               </td>
	           </tr>
	           <%-- <input type="hidden" name="WRITEDATE" value="${resultMap.WRITEDATE}" /> --%>
	           <input type="hidden" name="NOTICE_SEQ" value="" />
	           <input type="hidden" name="MEMBER_SEQ" value="${principalBean.memberSeq}" />
	       </form>
	   </tbody>
	</table>
	</div>

