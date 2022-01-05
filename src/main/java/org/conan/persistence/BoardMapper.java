package org.conan.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;

public interface BoardMapper {
//	@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList(); // select all
	public void insert(BoardVO board); // insert
	public BoardVO read(Long bno); // select one
	public int delete(Long bno); // delete one
	public int update(BoardVO board); // update one
	public void insertSelectKey(BoardVO board); // insert 후 get primary key
	public List<BoardVO> getListWithPaging(Criteria cri); // 페이지 처리가 된 리스트
	public int getTotalCount(Criteria cri); // 데이터 개수 반환
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount); // 댓글 수 업데이트
}
