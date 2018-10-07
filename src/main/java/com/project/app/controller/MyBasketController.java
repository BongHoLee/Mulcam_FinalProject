package com.project.app.controller;

import java.security.Principal;
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
import com.project.app.service.MyBasketService;

@Controller
public class MyBasketController {
	private final static String MAPPING = "/myBasket/";
	
	@Autowired
	private MyBasketService service;
	
	@RequestMapping(value = MAPPING+"{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap
			, MapParamCollector paramMethodMap
			, @PathVariable String action
			, ModelAndView modelandView, Principal principal) {

		
		Map<Object, Object> paramMap = paramMethodMap.getMap();		

		//paramMap에 ID저장
		//paramMap.put("USER_ID", principal.getName());
		
		String viewName = MAPPING + action ;
		String forwardView = (String) paramMap.get("forwardView") ;
		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		List<Object> resultList = new ArrayList<Object>();
		if(forwardView != null){
			viewName = forwardView;
		}
		// divided depending on action value
		if ("list".equalsIgnoreCase(action)) {
			resultList = (List<Object>) service.getList(paramMap);
		}else if("add".equalsIgnoreCase(action)) {
			resultList = (List<Object>) service.saveObject(paramMap);
			viewName = "redirect:" + MAPPING + "list";
		}else if("update".equalsIgnoreCase(action)) {
			resultList = (List<Object>) service.updateObject(paramMap);
			viewName = "redirect:" + MAPPING + "list";
		}


		
		resultMap.put("resultList", resultList);

		modelandView.setViewName(viewName);
		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		return modelandView;
	}
}
