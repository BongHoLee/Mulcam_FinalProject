package com.project.app.security;

import java.util.Collection;
import java.util.Map;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

//유저의 정보를 세션에 담기 위해 스프링 시큐리티에서 제공하는 UserDetails를 구현함
public class MemberInfo implements UserDetails{
	private String EMAIL;
	private String memberName;
	private String password;
	private String memberSeq;
	private String myBasketCount;
	private Set<GrantedAuthority> authorities;
	
	public MemberInfo(Map<String, Object> resultMember, Set<GrantedAuthority>authorities) {
		this.EMAIL = (String) resultMember.get("EMAIL");
		this.memberName = (String) resultMember.get("NAME");
		this.password = (String) resultMember.get("PASSWORD");
		this.memberSeq = (String) resultMember.get("MEMBER_SEQ");
		this.myBasketCount = resultMember.get("MY_BASKET_COUNT").toString();
		this.authorities = authorities;
	}

	public void setMyBasketCount(String myBasketCount) {
		this.myBasketCount = myBasketCount;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}

	public String getPassword() {
		// TODO Auto-generated method stub
		return password;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return EMAIL;
	}

	public String getMemberName() {
		return memberName;
	}

	public String getMemberSeq() {
		return memberSeq;
	}

	public String getMyBasketCount() {
		return myBasketCount;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

}
