package com.project.app.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.crawling.MyBasketCrawlService;
import com.project.app.dao.ShareDao;
import com.project.app.util.CommonUtil;

@Service
public class NoticeService {

	@Autowired
	private ShareDao dao;
	
	@Autowired
	private CommonUtil commonUtil;


	public Object getList(Object dataMap) {
		String sqlMapId = "notice.list";
		
		Object resultObject = dao.getList(sqlMapId, dataMap);

		return resultObject;
	}

	public Object getObject(Object dataMap) {
		String sqlMapId = "notice.read";

		Object resultObject = dao.getObject(sqlMapId, dataMap);

		return resultObject;
	}
	
	public Object saveObject(Map<Object, Object> paramMap) {
		String uniqueSequence = (String) paramMap.get("NOTICE_SEQ");
		
		if ("".equals(uniqueSequence) || null == uniqueSequence ) {
			uniqueSequence = commonUtil.getUniqueSequence();
		}
		
		paramMap.put("NOTICE_SEQ", uniqueSequence);
		
		//3. 받아온 parameter 값을 paramMap에 넣어줌
		String sqlMapId = "notice.merge";
		Object resultKey = dao.saveObject(sqlMapId, paramMap);
		
		sqlMapId = "notice.read";
		Object resultObject = dao.getObject(sqlMapId, paramMap);
		
		return resultObject;
	}
	
	/*public Object getListCount(Object dataMap) {
		String sqlMapId = "notice.listCount";
		
		//추후 SPRING SECURITY 적용 완료 시 변경 필요
		//((Map<Object, Object>)(dataMap)).put("MEMBER_SEQ", paramMap.get("MEMBER_SEQ"));
		((Map<Object, Object>)(dataMap)).put("MEMBER_SEQ", "UUID-M002");
		
		Object resultObject = dao.getObject(sqlMapId, dataMap);
		
		return resultObject;
	}*/
	
/*	public Object updateObject(Object dataMap) {
		// delete child record authority
		String sqlMapId = "myBasket.update";

		String action = (String) ((Map<Object, Object>) dataMap).get("action");
		String myBasketStatus = "";
		
		//추후 SPRING SECURITY 적용 완료 시 변경 필요
		//((Map<Object, Object>)(dataMap)).put("MEMBER_SEQ", paramMap.get("MEMBER_SEQ"));
		((Map<Object, Object>)(dataMap)).put("MEMBER_SEQ", "UUID-M002");
		
		//MYBASKET_STATUS 
		//신규추가시 : CONSIDERING
		//삭제 시 : DELETED
		//구매완료시 : PURCHASED
		if ( action.equals("purchased") ) //구매완료 버튼 클릭 시
			myBasketStatus = "PURCHASED";
		else if ( action.equals("delete") ) //삭제 버튼 클릭 시
			myBasketStatus = "DELETED";
		
		((Map<Object, Object>) (dataMap)).put("STATUS", myBasketStatus);
		
		Integer resultKey = (Integer) dao.saveObject(sqlMapId, dataMap);

		// get Member List
		sqlMapId = "myBasket.list";

		Object resultObject = dao.getList(sqlMapId, dataMap);

		return resultObject;
	}
*/

	public Object deleteObject(Object dataMap) {
		String sqlMapId = "notice.delete";
		
		Integer resultKey = (Integer) dao.deleteObject(sqlMapId, dataMap);

		// get Member List
		sqlMapId = "notice.list";

		Object resultObject = dao.getList(sqlMapId, dataMap);

		return resultObject;
	}

}
