package org.conan.mapper;

import org.conan.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo); // 댓글 작성
	public ReplyVO read(Long rno); // 특정 댓글 조회
	public int delete(Long rno); // 댓글 삭제
	public int update(ReplyVO reply); // 댓글 수정
}
