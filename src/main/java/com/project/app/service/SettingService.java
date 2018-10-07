package com.project.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.dao.ShareDao;

@Service
public class SettingService {
	
	@Autowired
	private ShareDao dao;
	
	public Object getList(String sqlMapId, Object dataMap) {
		return dao.getList(sqlMapId, dataMap);
	}
	
	public Object deleteObject(String sqlMapId, Object dataMap) {
		return dao.deleteObject(sqlMapId, dataMap);
	}
}
