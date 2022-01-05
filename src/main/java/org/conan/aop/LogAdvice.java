package org.conan.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
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
	
	@Before("execution(* org.conan.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) { // args라는 특별한 변수를 이용해서 패러미터를 설정하고 기록 가능
		log.info("str1 : " + str1);
		log.info("str2 : " + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* org.conan.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) { // 예외 발생을 감지해서 AOP로 처리
		log.info("exception!!!!!!!");
		log.info("exception : " + exception);
	}
	
	@Around("execution(* org.conan.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis(); // 시작 시각
		log.info("Target : " + pjp.getTarget());
		log.info("Param : " + Arrays.toString(pjp.getArgs()));
		
		Object result = null;
		try {
			result = pjp.proceed();
		} catch (Throwable e) {}
		
		long end = System.currentTimeMillis(); // 끝난 시각
		log.info("Time : " + (end-start)); // 걸린 시간
		
		return result;
	}
}
