package com.writestar.service;

import java.util.List;

import com.writestar.domain.BoardAttachVO;
import com.writestar.domain.BoardVO;
import com.writestar.domain.Criteria;

public interface BoardService {
	// 글 등록
	public void register(BoardVO board);
	// 글 조회 
	public BoardVO get(Long bno);
	// 글 수정
	public boolean modify(BoardVO board);
	// 글 삭제
	public boolean remove(Long bno);
	// 글 목록
	public List<BoardVO> getList(Criteria cri);
	// 전체 데이터 개수
	public int getTotal(Criteria cri);
	// 첨부파일목록 호출
	public List<BoardAttachVO> getAttachList(Long bno);
	// 첨부파일 삭제
	public void removeAttach(Long bno);
	// 조회수
	public int hitsCount(Long bno);
	// 인기글 상위 5개
	public List<BoardVO> selectTop5List();
	// 메인화면 글목록
	public List<BoardVO> getMainList();
}