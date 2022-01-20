package org.conan.controller;

import java.util.ArrayList;
import java.util.Arrays;

import org.conan.domain.SampleDTO;
import org.conan.domain.SampleDTOList;
import org.conan.domain.TodoDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j // 로그 출력을 위해
@RequestMapping("/sample/*") // GET, POST 관계 X (default: sample 폴더 안)
public class SampleController {
	@GetMapping("/ex01") // /sample/ex01을 처리
	public String ex01(SampleDTO dto) { // 파라미터가 있으면 그대로 매핑
		log.info("" + dto);
		return "ex01";
	}
	
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {
		log.info("name : " + name);
		log.info("age : " + age);
		return "ex02";
	}
	
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids") ArrayList<String> ids) {
		log.info("ids : " + ids); // 리스트 출력
		return "ex02List";
	}
	
	@GetMapping("/ex02Array")
	public String ex02Array(@RequestParam("ids") String[] ids) {
		log.info("array ids : " + Arrays.toString(ids)); // 배열 출력
		return "ex02Array";
	}
	
	// [ -> %5B, ] -> %5D
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) { // name, age를 여러개 보낼 수 있음
		log.info("list dtos : " + list);
		return "ex02Bean";
	}

	// 패러미터를 변환해서 처리해야하는 경우
//	@InitBinder
//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd");
//		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dataFormat, false));
//	}
	
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		log.info("todo : " + todo);
		return "ex03";
	}
	
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page) { // 기본형은 출력이 안되기 때문에, 강제로 전달받은 파라미터를 모델에 담아서 타입에 관계없이 전달
		log.info("dto : " + dto);
		log.info("page : " + page);
		return "/sample/ex04"; // 화면의 이름: sample/ex04를 찾아감
	}
	
	@GetMapping("/ex05")
	public void ex05() {
		log.info("ex05");
	}
	
	// 객체 타입: VO나 DTO 등 복합적인 데이터가 들어간 객체 타입으로 지정 가능, JSON 데이터를 만들어내는 용도 (화면 X)
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("ex06");
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("conan");
		return dto;
	}
	
	// ResponseEntity 타입: Http 프로토콜의 헤더를 다루는 경우
	@GetMapping("/ex07")
	public ResponseEntity <String> ex07() {
		log.info("ex07");
		String msg = String.format("{\"name\":\"conan\"}"); // json 형태로 formatting
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		return new ResponseEntity<>(msg, header, HttpStatus.OK); // 내가 만든 msg, 헤더, 상태정보(OK: 200)
	}
	
	// 파일 업로드 처리 (form)
	@GetMapping("/exUpload") // GET 방식
	public void exUpload() {
		log.info("exUpload");
	}
	
	// 파일 업로드 처리 (submit 후)
	@PostMapping("/exUploadPost") // POST 방식
	public void exUploadPost(ArrayList<MultipartFile> files) {
		for (MultipartFile file : files) {
			log.info("name : " + file.getOriginalFilename());
			log.info("size : " + file.getSize());
		}
	}
	
	// security
	
	// 로그인을 하지 않은 사용자도 접근 가능한 URI
	@GetMapping("/all")
	public void doAll() {
		log.info("누구나 접근 가능");
	}

	// 로그인한 사용자들만 접근할 수 있는 URI
	@GetMapping("/member")
	public void doMember() {
		log.info("로그인한 회원들만 접근 가능");
	}

	// 로그인한 사용자들 중 관리자 권한을 가진 사용자만 접근할 수 있는 URI
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("관리자들만 접근 가능");
	}
}
