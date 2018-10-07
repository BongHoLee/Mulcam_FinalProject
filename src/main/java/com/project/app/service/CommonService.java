package com.project.app.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.dao.ShareDao;
import com.project.app.util.CommonUtil;
import com.project.app.util.Pagination;

@Service
public class CommonService {

	@Autowired
	private ShareDao dao;

	@Autowired
	private CommonUtil commonUtil;

	public Object getList(Object dataMap) {
		
		String sqlMapId = "common.list";
		Object resultObject = dao.getList(sqlMapId, dataMap);

		return resultObject;
	}

	public Object getObject(Object dataMap) {

		String sqlMapId = "common.read";
		Object resultObject = dao.getObject(sqlMapId, dataMap);

		return resultObject;
	}

	public Object saveObject(Map<Object, Object> paramMap) {

		String sqlMapId = "common.merge";
		Object resultObject = dao.getObject(sqlMapId, paramMap);

		return resultObject;
	}

	public Object deleteObject(Object dataMap) {
		// delete child record authority
		String sqlMapId = "common.delete";
		Object resultObject = dao.getList(sqlMapId, dataMap);

		return resultObject;
	}


	// pagenation
//	public Object getListPagination(Object dataMap) {
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		String sqlMapId = "member.totalcount";
//		int totalCount = (int) dao.getObject(sqlMapId, dataMap);
//		int currentPage = 1;
//		if (((Map<String, Object>) dataMap).get("curPage") != null) {
//			currentPage = Integer.valueOf(((Map<String, String>) dataMap).get("curPage"));
//		}
//		Pagination pagination = new Pagination(totalCount, currentPage);
//		resultMap.put("pagination", pagination);
//		sqlMapId = "member.listpagination";
//		((Map<String, Object>) dataMap).put("pagination", pagination);
//		Object resultList = dao.getList(sqlMapId, dataMap);
//		resultMap.put("resultList", resultList);
//		return resultMap;
//	}
}
