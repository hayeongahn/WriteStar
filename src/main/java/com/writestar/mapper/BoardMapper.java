package com.writestar.mapper;

import java.util.List;

import com.writestar.domain.BoardVO;
import com.writestar.domain.Criteria;

public interface BoardMapper {
	// 글목록
	public List<BoardVO> getList();
	// 글목록- 페이징처리
	public List<BoardVO> getListWithPaging(Criteria cri);
	// 글등록
	public void insertSelectKey(BoardVO board);
	// 글상세보기
	public BoardVO read(Long bno);
	// 글 삭제
	public int delete(Long bno);
	// 글 수정
	public int update(BoardVO board);
	// 전체 데이터 수
	public int getTotalCount(Criteria cri);
	// 조회수
	public int updateHitsCnt(long bno);
	// 인기글 상위 5개
	public List<BoardVO> selectTop5();
	// 메인화면 글목록
	public List<BoardVO> getMainList();
}
