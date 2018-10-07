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
import com.project.app.service.EventService;

@Controller
public class EventController {
	private final static String MAPPING = "/event";

	@Autowired
	private EventService service;

	@RequestMapping(value = MAPPING + "/{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
			MapParamCollector paramMethodMap, @PathVariable String action, ModelAndView modelandView) {

		Map<Object, Object> paramMap = paramMethodMap.getMap();

		String viewName = MAPPING + "/";
		String forwardView = (String) paramMap.get("forwardView");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> resultList = new ArrayList<Object>();

		if ("edit".equalsIgnoreCase(action)) {
			viewName = viewName + action;
			if(!("write".equals((String) paramMap.get("action"))))
				resultMap = (Map<String, Object>) service.getObject(paramMap);
		} else if ("read".equalsIgnoreCase(action)) {
			viewName = viewName + action;
			resultMap = (Map<String, Object>) service.getObject(paramMap);
		} else if ("list".equalsIgnoreCase(action)) {
			viewName = viewName + action;
			resultList = (List<Object>) service.getList(paramMap);
		} else if ("merge".equalsIgnoreCase(action)) {
			viewName = viewName + "list";
			resultList = (List<Object>) service.saveObject(paramMap);	
		} else if ("delete".equalsIgnoreCase(action)) {
	    	  viewName = viewName + "list";
	    	  resultList = (List<Object>) service.deleteObject(paramMap);
	      }

		if (forwardView != null) {
			viewName = forwardView;
		}

		resultMap.put("resultList", resultList);

		modelandView.setViewName(viewName);
		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);

		return modelandView;
	}
}
