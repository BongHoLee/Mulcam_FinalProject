package com.project.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.dao.ShareDao;
import com.project.app.util.CommonUtil;



/**
* Handles requests for the application home page.
*/
@Service
public class StatisticsService {

    @Autowired
    private ShareDao dao;
	@Autowired
	private CommonUtil commonUtil;
	
	//read, list
    public Object getObject(Object dataMap) {
    	String sqlMapId = "statistics.read";
    	Object resultObject = dao.getObject(sqlMapId, dataMap);
    	    	
    	return resultObject;
    }
    

  //통계값을 가져옴 
	public Object getClickStatistics(Object dataMap) {

		String sqlMapId = "statistics.clicklist";
		Object resultObject = (List) dao.getList(sqlMapId, dataMap); // 쿼리 결과를 담을 List

		return resultObject;
	}
	// ---end of read, list

	public Object getBasketStatistics(Object dataMap) {

		String sqlMapId = "statistics.basketlist";
		Object resultObject = (List) dao.getList(sqlMapId, dataMap); // 쿼리 결과를 담을 List

		return resultObject;
	}
      
    public Object saveObject(Object dataMap) {
    	
    	Map<String, Object> paramMap = (Map<String, Object>) dataMap;
    	
    	String uniqueSequence = (String) paramMap.get("STATISTICS_SEQ");
    	String keyword = (String) paramMap.get("search");
    	
    	if(uniqueSequence == null || uniqueSequence ==""){
			uniqueSequence = commonUtil.getUniqueSequence();
		}
    	
    	paramMap.put("STATISTICS_SEQ", uniqueSequence);
    	paramMap.put("KEYWORD", keyword);
    	
    	
    	String sqlMapId = "statistics.merge";
    	
    	Integer resultKey = (Integer) dao.saveObject(sqlMapId, paramMap);
    	   	
    	return getObject(dataMap);
    }
    
}