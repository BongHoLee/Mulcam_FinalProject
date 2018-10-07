package com.project.app.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class CompareCrawlService {
	
	public Object getProductInfo(String uri) {
		//결과적으로 여러번의 크롤링을 진행함(판매처 개수별 redirect 경로를 구하기 위한 크롤링을 진행)
		

		
		//상품에 대한 판매처Map을 담기 위한 List(결과적으로 판매처의 정보는 Map에 담기고 해당 Map들이 List에 담기며 이 List가 다시 resultMap에 담긴다)
		List<Object> resultList = new ArrayList<>();
		
		//상품의 정보와 해당 상품의 판매처 정보를 담기 위한 Map
		Map<String, Object> resultMap = new HashMap<>();
				
		//크롤링을 위한 Document 객체
		Document doc;
		
		
		try {
			
			//1차 크롤링
			//첫 번째 크롤링을 통해 redirect되는 URL을 얻어서 defaultUrl과 합쳐준다.
			String defaultUrl = "http://search.shopping.naver.com";
			
			
			//지정한 uri의 html태그를 모두 가져옴(문자열 형태)
			doc = Jsoup.connect(uri).get();	
		
			
			//<script> 태그 내의 redirect 부분을 가져오기 위한 코드
			Elements redirect = doc.select("script");
			String str = redirect.html();
			String extractUrl[] = str.split("'");
			String url = defaultUrl + extractUrl[1];	
			
			//네이버 쇼핑 판매처 목록 페이지 이동
			

			
			//2차 크롤링
			//redirect를 얻어온 URL을 다시 crawling
			doc = Jsoup.connect(url).get();
			
			
			//resultMap에 담기 위한 상품의 정보들을 추출(CSS 선택자를 이용해서 선택 가능)
			Elements product_name = doc.select(".summary_inner .h_area h2");
			Elements product_lprice = doc.select(".detail_summary .num");
			Elements product_img = doc.select(".detail_summary #summaryImage #viewImage");
			Elements seller_tb = doc.select(".tbl_lst ._itemSection");
			
			resultMap.put("product_name", product_name.text());
			resultMap.put("product_lprice", product_lprice.text());
			resultMap.put("product_img", product_img.attr("src"));
			
			
			//판매처별 정보를 담고 있는 sellerTb의 요소 하나하나를 link라는 이름으로 추출
			for(Element link : seller_tb) {
				
				//판매처의 정보를 담기 위한 Map
				Map<String, Object> sellerMap = new HashMap<>();
				
				
				
				//먼저 판매처의 이미지, 이름, 가격을 저장
				sellerMap.put("img", (String)(link.select(".mall img[src]").attr("src")));
				sellerMap.put("name", (String)(link.select(".mall a").text()));
				if(("").equals(link.select(".mall a").text())) {
					sellerMap.put("name", (String)(link.select(".mall img[src]").attr("alt")));
				}
				sellerMap.put("price", (String)(link.select(".price a").text()));
				sellerMap.put("gift", (String)(link.select(".gift").text()));
				sellerMap.put("info", (String)(link.select(".info").text()));
				
				
				
				//판매처 URL에 따라 redirect(크롤링으로 direct path 구함) or direct(크롤링 하지 않고 바로 path로 연결)
				//redirect -> contains(adcrNoti.nhn) &&& direct -> contains(adcr.nhn)
				url = (String)(link.select(".mall a").attr("href"));
				if(url.contains("adcrNoti.nhn")) {
					//redirect 경로이므로 크롤링해서 구한 URL을 취합해준다.
					
					//3차 크롤링
					//판매처별 path가 중간 redirect를 거치지 않기 위해 다시 Crawling
					//redirect 경로를 따로 크롤링으로 구해서 덧붙여준다. (최종 path)
					
					doc = Jsoup.connect(url).get();
					redirect = doc.select("script");
					str = redirect.html();
					String extract[] = str.split("\"");
					url = "http://cr2.shopping.naver.com" + extract[3];
				}
				
				//최종적으로 구한 URL을 Map에 저장(redirect도 이제 direct url로 간다)
				sellerMap.put("path", url);

				//정보가 삽입된 판매처 Map을 List에 삽입
				resultList.add(sellerMap);
			}
			//판매처별 정보를 Map형태로 담고 있는 List를 Map에 저장 (Map > List > Map 구조)
			resultMap.put("seller", resultList);
						
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return resultMap;
	}

}
