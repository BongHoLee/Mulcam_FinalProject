package com.project.app.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.project.app.crawling.MyBasketCrawlService;
import com.project.app.dao.ShareDao;
import com.project.app.security.MemberInfo;
import com.project.app.util.CommonUtil;
import com.project.app.util.MyBasketUtil;

@Service
public class MyBasketService {

	@Autowired
	private MyBasketCrawlService myBasketCrawlService;
	
	@Autowired
	private MyBasketUtil myBasketUtil;

	@Autowired
	private ShareDao dao;
	
	@Autowired
	private CommonUtil commonUtil;

	public Object getAllList(Object dataMap) {
		String sqlMapId = "myBasket.listRank";
		
		Object resultObject = dao.getList(sqlMapId, dataMap);

		return resultObject;
	}
	
	
	public Object getList(Object dataMap) {
		String sqlMapId = "myBasket.list";
		
		
		/*memberSeq입력 */
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberInfo memberInfo = (MemberInfo) authentication.getPrincipal();
		((Map)dataMap).put("MEMBER_SEQ", memberInfo.getMemberSeq());

		
		Object resultObject = dao.getList(sqlMapId, dataMap);

		return resultObject;
	}

	public Object getObject(Object dataMap) {
		String sqlMapId = "myBasket.read";

		Object resultObject = dao.getObject(sqlMapId, dataMap);

		return resultObject;
	}
	
	public Object getListCount(Object dataMap) {
		String sqlMapId = "myBasket.listCount";
		
		Object resultObject = dao.getObject(sqlMapId, dataMap);
		
		return resultObject;
	}

	public Object saveObject(Map<Object, Object> paramMap) {
		String uniqueSequence = (String) paramMap.get("BOOKMARK_SEQ");

		if ("".equals(uniqueSequence) || null == uniqueSequence ) {
			uniqueSequence = commonUtil.getUniqueSequence();
		}

		paramMap.put("BOOKMARK_SEQ", uniqueSequence);

		String memberSeq = (String) paramMap.get("MEMBER_SEQ");

		//MYBASKET_STATUS 
		//신규추가시 : CONSIDERING
		//삭제 시	 : DELETED
		//구매완료시 : PURCHASED
		
		String myBasketStatus = "CONSIDERING";
		paramMap.put("STATUS", myBasketStatus);
		
		//0. uri를 직접 입력하여 장바구니에 추가하는 경우 (각 파라미터를 받아 옴)
		if(("crawl").equals(paramMap.get("action"))){
			//1. Crawler에 uri를 넘겨줌
			//2. crawler를 통해 파라미터 값을 받아옴
			Map<Object, Object> productInfoMap = (Map<Object, Object>) myBasketCrawlService.getProductInfoMap(paramMap);
			paramMap.putAll(productInfoMap);
		}

		//3. 받아온 parameter 값을 paramMap에 넣어줌
		String sqlMapId = "myBasket.merge";
		Object resultKey = dao.saveObject(sqlMapId, paramMap);

		sqlMapId = "myBasket.list";
		Object resultObject = dao.getList(sqlMapId, paramMap);

		//4. top에 display되는 mybasket 갯수 refresh
		myBasketUtil.refreshMyBasketCounter(paramMap);
		
		return resultObject;
	}
	
	public Object updateObject(Object dataMap) {
		// delete child record authority
		String sqlMapId = "myBasket.update";

		String action = (String) ((Map<Object, Object>) dataMap).get("action");
		String myBasketStatus = "";
		
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
		
		// top에 display되는 mybasket 갯수 refresh
		myBasketUtil.refreshMyBasketCounter(dataMap);

		return resultObject;
	}

	public Object deleteObject(Object dataMap) {
		// delete child record authority
		String sqlMapId = "myBasket.delete";

		String action = (String) ((Map<Object, Object>) dataMap).get("action");
		
		if ( action.equals("delete") ) {
			//구매목록에 저장...
		} else if ( action.equals("delete") ) {}
		
		Integer resultKey = (Integer) dao.deleteObject(sqlMapId, dataMap);

		// get Member List
		sqlMapId = "myBasket.list";

		Object resultObject = dao.getList(sqlMapId, dataMap);
		
		// top에 display되는 mybasket 갯수 refresh
		myBasketUtil.refreshMyBasketCounter(dataMap);

		return resultObject;
	}

}
