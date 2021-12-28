package org.conan.service;

import java.util.List;

import org.conan.domain.BoardVO;
import org.conan.persistence.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service // 스프링에 빈으로 등록되는 서비스 객체의 어노테이션
@AllArgsConstructor // 모든 필드 값을 파라미터로 받는 생성자 생성
public class BoardServiceImpl implements BoardService {
//	@Setter(onMethod_=@Autowired) // 빈 객체 생성, 모든 필드에 접근자와 설정자가 자동으로 생성
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
//		log.info("register........." + board.getBno());
		mapper.insert(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get..." + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify..." + board);
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove..." + bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList.............");
		return mapper.getList();
	}
}
