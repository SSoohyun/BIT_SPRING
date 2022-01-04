package org.conan.service;

import java.util.List;

import org.conan.domain.Criteria;
import org.conan.domain.ReplyPageDTO;
import org.conan.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo); // 댓글 등록
	public ReplyVO get(Long rno); // 특정 댓글 조회
	public int modify(ReplyVO vo); // 댓글 수정
	public int remove(Long rno); // 댓글 삭제
	public List<ReplyVO> getList(Criteria cri, Long bno); // 페이징 처리된 댓글 목록
	public ReplyPageDTO getListPage(Criteria cri, Long bno); // 댓글 수 카운트
}
