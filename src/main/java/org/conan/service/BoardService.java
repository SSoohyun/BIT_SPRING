package org.conan.service;

import java.util.List;

import org.conan.domain.BoardAttachVO;
import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;

public interface BoardService {
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public List<BoardVO> getList();
	public List<BoardVO> getList(Criteria cri); // 페이지 처리한 리스트
	public int getTotal(Criteria cri);
	public List<BoardAttachVO> getAttachList(Long bno); // 게시물 조회할 때 첨부파일 목록 가져옴
}
