package com.writestar.service;

import java.util.List;

import com.writestar.domain.Criteria;
import com.writestar.domain.ReplyPageDTO;
import com.writestar.domain.ReplyVO;

public interface ReplyService {
	
	public int registerReply(ReplyVO reply);
	
	public ReplyVO getReply(Long rno);
	
	public int modifyReply(ReplyVO reply);
	
	public int removeReply(Long rno);
	
	public List<ReplyVO> getReplyList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
	public int replyAllRemove(Long bno);
}
