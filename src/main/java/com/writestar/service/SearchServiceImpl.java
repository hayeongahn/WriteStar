package com.writestar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.writestar.domain.BoardVO;
import com.writestar.domain.Criteria;
import com.writestar.mapper.SearchMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class SearchServiceImpl implements SearchService {
	private SearchMapper mapper;

	@Override
	public List<BoardVO> searchList(String keyword) {
		return mapper.searchList(keyword);
	}
}
