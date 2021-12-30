package org.conan.test;

import static org.junit.Assert.assertNotNull;

import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.service.BoardService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
	@Setter(onMethod_= {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		// service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(2, 5)).forEach(board -> log.info(board)); // 2번째 페이지 5개
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("새글 from Service");
		board.setContent("새 내용 새 내용 from Service");
		board.setWriter("newbie");
		service.register(board);
		log.info("생성된 게시물의 번호 : " + board.getBno());
	}
	
	@Test
	public void testGet() {
		log.info(service.get(6L).getTitle());
	}
	
	@Test
	public void testDelete() {
		log.info("REMOVE RESULT : " + service.remove(6L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(1L);
		if (board == null) {
			return;
		}
		board.setTitle("제목 수정 from Service");
		log.info("MODIFY RESULT : " + service.modify(board));
	}
	
	@Test
	public void testGetTotal() {
		Criteria cri = new Criteria();
		log.info("total : " + service.getTotal(cri));
	}
}
