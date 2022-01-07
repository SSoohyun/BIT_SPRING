package org.conan.service;

import java.util.List;

import org.conan.domain.BoardAttachVO;
import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.mapper.BoardAttachMapper;
import org.conan.persistence.BoardMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service // 스프링에 빈으로 등록되는 서비스 객체의 어노테이션
@AllArgsConstructor // 모든 필드 값을 파라미터로 받는 생성자 생성
public class BoardServiceImpl implements BoardService {
//	@Setter(onMethod_=@Autowired) // 빈 객체 생성, 모든 필드에 접근자와 설정자가 자동으로 생성
	private BoardMapper mapper;
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register........." + board.getBno());
		mapper.insertSelectKey(board); // insert 후 게시글 번호 가져오는 메소드로 변경
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) { // 첨부파일 있는지 확인
			return;
		}
		// 첨부파일 있으면 db에 insert
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get..." + bno);
		return mapper.read(bno);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify..." + board);
		
		attachMapper.deleteAll(board.getBno()); // db에서 모든 첨부파일 정보 삭제
		boolean modifyResult = mapper.update(board) == 1; // board 테이블 정보 수정
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach ->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach); // db에 첨부파일 정보 저장
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove..." + bno);
		attachMapper.deleteAll(bno); // 파일 정보 삭제도 함께 이루어져야 함
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList.............");
		return mapper.getList();
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList with criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get Total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno" + bno);
		return attachMapper.findByBno(bno);
	}
}
