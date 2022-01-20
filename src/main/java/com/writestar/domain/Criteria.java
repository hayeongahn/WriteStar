package com.writestar.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {
	//페이징처리 관련
	private int pageNum; //페이지번호
	private int amount; //한 페이지당 출력되는 데이터수
	private String email;	// top5 글쓴이 email
	
	//검색 관련
	private String keyword; //검색에 사용하는 키워드
	private BoardVO boardVO; 
	
	private String type;
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
	
	public Criteria() {
		this(1,6); // 기본생성자 기본값 지정
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String getListLink() { 
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("") .queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.getAmount()) .queryParam("type", this.getType())
		.queryParam("keyword", this.getKeyword());
			  
		return builder.toUriString();
	}
}