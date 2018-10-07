package com.project.app.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.app.component.MapParamCollector;
import com.project.app.service.CategoryService;

@Controller


public class CategoryController {
	
	@Autowired
	private CategoryService service;
	
	//AJAX 통신을 하기 위한 메소드
	//@ResponseBody시 리턴 객체를 json 형식으로 변환해서 리턴해준다.
	@RequestMapping(value = "/AlistRequest", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> AlistCall(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
			MapParamCollector paramMethodMap) throws Exception{
		
		
		Map<Object, Object> paramMap = paramMethodMap.getMap();
	    HashMap<String, Object> hashmap = new HashMap<String, Object>(); //HashMap을 이용해서 던져줌
	    
	    List resultList = (List)service.getList("category.Alist", null); // 서비스를 호출하여 쿼리 리스트를 담는다.
	    
	    hashmap.put("data", resultList); // 받아온 쿼리 리스트를 hashmap data에 담는다.
	   
	    return hashmap; // 화면으로 던져준다!!

	}
	
	
	//카테고리 '중, ' call 메소드
	@RequestMapping(value = "/BlistRequest", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> BlistCall(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
			MapParamCollector paramMethodMap) throws Exception{
		
		
		Map<Object, Object> paramMap = paramMethodMap.getMap();
	    HashMap<String, Object> hashmap = new HashMap<String, Object>(); //HashMap을 이용해서 던져줌
	    List resultList = (List)service.getSubCategory("category.Blist", paramMap); // 서비스를 호출하여 쿼리 리스트를 담는다.
	    
	    hashmap.put("Bdata", resultList); // 받아온 쿼리 리스트를 hashmap data에 담는다.
	   
	    return hashmap; // 화면으로 던져준다!!

	}
}
