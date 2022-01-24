package org.conan.mapper;

import org.conan.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userId);
}
