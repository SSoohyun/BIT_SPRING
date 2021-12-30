package org.conan.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // 화면에 보여지는 페이지의 시작 번호
	private int endPage; // 화면에 보여지는 페이지의 끝 번호
	private boolean prev, next; // 이전 혹은 다음 페이지 존재 여부
	private int total; // 전체 데이터 수
	private Criteria cri;

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.)) * 10; // 끝 페이지를 올림
		this.startPage = this.endPage - 9; // 시작 페이지를 고정적으로 만들어줌 (1, 11, 21 ...)
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount())); // 진짜 끝 페이지
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}