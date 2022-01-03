package org.conan.test;

import java.util.stream.IntStream;

import org.conan.domain.ReplyVO;
import org.conan.mapper.ReplyMapper;
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
public class ReplyMapperTest {
	@Setter(onMethod = @__({@Autowired}))
	private ReplyMapper mapper;
	private Long[] bnoArr = {7L, 8L, 10L, 11L, 12L}; // 현재 존재하는 게시물 번호(bno)
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testCreate() {
		// 1부터 10까지 (Closed는 끝 포함)
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트 " + i);
			vo.setReplyer("replyer" + i);
			mapper.insert(vo);
		});
	}
}
