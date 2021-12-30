package org.conan.domain;

import lombok.ToString;

@ToString
public class Criteria {
	private int pageNum; // 페이지 번호
	private int amount; // 한 페이지에 출력되는 데이터 수
	
	// for search
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 10);
	}
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum; // MySQL에서 limit을 고려
		this.amount = amount;
	}
	
	public void setPageNum(int pageNum) {
		if (pageNum <= 0) {
			this.pageNum = 1;
			return;
		}
		this.pageNum = pageNum;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public int getPageNum() {
		return this.pageNum;
	}
	public int getAmount() {
		return this.amount;
	}
	public int getPageStart() { // limit 구문에서 시작 위치 지정 (#{}에 값을 넣어주기 위해 getter 생성)
		return (this.pageNum - 1) * this.amount;
	}
	
	// for search
	public void setType(String type) {
		this.type = type;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getType() {
		return this.type;
	}
	public String getKeyword() {
		return this.keyword;
	}
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split(""); // 검색 조건을 배열로 처리
	}
}
