<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<div class="section">
<div class="container">
		
		
		<c:forEach items="${resultList}" var="resultData" varStatus="loop">
		
		<c:if test="${(loop.index)%4 == 0}">
			<!-- row -->
			<div class="row">
			</c:if>
	<div class="container">
		<div class="row">
			<!-- banner -->
			<div class="col-md-8">
				<div class="banner banner-1">
					<img
						src="<c:url value='/resources/uploads/${resultList.get(0).IMG}' /> "
						alt="" style="width: 750px; height: 571px;">
					<div class="banner-caption text-center">
					</div>
				</div>
			</div>
			<!-- /banner -->

			<!-- banner -->
			<div class="col-md-4 col-sm-6">
				<a class="banner banner-1" href="#"> <img
					src="<c:url value='/resources/uploads/${resultList.get(1).IMG}'/> "
					alt="" style="width: 360px; height: 270px;">
					<div class="banner-caption text-center">
					</div>
				</a>
			</div>
			<!-- /banner -->

			<!-- banner -->
			<div class="col-md-4 col-sm-6">
				<a class="banner banner-1" href="#"> <img
					src="<c:url value='/resources/uploads/${resultList.get(2).IMG}' /> " alt="" style="width: 360px; height: 270px;">
					<div class="banner-caption text-center">
					</div>
				</a>
			</div>
			<!-- /banner -->
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /section -->

<!-- section -->
<div class="section"style="padding-bottom: 0px";>
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- section title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">Hot items in the Basket</h2>
				</div>
			</div>
		
			<c:forEach items="${resultMap.myBasketRankList}" var="myBasketList" varStatus="loop">
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="product product-single">
						<div class="product-thumb">
							<button class="main-btn quick-view">
								<i class="fa fa-search-plus"></i><a href="${myBasketList.URI}"> Quick view</a>
							</button>
							<img src="${myBasketList.IMG}" alt="">
						</div>
						<div class="product-body">
							<h3 class="product-price">${myBasketList.PRICE}</h3>
							<div class="product-rating">
								<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
									class="fa fa-star"></i> <i class="fa fa-star"></i> <i
									class="fa fa-star-o empty"></i>
							</div>
							<h2 class="product-name">
								<a href="${myBasketList.URI}">${myBasketList.GOODS_INFO}</a>
							</h2>
							<div class="product-btns">
								<button class="main-btn icon-btn">
									<i class="fa fa-heart"></i>
								</button>
								<button class="main-btn icon-btn">
									<i class="fa fa-exchange"></i>
								</button>
								<button class="primary-btn add-to-cart">
									<i class="fa fa-shopping-cart"></i> Add to Cart
								</button>
							</div>
						</div>
					</div>
				</div>

			</c:forEach>
			<!-- /Product Single -->
			
	
			
		</div>
	</div>
</div>

<!-- Chart -->
<div id="click_chart_div" style="height: 250px"></div>
<div id="basket_chart_div" style="height: 250px"></div>

<!-- click chart에 띄울 값을 json 타입으로 가져온다   -->
<script>
var resultList = new Array();

var fn_DStatistics = function( callBackFunc ){
	
    $.ajax({ //jquery ajax
        url:"<c:url value='/StatisticsRequest'/>", 
        type:'get',   //데이터전송방식
        data:{ get_param: 'value' }, //form 태그 안의 데이터 전송
        dataType : "json", //서버측에서 전송한 데이터 해석할 타입
        contentType : "application/json; charset=UTF-8",
        success:function(result){ //통신 성공시 실행되는 함수 data는 서버측에서 전송한 데이터
            
        	var list = result.Statistics_D;
        	//console.log(list);
        
			// 차트의 컬럼명 정의 
        	var tempList = new Array('KEYWORD', 'TODAY_CLICK');
        		resultList[0] = tempList;
        
        	$.each(list, function(i){
        		var tempList = new Array(list[i].KEYWORD, list[i].TODAY_CLICK);
        		resultList[i+1] = tempList;
        		
        	});
        }
    })
	
}

</script>

<!-- click chart에 관한 옵션  -->
<script type="text/javascript">
function drawChartClick(){
	google.charts.load('current', {
		packages : [ 'corechart', 'bar' ]
	});
	google.charts.setOnLoadCallback(drawBasic);

	function drawBasic() {
		//console.log(resultList);
		var data = google.visualization.arrayToDataTable(resultList);
	
		var options = {
			//title : 'Today\'s Hot Category',
			chartArea : {
				width : '60%'
			},
			hAxis : {
				title : 'Today\'s Click',
				minValue : 0
			},
			vAxis : {
				title : 'Keyword'
			}
			
			<c:if test="${(loop.index)==0}">
				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
						<h2 class="title">Picked For You</h2>
					</div>
				</div>
				<!-- section title -->
				</c:if>

				
				<!-- Product Single -->
				<div class="col-md-3 col-sm-6 col-xs-6" style="width:292.5px; height:490px; " >
					<div class="product product-single" style="width:292px; height:477px;">
						<div class="product-thumb" >
							<c:choose>
								<c:when test='${(resultData.productType) == 1}'>
									
									<a href="<c:url value='/productView/productcompare?link=${resultData.link}'/> ">
									
								</c:when>
								<c:otherwise>
									<a href="${resultData.link}" target="_blank">
								</c:otherwise>
								</c:choose>
								<button class="main-btn quick-view"><i class="fa fa-search-plus"></i> Quick view</button>
								<img src="${resultData.image}" style="width:280px; height:300px;"alt="">
							</a>
							
						</div>
						<div class="product-body" >
							<h3 class="product-price">최저가 ${resultData.lprice} </h3>
							<div class="product-rating">
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star-o empty"></i>
							</div>
							
							<h2 class="product-name"><a href="#">${resultData.title}</a></h2>
							
							<div class="product-btns">
								<button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
								<button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
								
							</div>
						</div>
 					</div> 
				</div>
				
				
				<!-- /Product Single -->

				<c:choose>
					<c:when test="${(loop.index+1)%4 == 0 }">
					
					</div>
					
					</c:when>
					<c:when test="${fn:length(resultList)==(loop.index+1)}">
					
					</div>
					
					</c:when>
				</c:choose>
				
				</c:forEach>
				
		

				</div>
				</div>
		chart.draw(data, options);
	};
};
</script>



var fn_BasketStatistics = function( callBackFunc ){
	
    $.ajax({ //jquery ajax
        url:"<c:url value='/BasketStatisticsRequest'/>", 
        type:'get',   //데이터전송방식
        data:{ get_param: 'value' }, //form 태그 안의 데이터 전송
        dataType : "json", //서버측에서 전송한 데이터 해석할 타입
        contentType : "application/json; charset=UTF-8",
        success:function(result){ //통신 성공시 실행되는 함수 data는 서버측에서 전송한 데이터
            
        	var list = result.Basket_Statistics;
        	//console.log(list);
        
			// 차트의 컬럼명 정의 
        	var tempList = new Array('HOT GOODS', 'MOST ADD');
        		resultList_Basket[0] = tempList;
        
        	$.each(list, function(i){
        		var tempList = new Array(list[i].GOODS_INFO, list[i].MOST_ADD);
        			resultList_Basket[i+1] = tempList;
        		
        	});
        }
    })
}

</script>

<!-- basket chart에 관한 옵션  -->
<script type="text/javascript">
function drawChartBasket(){
	google.charts.load('current', {
		packages : [ 'corechart', 'bar' ]
	});
	google.charts.setOnLoadCallback(drawBasic);

	function drawBasic() {
		//console.log(resultList);
		var data = google.visualization.arrayToDataTable(resultList_Basket);
	
		var options = {
			//title : 'Today\'s Hot Category',
			chartArea : {
				width : '60%'
			},
			hAxis : {
				title : 'Selected Products',
				minValue : 0
			},
			vAxis : {
				title : 'Hot Goods'
			}
			
			
		};

		var chart = new google.visualization.BarChart(document
				.getElementById('basket_chart_div'));

		chart.draw(data, options);
	};
};

// ajax 실행 후, google chart api 실행(by callbackFunction)
	$(document).ready(function(){
	    fn_DStatistics(drawChartClick()); 
		fn_BasketStatistics(drawChartBasket()); 
	}); 
</script>



