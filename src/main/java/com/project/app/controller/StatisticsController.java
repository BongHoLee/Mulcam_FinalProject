package com.project.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.app.component.MapParamCollector;
import com.project.app.service.StatisticsService;

@Controller
public class StatisticsController {
	
	@Autowired
	private StatisticsService service;
		
		@RequestMapping(value = "/StatisticsRequest", method = { RequestMethod.GET, RequestMethod.POST })
		public @ResponseBody Map<String, Object> StatisticsCall(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
				MapParamCollector paramMethodMap) throws Exception{
			
			
			Map<Object, Object> paramMap = paramMethodMap.getMap();
		    HashMap<String, Object> hashmap = new HashMap<String, Object>(); //HashMap을 이용해서 던져줌

		    List resultList = (List)service.getClickStatistics(paramMap); // 서비스를 호출하여 쿼리 리스트를 담는다.
		    
		    hashmap.put("Statistics_D", resultList); // 받아온 쿼리 리스트를 hashmap data에 담는다.
		    
		    return hashmap; // 화면으로 던져준다!!

		}
		
		@RequestMapping(value = "/BasketStatisticsRequest", method = { RequestMethod.GET, RequestMethod.POST })
		public @ResponseBody Map<String, Object> BasketStatisticsCall(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
				MapParamCollector paramMethodMap) throws Exception{
			
			Map<Object, Object> paramMap = paramMethodMap.getMap();
		    HashMap<String, Object> hashmap = new HashMap<String, Object>(); //HashMap을 이용해서 던져줌

		    List resultList = (List)service.getBasketStatistics(paramMap); // 서비스를 호출하여 쿼리 리스트를 담는다.
		    
		    hashmap.put("Basket_Statistics", resultList); // 받아온 쿼리 리스트를 hashmap data에 담는다.
		    
		    return hashmap; // 화면으로 던져준다!!

		}
}
