package org.conan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.conan.domain.Criteria;
import org.conan.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo); // 댓글 작성
	public ReplyVO read(Long rno); // 특정 댓글 조회
	public int delete(Long rno); // 댓글 삭제
	public int update(ReplyVO reply); // 댓글 수정
	
	// 댓글 목록과 페이징 처리: 특정한 게시물의 댓글만을 대상으로 하기 때문에 게시글 번호 필요
	public List<ReplyVO> getListWithPaging( 
			// MyBatis의 패러미터는 1개만 허용 but, @Param 이용 -> #{} 사용 가능
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	
	public int getCountByBno(Long bno); // 댓글 수 카운트
}
