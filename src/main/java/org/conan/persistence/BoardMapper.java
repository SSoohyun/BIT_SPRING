package org.conan.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.conan.domain.BoardVO;

public interface BoardMapper {
//	@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList(); // select all
	public void insert(BoardVO board); // insert
	public BoardVO read(Long bno); // select one
	public int delete(Long bno); // delete one
	public int update(BoardVO board); // update one
}
