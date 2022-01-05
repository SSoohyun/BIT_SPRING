package org.conan.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	// 이 경로의 모든 파일을 실행하기 전 로그를 출력하라는 뜻
	@Before("execution(* org.conan.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("==============================================");
	}
}
