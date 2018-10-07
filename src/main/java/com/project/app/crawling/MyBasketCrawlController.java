package com.project.app.crawling;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.app.component.MapParamCollector;

@Controller
public class MyBasketCrawlController {
	private final static String MAPPING = "/crawling/";
	
	@Autowired
	private MyBasketCrawlService myBasketCrawlService;
	
	@RequestMapping(value = MAPPING+"{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap
			, MapParamCollector paramMethodMap
			, @PathVariable String action
			,ModelAndView modelandView) {

		Map<Object, Object> paramMap = paramMethodMap.getMap();		
		
		String viewName = MAPPING + action ;
		String forwardView = (String) paramMap.get("forwardView") ;

		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		List<Object> resultList = new ArrayList<Object>();

		// divided depending on action value
		if ("myBasketAdd".equalsIgnoreCase(action)) {
			myBasketCrawlService.saveObject(paramMap);
			resultMap = (Map<String, Object>) myBasketCrawlService.getProductInfoMap(paramMap);
		} 
		
		if(forwardView != null){
			viewName = forwardView;
		}
		
		resultMap.put("resultList", resultList);

		modelandView.setViewName(viewName);
		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		
		return modelandView;
	}
}
