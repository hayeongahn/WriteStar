package com.writestar.mapper;

import java.util.List;

import com.writestar.domain.BoardVO;
import com.writestar.domain.Criteria;

public interface SearchMapper {
	//검색 목록
	public List<BoardVO> searchList(String keyword);
}