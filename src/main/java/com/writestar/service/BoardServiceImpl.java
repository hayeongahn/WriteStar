package com.writestar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.writestar.domain.BoardAttachVO;
import com.writestar.domain.BoardVO;
import com.writestar.domain.Criteria;
import com.writestar.mapper.BoardAttachMapper;
import com.writestar.mapper.BoardMapper;
import com.writestar.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_= @Autowired)
	private BoardAttachMapper attachMapper;

	@Setter(onMethod_= @Autowired)
	private ReplyMapper replyMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);

		log.info(board);
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		// 첨부 파일 폴더에 추가 정보 입력
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());			// 첨부 파일의 게시글 번호
			attach.setEmail(board.getEmail());		// 첨부 파일의 작성자(email)
			log.info(attach);
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {		
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attach.setEmail(board.getEmail());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		replyMapper.deleteAll(bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}

	@Override
	public int hitsCount(Long bno) {
		return mapper.updateHitsCnt(bno);
	}

	@Override
	public List<BoardVO> selectTop5List() {
		return mapper.selectTop5();
	}

	@Override
	public void removeAttach(Long bno) {
		attachMapper.deleteAll(bno);
	}

	@Override
	public List<BoardVO> getMainList() {
		return mapper.getMainList();
	}
}
