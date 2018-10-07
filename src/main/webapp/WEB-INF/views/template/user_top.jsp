<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script src="<c:url value='/resources/js/jquery-3.3.1.min.js'/> "></script>
	<!-- 카테고리목록 AJAX 통신을 위해 사용 -->
<script >
var alist="";
var fn_Blist="";
var clist="";

var fn_Alist = function(){

    $.ajax({ //jquery ajax
        url:"<c:url value='/AlistRequest'/>", //비동기통신할 주소
        type:'get',   //데이터전송방식
        data:$('form').serialize(), //form 태그 안의 데이터 전송
        dataType : "json", //서버측에서 전송한 데이터 해석할 타입
        contentType : "application/json; charset=UTF-8",
        success:function(result){ //통신 성공시 실행되는 함수 data는 서버측에서 전송한 데이터
            //console.log('success');   
        	//console.log(JSON.stringify(result.data));		//받아온 리스트 확인!
        	var list = result.data;
        	//console.log(list);
        	var category = "";
        	$('form').attr('action', "<c:url value='/ajaxRequest'/>");
        	

        	//for each문으로 list에 저장된 결과값들을 하나씩 가져온다 
        	$.each(list, function(i){
        		var imgUrl = "<c:url value='/resources/img/banner05.jpg'/>";
				//console.log((list[i])["CATEGORY_A_ID"]);  //list[i]는 Object임{Key:value}, Object[Key] -> value를 가져옴
            	 category+="<li class='dropdown side-dropdown B' id='"+(list[i])['CATEGORY_A_ID'] +"'><a class='dropdown-toggle' data-toggle='dropdown' aria-expanded='true'>"+(list[i])["CATEGORY_A_NAME"] +" <i class='fa fa-angle-right'></i></a>"
            	 + "<input type='hidden' name='CATEGORY_A_ID' value='"+(list[i])['CATEGORY_A_ID'] +"'>"
   				 + "<div class='custom-menu'>"
   				 + "<div class='row B-list'>"
   				+ "</div>"
/*   			+"<div class='row hidden-sm hidden-xs'>"
    			+"<div class='col-md-12'>"
   				+"<hr>"
   				+"<a class='banner banner-1' href='#'>"
   				+"<img src='"+imgUrl+"' >"
   				+"<div class='banner-caption text-center'>"
   				+"<h2 class='white-color'>NEW COLLECTION</h2>"
   				+"<h3 class='white-color font-weak'>HOT DEAL</h3>"
   				+"</div>"
   				+"</a>"
   				+"</div>"
   				+"</div>" */
   			+ "</div>"
   		+ "</li>";
        		
        	});
        	$("#category-list").html(category);		//추가한 카테고리를 html코드에 삽입한다
        }
    })

	
}// end fn_Alist

var fn_Blist = function(A_id){
	
	//console.log(A_id);	//인자로 들어온 id 확인
    $.ajax({ //jquery ajax
        url:"<c:url value='/BlistRequest'/>", //비동기통신할 주소
        type:'get',   //데이터전송방식
        data:{'CATEGORY_A_ID':A_id}, 		//Spring Controller에 Map 형식으로 데이터 전송(이게 되네?)
        dataType : "json", //서버측에서 전송한 데이터 해석할 타입
        contentType : "application/json; charset=UTF-8",
        success:function(result){ //통신 성공시 실행되는 함수 data는 서버측에서 전송한 데이터
            //console.log(A_id);   
        	//console.log(JSON.stringify(result.data));		//받아온 리스트(카테고리 맵) 확인
        	var list = result.Bdata;
        	console.log(list);
        	var category = "";
        	
        	//for each문으로 list에 저장된 결과값들을 하나씩 가져온다 
        	$.each(list, function(i){
				var bmap = list[i];						//Object를 obj 변수에 저장
				var b_id = bmap['CATEGORY_B_ID'];
				var b_name = bmap['CATEGORY_B_NAME'];
				var c_list = bmap['C_LIST'];
				
				category+="<div class='col-md-4' id='"+b_id+"'>"
						+ "<ul class='list-links'>"
						+ "<li><h3 class='list-links-title'>"+b_name+"</h3></li>";
						
				//C_list의 데이터를 꺼내기 위함
				$.each(c_list, function(j){
					var cmap = c_list[j];
					var c_id = cmap['CATEGORY_C_ID'];
					var c_name = cmap['CATEGORY_C_NAME'];
					var flag_category = '&flag=category';
					if(b_id == 'UUID-CB001'){
						var url = "<c:url value='/productView/productlist?search="+c_name+flag_category+"'/>";
						category += "<li><a href="+url+">"+c_name+"</a></li>";
					}else if(b_id == 'UUID-CB003'){
						var tmp = c_name + b_name;
						var url = "<c:url value='/productView/productlist?search="+tmp+flag_category+"'/>";
						category += "<li><a href="+url+">"+c_name+"</a></li>";
					}else if(b_id == 'UUID-CB004'){
						var tmp = b_name + c_name;
						var url = "<c:url value='/productView/productlist?search="+tmp+flag_category+"'/>";
						category += "<li><a href="+url+">"+c_name+"</a></li>";
					}else if(b_id == 'UUID-CB002'){
						var url = "<c:url value='/productView/productlist?search="+c_name+flag_category+"'/>";
						category += "<li><a href="+url+">"+c_name+"</a></li>";
						
					}
				});
				
				
				
				category += "</ul><hr class='hidden-md hidden-lg'> </div>";

        	});
        	
/*         	category +=	"<div class='col-md-4'>"
    			+"<ul class='list-links'>"
    			+"<li>"
    			+"<h3 class='list-links-title'>Categories</h3></li>"
    			+"<li><a href='#'>Women’s Clothing</a></li>"
    			+"<li><a href='#'>Men’s Clothing</a></li>"
    			+"<li><a href='#'>Phones & Accessories</a></li>"
    			+"<li><a href='#'>Jewelry & Watches</a></li>"
    			+"<li><a href='#'>Bags & Shoes</a></li>"	
    			+"</ul>"
    			+"</div>";
 */
     	
        	$(".row.B-list").html(category);		//추가한 카테고리를 html코드에 삽입한다
        	
		
        }
    });
	
} // end fn_Blist

	
	



   $(function(){
	 //.category-header클릭시 fn_Alist() 함수 실행
	   $('.category-header').click(function(){
		  fn_Alist(); 
	   });  
   });
   
   //동적으로 생성된 html 코드에 대해서 동적 바인딩을 하기 위한 메소드!(중요)
   //카테고리 B를 띄워주기 위한 이벤트 바인딩 클릭한 엘리먼트의 id를 보내주기 위해 this 키워드 사용
   $(document).on('click', '.dropdown.side-dropdown.B', function(){
	   fn_Blist($(this).attr('id'));
   });
    
</script>

<!-- HEADER -->
	<header>
	<sec:authentication property="principal" var="principalBean"/>
		<!-- top Header -->
		<div id="top-header">
			<div class="container">
				<div class="pull-left">
					<span>Welcome to E-shop!</span>

				</div>

				<div class="pull-right">
					<ul class="header-top-links">
						<li><a href="<c:url value='/notice/list'/> ">Notice</a></li>
						<sec:authorize access="hasAnyAuthority('MANAGER')">
						<li><a href="<c:url value='/event/list'/> ">EventList</a></li>
						<li><a href="<c:url value='/setting/memberMag'/> ">Member Management</a></li>
						</sec:authorize>
						
					</ul>
				</div>
			</div>
		</div>
		<!-- /top Header -->

		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="<c:url value='/'/> ">
							<img src="<c:url value='/resources/img/Ganadanawa.png' /> " style="width:270px; height:60px;" alt="">
						</a>
					</div>
					<!-- /Logo -->

					<!-- Search -->
					<div class="header-search">
						<form class="" action="<c:url value='/productView/productlist' /> ">
							<input class="input" type="text" name="search" placeholder="Enter your keyword" style="width:300px;">
							<button class="search-btn"><i class="fa fa-search"></i></button>
						</form>
					</div>
					<!-- /Search -->
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Account -->
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon" style="border:none;">
									
									<i class="fa fa-user-o fa-2x " aria-hidden="true"></i>
								</div>

								<sec:authorize access="isAnonymous()">
								<strong class="text-uppercase">My Account <i class="fa fa-caret-down"></i></strong>
								</sec:authorize>
								
								<sec:authorize access="isAuthenticated()">
								<strong class="text-uppercase">My Account<i class="fa fa-caret-down"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>                   </strong>
								</sec:authorize>
								
								
							</div>
							
							<sec:authorize access="isAnonymous()">
							<a href="<c:url value='/login' />" class="text-uppercase">Login</a> / <a href="<c:url value='/signupView/signup' />" class="text-uppercase">Join</a>
							<ul class="custom-menu">
								<li><a href="<c:url value='/login' />" ><i class="fa fa-unlock-alt"></i> Login</a></li>
								<li><a href="<c:url value='/signupView/signup' />" ><i class="fa fa-user-plus"></i> Create An Account</a></li>
							</ul>
							</sec:authorize>
							
							<sec:authorize access="isAuthenticated()">
							<a href="#" >${principalBean.username}</a>
							<ul class="custom-menu">
								
								<li><a href="<c:url value='/' />" >
								<i class="fa fa-unlock-alt"></i> My Info</a></li>
								<li><a href="<c:url value='/logout' />" ><i class="fa fa-user-plus"></i> Logout</a></li>
								<sec:authorize access="hasAnyAuthority('MANAGER')">
								<li><a href="<c:url value='/event/list'/> ">EventList</a></li>
								</sec:authorize>
							</ul>
							</sec:authorize>

							
							

						</li>
						<!-- /Account -->

						<!-- Cart -->
						<li class="header-cart dropdown default-dropdown">
							<a href="<c:url value='/myBasket/list' />" >
								<div class="header-btns-icon" style="border:none;">
									<i class="fa fa-shopping-cart fa-2x"></i>
									<span class="qty">
									<sec:authorize access="isAuthenticated()">
									<sec:authentication property="principal" var="principalBean"/>	
									${principalBean.myBasketCount}
									</sec:authorize>
									</span>
								</div>
								<strong class="text-uppercase">My Cart:</strong>
								<br>
								<sec:authorize access="isAuthenticated()">
								<span class="">${principalBean.myBasketCount} items</span>
								</sec:authorize>
							</a>

						</li>
						<!-- /Cart -->

						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn"><i class="fa fa-bars"></i></button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
				</div>
			</div>
			<!-- header -->
		</div>
		<!-- container -->
	</header>
	<!-- /HEADER -->
<form action=" " id="categoryForm">
<input type="hidden" name="CATEGORY_A_ID" value="hihi">
	<!-- NAVIGATION -->
	<div id="navigation">
		<!-- container -->
		<div class="container">
			<div id="responsive-nav">
				<!-- category nav -->
				<div class="category-nav show-on-click">
					<span class="category-header">Categories <i class="fa fa-list"></i></span>

					<!-- 카테고리 삽입될곳 -->
					<ul class="category-list" id="category-list">
						
					</ul>
			
				</div>
				<!-- /category nav -->

				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
				</div>
				<!-- menu nav -->
			</div>
		</div>
		<!-- /container -->
	</div>
	<!-- /NAVIGATION -->
	</form>
	

	