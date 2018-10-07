package com.project.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.dao.ShareDao;

@Service
public class CategoryService {
	
	@Autowired
	private ShareDao dao;
	public Object getList(String sqlMapId, Object dataMap) {
		return dao.getList(sqlMapId, dataMap);
		
	}
	
	//대분류 하위의 중, 소분류 카테고리 정보를 가져옴
	public Object getSubCategory(String sqlMapId, Object dataMap) {
		
		
		
		
		List<Map> returnList = (List)dao.getList(sqlMapId, dataMap);	//쿼리 결과를 담을 List
		System.out.println("카테고리 데이터 : " +returnList.toString());
		
		List<Map> resultList = new ArrayList<>();						//최종 결과를 담을 list({b_id, c_info[map{}]})
		Map<String, Object> b_map = new HashMap<>();		//b카테고리의 명과 c카테고리의 정보를 담을 Map
		List<Map> c_infolist = new ArrayList<>();					//c 카테고리의 정보를 맵 형태로 담을 list
		
		List<Map> c_list = new ArrayList<>();		//해당하는 C카테고리의 정보를 담을 리스트
		Map<String, Object> c_map = new HashMap<>();	//개별 C카테고리의 정보를 담을 맵
		
		String tempBid = (String)((returnList.get(0)).get("CATEGORY_B_ID"));
		
		//가장 첫 번째 b카테고리의 명을 넣어준다.
		b_map.put("CATEGORY_B_ID", tempBid);
		b_map.put("CATEGORY_B_NAME",(String)((returnList.get(0)).get("CATEGORY_B_NAME")));
		for(Map<String, Object> temp : returnList) {
			c_map = new HashMap<>();
			
			//returnList의 B_id에 따라 Map생성 및 해당하는 C카테고리의 정보 삽입
			if((tempBid).equals(temp.get("CATEGORY_B_ID"))) {

				
				//B카테고리에 대한 C카테고리 정보를 삽입
				c_map.put("CATEGORY_C_ID", temp.get("CATEGORY_C_ID"));
				c_map.put("CATEGORY_C_NAME", temp.get("CATEGORY_C_NAME"));
				c_list.add(c_map);		//생성된 c_map을 c_list에 삽입
				
			}else {
				tempBid = (String)(temp.get("CATEGORY_B_ID"));
				b_map.put("C_LIST", c_list);
				
				resultList.add(b_map);				//먼저 생성된 B카테고리 정보를 저장
				b_map = new HashMap<>();
				b_map.put("CATEGORY_B_ID", temp.get("CATEGORY_B_ID"));
				b_map.put("CATEGORY_B_NAME", temp.get("CATEGORY_B_NAME"));

				c_map.put("CATEGORY_C_ID", temp.get("CATEGORY_C_ID"));
				c_map.put("CATEGORY_C_NAME", temp.get("CATEGORY_C_NAME"));
				
				c_list = new ArrayList<>();
				c_list.add(c_map);
			}
		}
		b_map.put("C_LIST", c_list);
		resultList.add(b_map);
		
		return resultList;
	}

}
