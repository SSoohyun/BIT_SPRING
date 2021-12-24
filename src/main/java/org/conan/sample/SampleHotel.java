package org.conan.sample;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NonNull;
import lombok.ToString;

@Component
@ToString
@Getter
@AllArgsConstructor // argument가 다 있는 생성자 만들어줌
public class SampleHotel {
	@NonNull
	private Chef chef;
	// public SampleHotel(Chef chef) {
	//	this.chef = chef;
	// }
}
