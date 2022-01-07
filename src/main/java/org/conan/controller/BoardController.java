package org.conan.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.conan.domain.BoardAttachVO;
import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.domain.PageDTO;
import org.conan.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	// 서버에 업로드된 파일들을 삭제하기 위한 메소드
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files....");
		log.info(attachList);
		
		attachList.forEach(attach->{
			try {
				Path file = Paths.get("c:/upload/" + attach.getUploadPath() + "/" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) { // 이미지인 경우 썸네일까지 삭제
					Path thumbNail = Paths.get("c:/upload/" + attach.getUploadPath() + "/s_" + attach.getUuid() + "_" + attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error : " + e.getMessage());
			}
		}); // forEach
	}
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
		
		// getTotalCount
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("total", total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() { // 화면 출력
		
	}
	
	@PostMapping("/register") // 게시글 저장
	public String register(BoardVO board, RedirectAttributes rttr) { // 입력된 항목 DB에 저장 후 list로 이동
		log.info("register : " + board);
		
		// 데이터(첨부파일) 받았는지 확인
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno()); // 새로 삽입된 번호
//		return "/board/list";
		return "redirect:/board/list"; // redirect를 하지 않는 경우, 새로 고침 시 도배
	}
	
	@GetMapping({"/get", "modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) { // parameter로 bno 받음
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno)); // key, value -> view
	}
	
	@PostMapping("/modify")
	public String get(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify : " + board);
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		// 페이지 처리
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		// 검색 조건 및 키워드 처리
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove..." + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno); // 첨부파일 목록 가져옴
		if (service.remove(bno)) {
			// 가져온 파일 목록 삭제
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		// 페이지 처리
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		// 검색 조건 및 키워드 처리
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList" + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
}
