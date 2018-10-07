package com.project.app.service;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



@Service
public class ApiService {
	//RestTemplate관련 정보 참고
	//http://blog.saltfactory.net/java/post-multipart-form-data-using-resttemplate-in-spring.html
	//http://javaiyagi.tistory.com/457
	//http://hacks.claztec.net/2015/08/24/spring-resttemplate.html
	
	//네이버 쇼핑 검색 API를 처리하는 서비스
	//REST API를 사용하기 위한 Client_id와 Clinet_secret이 필요(어플리케이션 등록 후 발급을 받아야함. 따로 파일저장 고려
	private static final String CLIENT_ID = "UvuNatrc34pQbrSLC2P4";
	private static final String CLIENT_SECRET = "Yya1LsDYmX";
	private static final String URL = "https://openapi.naver.com/v1/search/shop";
	
	//http 패킷 헤더에 정보를 삽입하여 REST API를 요청해야 하기 때문에 필요 (Client_ID와 Client_Secret이 맵에 삽입되어 넘어간다.)
	private HttpEntity<?> headers;
	
	//Java에서 제공하는 RestTemplate을 이용하여 손쉽게 REST API요청이 가능
	//RestTemplate은 Json이나 Xml형태의 응답을 쉽게 '객체'로 바꾸어 사용 가능(Map에도 매핑이 가능)
	private RestTemplate template = new RestTemplate();
	
	public Object searchApi(String search)  {
		//RestTemplate 사용시 HashMap을 이용하면 값 전달이 안된다.
		//MultiValueMap을 이용해야함(내부적으로 지원하는 컨버터가 HashMap이 아닌 MultiValueMap으로 되어있음)
		
		
		//패킷 헤더에 클라이언트 Key값과 Content-Type정보를 담는다.
		MultiValueMap<String, String> headerMap = new LinkedMultiValueMap<>();
        headerMap.add("X-Naver-Client-Id", CLIENT_ID);
        headerMap.add("X-Naver-Client-Secret", CLIENT_SECRET);
        headerMap.add("Content-Type", MediaType.APPLICATION_JSON_VALUE);
        this.headers = new HttpEntity<>(headerMap);
        
       String url = URL + "?display=20&query="+search;
       System.out.println(search);
       
       //RestTemplate.exchange를 이용하여 요청 URL과 요청 메소드, 헤더, 그리고 반환 객체를 명시하여 요청을 한다.
       ResponseEntity<Map> responseEntity = template.exchange(url, HttpMethod.GET, headers, Map.class);
       
       

       
       //ResponseEntity.getBody() 메소드로 요청 결과값을 요청 객체 형태로 반환(Map)받는다.
       Map<String, Object> mapbody = responseEntity.getBody();
       
       //반환받은 결과값중 실제 상품의 정보가 List형태로 담긴 <items>부분을 추출하여 resultList에 담는다.
       List<Map> resultList = (List)mapbody.get("items");
       
       return resultList;
       

	}
	
	
}
