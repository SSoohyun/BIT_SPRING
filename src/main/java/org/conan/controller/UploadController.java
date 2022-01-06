package org.conan.controller;

import java.io.Console;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.conan.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	// 오늘 날짜의 경로를 문자열로 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	// 이미지 파일 여부 판단
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath()); // 마임 타입: 클라이언트에게 전송된 문서의 다양성을 알려주기 위한 메커니즘
			// log.info(contentType);
			return contentType.startsWith("image"); // image면 true 반환
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	// 창 띄우기
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}

	// 업로드되는 파일 데이터 처리
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "c:/upload";
		for (MultipartFile multipartFile : uploadFile) {
			log.info("----------------------------------------");
			log.info("upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			// 파일 저장
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}

	// Ajax를 이용한 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}

	// 업로드되는 파일 데이터 처리
	@PostMapping(value= "/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_VALUE) // json으로 받겠다
	@ResponseBody // 응답
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		String uploadFolder = "c:/upload";
		List<AttachFileDTO> list = new ArrayList<>();

		// 폴더 생성하기
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path : " + uploadPath);
		if (uploadPath.exists() == false) { // 폴더가 존재하지 않으면 새로 생성
			uploadPath.mkdirs(); // yyyy/MM/dd 폴더 생성
		}

		for (MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			// 중복된 이름의 파일 처리
			UUID uuid = UUID.randomUUID();
			String uploadFileName = multipartFile.getOriginalFilename(); 
			attachDTO.setFileName(uploadFileName); // 원래 파일 이름
			uploadFileName = uuid.toString() + "_" + uploadFileName; // 파일 이름 설정: 뒤에 원래 파일 이름 붙이기

			// 파일 저장
			// 파일 저장 위치: uploadFolder -> uploadPath
			// 두 번째 인자를 multipartFile.getOriginalFilename() -> UUID를 이용한 고유한 파일명으로 변경
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
				attachDTO.setUuid(uuid.toString()); // uuid
				attachDTO.setUploadPath(getFolder()); // 파일 경로
				
				// 썸네일 생성 및 저장
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true); // 이미지가 맞음
					
					// FileOutputStream: 주어진 File 객체가 가리키는 파일을 쓰기 위한 객체를 생성
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName)); // 썸네일은 s 붙여서 저장
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
				list.add(attachDTO); // 리스트에 추가
				log.info("attachDTO : " + attachDTO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// 썸네일 이미지 보여주기
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) { // 파일 이름을 전달받아 헤더 이미지 데이터를 전송
		log.info("fileName : " + fileName);
		File file = new File("c:/upload/" + fileName);
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath())); // 적당한 마임 타입을 헤더에 추가
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 첨부파일 다운로드: 일반 파일은 클릭 -> 다운로드, 이미지는 클릭 -> 원본 파일 보여주기
	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName) {
		log.info("download file : " + fileName);
		Resource resource = new FileSystemResource("c:/upload/" + fileName);
		log.info("resource : " + resource);
		
		String resourceName = resource.getFilename();
		
		// uuid 제거
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		log.info("resourceOriginalName: " + resourceOriginalName);
		HttpHeaders headers = new HttpHeaders();
		
		try {
			// 다운로드 시 저장되는 이름 (uuid 제거한 것으로 변경함)
			headers.add("Content-Disposition", "attachment; fileName=" + new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	// 파일 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName);
		File file;
		
		try {
			file = new File("c:/upload/" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			log.info(type);
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName : " + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
