package org.conan.mapper;

import java.util.List;

import org.conan.domain.BoardAttachVO;

public interface BoardAttachMapper {
	public void insert(BoardAttachVO vo);
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(Long bno);
	public void deleteAll(Long bno); // 게시글 삭제 시 파일 정보도 삭제
	
	public List<BoardAttachVO> getOldFiles();
}
