package com.writestar.mapper;

import java.util.List;

import com.writestar.domain.BoardAttachVO;

public interface BoardAttachMapper {
	//첨부파일 등록
	public void insert(BoardAttachVO vo);
	//첨부파일 삭제
	public void delete(String uuid);
	//첨부파일 목록(게시글)
	public List<BoardAttachVO> findByBno(Long bno);
	//현재(동기화 전)까지 등록된 첨부파일 목록
	public List<BoardAttachVO> getOldFiles();
	//게시물 삭제 시 첨부파일 삭제
	public void deleteAll(Long bno);
	//첨부파일 목록(이메일)
	public List<BoardAttachVO> findByEmail(String email);
	//첨부파일 삭제(프로필)
	public void deleteProfile(String email);
}
