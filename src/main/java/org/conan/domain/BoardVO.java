package org.conan.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
	private int replyCnt;
	private List<BoardAttachVO> attachList; // 여러 개의 첨부파일을 가질 수 있음
}
