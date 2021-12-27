package org.conan.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class SampleDTOList { // 객체 리스트
	private List<SampleDTO> list;
	
	public SampleDTOList() {
		list = new ArrayList<>();
	}
}
