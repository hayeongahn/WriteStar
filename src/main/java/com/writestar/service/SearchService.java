package com.writestar.service;

import java.util.List;

import com.writestar.domain.BoardVO;
import com.writestar.domain.Criteria;

public interface SearchService {
	//검색 목록
	public List<BoardVO> searchList(String keyword);
}
