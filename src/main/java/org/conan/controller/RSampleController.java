package org.conan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.conan.domain.SampleVO;
import org.conan.domain.Ticket;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/rsample")
@Log4j
@AllArgsConstructor
public class RSampleController {
	@GetMapping(value="/getText", 
	produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample",
	produces=
	{MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE}) // getSample: XML, getSample.json: json
	public SampleVO getSample() {
		return new SampleVO(112, "스타", "로드");
	}
	
	@GetMapping(value="/getList")
	public List<SampleVO> getList() {
		// 1부터 9까지 SampleVO 생성해서 Collection 타입의 객체 반환 - List
		return IntStream.range(1, 10).mapToObj(i -> new SampleVO(i, i + " First", i + " Last")).collect(Collectors.toList());
	}
	
	@GetMapping(value="/getMap")
	public Map<String, SampleVO> getMap() {
		// Collection 타입의 객체 반환 - Map
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트", "주니어"));
		return map;
	}
	
	// ResponseEntity: 단순히 데이터뿐만 아니라 브라우저에 HTTP 상태 코드 등 추가적인 데이터를 전달할 수 있음
	// 사용방법: check?height=?&weight=?
	@GetMapping(value="/check", params={"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		SampleVO vo = new SampleVO(000, "" + height, "" + weight);
		ResponseEntity<SampleVO> result = null;
		if (height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	
	// PathVariable: URI 경로 중간에 들어간 값을 얻기 위해 사용 -> 기본형은 얻을 수 없음
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(
		@PathVariable("cat") String cat,
		@PathVariable("pid") Integer pid) {
		return new String[] {"category : " + cat, "productid : " + pid};
	}
	
	// RequestBody: 전송된 데이터가 json이고 이를 컨트롤러에서는 사용자 정의 타입의 객체로 변환할 때 사용
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert.....ticket" + ticket);
		return ticket;
	}
}
