package com.project.app.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.project.app.security.MemberInfo;
import com.project.app.service.MyBasketService;

@Component
public class MyBasketUtil {

	@Autowired MyBasketService service;

	public String refreshMyBasketCounter(Object dataMap) {
		// 1. MyBaksetService를 이용하여 listCount를 받아옴
		String newMyBasketCount = service.getListCount(dataMap).toString();
		
		// 2. login Session에 myBasketCount 값 수
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); 
		MemberInfo user = (MemberInfo) authentication.getPrincipal();
		
		user.setMyBasketCount(newMyBasketCount);
		
		return newMyBasketCount;
	}
}
