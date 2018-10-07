package com.project.app.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.dao.ShareDao;
import com.project.app.util.CommonUtil;

@Service
public class SignupService {
	
	@Autowired
	private ShareDao dao;
	
	@Autowired
	private CommonUtil util;
	
	public Object saveObject(String sqlMapId, Object dataMap) {
		
		//UUID를 생성
		((Map)dataMap).put("MEMBER_SEQ", util.getUniqueSequence());
		
		//암호화 비밀번호 생성 및 삽입
		String hashedPassword = util.PasswordEncoderGenerator((String)((Map)dataMap).get("PASSWORD"));
		((Map)dataMap).put("PASSWORD", hashedPassword);
		((Map)dataMap).put("AUTHORITY_ID", "UUID-A001");
		
		return dao.saveObject(sqlMapId, dataMap);
	}
	
	public Object getObject(String sqlMapId, Object dataMap) {
		return dao.getObject(sqlMapId, dataMap);
	}


}
