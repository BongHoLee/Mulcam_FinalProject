package com.project.app.security;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.project.app.dao.ShareDao;

//로그인시 스프링 시큐리티 커스터마이징(인증, 권한)
public class CustomizeUserDetailsService implements UserDetailsService{

	@Autowired
	private ShareDao dao;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		Map<String, Object> dataMap = new HashMap<String, Object>();
		String sqlMapId = "member.read";
		dataMap.put("EMAIL", username);
		
		//로그인회원의 정보를 담는 resultMember
		Map<String, Object> resultMember = (Map<String, Object>)dao.getObject(sqlMapId, dataMap);
		if(resultMember == null) {
			//로그인 회원의 email이 유효하지 않을시 예외발생(login?fail)
			throw new UsernameNotFoundException("NOT FOUND username : " + username);
		}
		
		//권한 확인
		//회원의 권한을 가져온다.(권한리스트에 저장)
		sqlMapId = "authority.list";
		dataMap.put("AUTHORITY_ID", resultMember.get("AUTHORITY_ID"));
		
		
		List<Object> resultAuthorities = (List<Object>)dao.getList(sqlMapId, resultMember);
		
		//유저네임, 비밀번호, 권한목록을 담은 User객체를 생성해서 반환해준다.
		//즉 스프링 시큐리티에서 제공하는 User객체를 통해서 인증
		
		sqlMapId = "myBasket.listCount";
		Object myBasketCount = dao.getObject(sqlMapId, resultMember);
		
		resultMember.put("MY_BASKET_COUNT", myBasketCount);
		
		//UserDatails를 구현한 MemberInfo를 이용한 인증 및 세션에 담기
		return new MemberInfo(resultMember,  buildUserAuthority(resultAuthorities));
	}
	
	//로그인 회원의 권한을 set 형태로 반환해주는 메소드
	private Set<GrantedAuthority> buildUserAuthority(List<Object> resultAuthorities){
		
		//회원의 권한목록을 담아줄 set
		Set<GrantedAuthority> resultObject = new HashSet<GrantedAuthority>();
		Iterator iterator = resultAuthorities.iterator();
		while(iterator.hasNext()) {
			Map<String, String> element = (Map<String, String>) iterator.next();
			
			//권한을 삽입해줌
			 resultObject.add(new SimpleGrantedAuthority(element.get("AUTHORITY")));
			 
		}
		return resultObject;
		
	}
	

	
	
}
