package org.conan.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String userId;
	private String userPwd;
	private String userName;
	private boolean enabled;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList; // 한 사용자가 여러 권한을 가질 수 있기 때문(아이디 1개, 권한 여러개 -> 1:N)
}