package org.conan.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType; // 이미지 파일 여부
	private Long bno;
}
