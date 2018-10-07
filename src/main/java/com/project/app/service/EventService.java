package com.project.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.plaf.synth.SynthSeparatorUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.dao.ShareDao;
import com.project.app.util.CommonUtil;

/**
 * Handles requests for the application home page.
 */
@Service
public class EventService {

	@Autowired
	private ShareDao dao;

	@Autowired
	private CommonUtil commonUtil;

	// read, list
	public Object getObject(Object dataMap) {
		String sqlMapId = "event.read";
		Map resultObject = (Map) dao.getObject(sqlMapId, dataMap);

		return resultObject;
	}

	public Object getList(Object dataMap) {
		String sqlMapId = "event.list";
		Object resultList = dao.getList(sqlMapId, dataMap);

		return resultList;
	}

	public Object saveObject(Map<Object, Object> paramMap) {
		String uniqueSequence = (String) paramMap.get("EVENT_SEQ");
		String imageName = (String) paramMap.get("IMG");
		String changeName = "";

		// 파일 수정을 하는지에 대한 플래그값을 받아 오기 위한 변수
		List<Object> changeList = new ArrayList<Object>();
		Map<String, Object> changeMap = new HashMap<String, Object>();

		// file을 선택 했을때 (new event or event update)
		if (!((List<Object>) paramMap.get("attachFileList")).isEmpty()) {
			changeList = (List<Object>) paramMap.get("attachFileList");
			changeMap = (Map<String, Object>) changeList.get(0);
			changeName = (String) changeMap.get("IMG");
		}
		// 파일 업로드 시 리스트 형식의 값을 List -> Map -> String 으로 변환 해주기 위한 변수
		List<Object> tempList = new ArrayList<Object>();
		Map<String, Object> tempMap = new HashMap<String, Object>();

		// case : new event
		if (imageName == null || (imageName).equals("")) {
			tempList = (List<Object>) paramMap.get("attachFileList");
			tempMap = (Map<String, Object>) tempList.get(0);
			imageName = (String) tempMap.get("IMG");
			paramMap.put("IMG", imageName);
		}

		// case : update event && file change
		else if (!(imageName == null || (imageName).equals("")) && !((changeName).equals(""))) {
			tempList = (List<Object>) paramMap.get("attachFileList");
			tempMap = (Map<String, Object>) tempList.get(0);
			imageName = (String) tempMap.get("IMG");
			paramMap.put("IMG", imageName);
		}

		// case : update event && do not file change
		// else if (!(imageName == null || (imageName).equals("")) && (changeName).equals("")) {
		else {
			System.out.println("@@@@@@@@@@" + imageName);
			paramMap.put("IMG", imageName);
		}

		if (uniqueSequence == null || (uniqueSequence).equals("")) {
			uniqueSequence = commonUtil.getUniqueSequence();
		}

		paramMap.put("EVENT_SEQ", uniqueSequence);

		String sqlMapId = "event.merge";
		Object resultKey = dao.saveObject(sqlMapId, paramMap);

		return getList(paramMap);
	}

	public Object deleteObject(Object dataMap) {

		String sqlMapId = "event.delete";
		dao.saveObject(sqlMapId, dataMap);

		return getList(dataMap);
	}

}