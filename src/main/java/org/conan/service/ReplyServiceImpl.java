package org.conan.service;

import java.util.List;

import org.conan.domain.Criteria;
import org.conan.domain.ReplyPageDTO;
import org.conan.domain.ReplyVO;
import org.conan.mapper.ReplyMapper;
import org.conan.persistence.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) { // 댓글 등록
		log.info("register..." + vo);
		boardMapper.updateReplyCnt(vo.getBno(), 1); // 댓글 수 업데이트
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) { // 특정 댓글 조회
		log.info("get..." + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) { // 댓글 수정
		log.info("modify..." + vo);
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) { // 댓글 삭제
		log.info("remove..." + rno);
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1); // 댓글 수 업데이트
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) { // 페이징 처리된 댓글 목록
		log.info("get Reply List of a Board..." + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		log.info(bno + "의 댓글 count 개수: " + mapper.getCountByBno(bno));
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
}
