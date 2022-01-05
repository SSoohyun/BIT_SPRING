package org.conan.test;

import org.conan.service.SampleService;
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
public class SampleServiceTest {
	@Setter(onMethod_ = @Autowired)
	private SampleService service;
	
	@Test
	public void testClass() { // AOP가 적용되면 일반 객체가 아니라 Proxy 처리된 객체가 생성됨
		log.info(service);
		log.info(service.getClass().getName());
	}
	
	@Test
	public void testAdd() throws Exception {
		log.info(service.doAdd("123", "456"));
	}
	
	@Test
	public void testAddError() throws Exception {
		log.info(service.doAdd("123", "ABC"));
	}
}
