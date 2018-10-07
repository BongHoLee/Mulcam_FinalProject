package com.project.app.controller;

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
import com.project.app.service.SettingService;
import com.project.app.service.SignupService;

@Controller
public class SettingController {
private final static String MAPPING = "/setting/";
	
	@Autowired
	private SettingService service;
	
	
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
		
		if("memberMag".equalsIgnoreCase(action)) {
			resultList = (List)service.getList("member.list", paramMap);
		}else if("delete".equalsIgnoreCase(action)) {
			Object delObject = service.deleteObject("member.delete", paramMap);
			resultList = (List)service.getList("member.list", paramMap);
			viewName = "redirect:" + MAPPING + "memberMag";
		}
		
		modelandView.setViewName(viewName);
		modelandView.addObject("resultList", resultList);
		return modelandView;
		
	}
}
