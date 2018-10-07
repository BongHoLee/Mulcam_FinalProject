<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- security tag -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
 
/* read -> edit */
var saveBtnHtml = "<button type='button' id='editCompleteBtn' class='btn btn-default pull-right'>수정완료</button>";
	$(function(){
	   /* 추가버튼생성 스크립트 */
		$('#editBtn').click(function(){
		   $('#saveBtn').html(saveBtnHtml);
		   $('#inputTitle').attr({'readonly':false});
		   $('#inputContent').attr({'readonly':false});
	   });
	   
	   $(document).on("click","#editCompleteBtn",function(){
		   $('#EditFormId').submit();
	   });
	});
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
	               <td><input id="inputTitle" type="text" value="${resultMap.TITLE}" placeholder="제목을 입력하세요." name="TITLE" class="form-control" readonly='true'/></td>
	           </tr>
	           <tr>
	               <th>내용: </th>
	               <td><textarea id="inputContent" cols="10" name="CONTENT" class="form-control" style="height:300px;" readonly="true" >${resultMap.CONTENT}</textarea></td>
	           </tr>
	           <tr>
	               <th>작성자: </th>
	               <td><input id="inputName" type="text" value="${resultMap.NAME}" class="form-control" readonly/></td>
	           </tr>
	           <tr>
	               <td colspan="3">
	                   <button type="button" name="action" value="cancel" class="btn btn-default pull-right">
	                   취소</button>
	                   
	                   <sec:authentication property="principal" var="principalBean"/>
	                   <sec:authorize access="hasAnyAuthority('MANAGER')">
						   <button type="button"class="btn btn-default pull-right">
		                   <a href="<c:url value='/notice/delete?NOTICE_SEQ=${resultMap.NOTICE_SEQ}' />" >삭제</a></button>
		                   
						   <button type="button" id="editBtn" class="btn btn-default pull-right">
		                   수정</button>
					   </sec:authorize>
					   
	                   <!-- 추가버튼을 넣을 자리 -->
	                   <span id="saveBtn"></span>
	               </td>
	           </tr>
	           <%-- <input type="hidden" name="WRITEDATE" value="${resultMap.WRITEDATE}" /> --%>
	           <input type="hidden" name="NOTICE_SEQ" value="${resultMap.NOTICE_SEQ}" />
	           <input type="hidden" name="MEMBER_SEQ" value="${resultMap.MEMBER_SEQ}" />
	       </form>
	   </tbody>
	</table>
	</div>

