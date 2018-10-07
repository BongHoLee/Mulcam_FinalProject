package com.project.app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.project.app.component.MapParamCollector;
import com.project.app.service.ApiService;
import com.project.app.service.CompareCrawlService;
import com.project.app.service.StatisticsService;

@Controller
public class ProductController {

	@Autowired
	private ApiService api;

	@Autowired
	private CompareCrawlService crawl;
	
	@Autowired
	private StatisticsService statistics;

	private final static String MAPPING = "/productView";

	@RequestMapping(value = MAPPING + "/{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap,
			MapParamCollector paramMethodMap, @PathVariable String action, ModelAndView modelandView) {

		Map<Object, Object> paramMap = paramMethodMap.getMap();

		String viewName = MAPPING + "/";
		String forwardView = (String) paramMap.get("forwardView");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> resultList = new ArrayList<Object>();

		// divided depending on action value
		if ("productlist".equalsIgnoreCase(action)) {

			// 카테고리에서 검색되었다면 statistics table에 쌓임 
			if ("category".equals(paramMap.get("flag"))) {
				resultList = (List<Object>) statistics.saveObject(paramMap);
			}

			// 검색되어서 반환된 상품들의 목록과 정보들을 List에 담는다.
			resultList = (List) api.searchApi((String) (paramMap.get("search")));
			
			viewName = viewName + action;
		} else if ("productcompare".equalsIgnoreCase(action)) {
			// 크롤링 서비스 사용

			// API가 제공해준 URI(제품 상세)를 crawling service에 전달
			String uri = (String) paramMap.get("link");

			// 전달한 URI를 이용해 크롤링 작업을 Service에서 수행 후 Map형태로 반환( '맵{ 리스트[ 맵{} ] }' 형태)
			resultMap = (Map) (crawl.getProductInfo(uri));
			viewName = viewName + action;
		}

		if (forwardView != null) {
			viewName = forwardView;
		}

		resultMap.put("resultList", resultList);

		modelandView.setViewName(viewName);
		modelandView.addObject("resultList", resultList);
		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		return modelandView;
	}

}
