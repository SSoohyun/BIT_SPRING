package org.conan.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		String uploadFolder = "c:/upload";

		// 폴더 생성하기
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path : " + uploadPath);
		if (uploadPath.exists() == false) { // 폴더가 존재하지 않으면 새로 생성
			uploadPath.mkdirs(); // yyyy/MM/dd 폴더 생성
		}

		for (MultipartFile multipartFile : uploadFile) {
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			// 중복된 이름의 파일 처리
			UUID uuid = UUID.randomUUID();
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uuid.toString() + "_" + uploadFileName; // 뒤에 원래 파일 이름 붙이기

			// 파일 저장
			// 파일 저장 위치: uploadFolder -> uploadPath
			// 두 번째 인자를 multipartFile.getOriginalFilename() -> UUID를 이용한 고유한 파일명으로 변경
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
				
				// 썸네일 생성 및 저장
				if(checkImageType(saveFile)) {
					// FileOutputStream: 주어진 File 객체가 가리키는 파일을 쓰기 위한 객체를 생성
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName)); // 썸네일은 s 붙여서 저장
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}
}
