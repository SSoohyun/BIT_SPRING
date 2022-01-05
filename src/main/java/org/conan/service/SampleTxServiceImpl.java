package org.conan.service;

import org.conan.mapper.Sample1Mapper;
import org.conan.mapper.Sample2Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleTxServiceImpl implements SampleTxService {
	@Setter(onMethod_ = @Autowired)
	private Sample1Mapper mapper1;
	@Setter(onMethod_ = @Autowired)
	private Sample2Mapper mapper2;
	
	// 어노테이션 없을 때: col1만 insert 됨
	// 어노테이션 있을 때: 두 개를 하나의 tx로 만듦 -> 하나가 안되면 둘 다 안됨
	// 메소드에 어노테이션 붙이는 것이 우선순위가 제일 높음
	@Transactional 
	@Override
	public void addData(String value) {
		log.info("mapper1.......");
		mapper1.insertCol1(value);
		log.info("mapper2.......");
		mapper2.insertCol2(value);
		
		log.info("end.....");
	}

}
