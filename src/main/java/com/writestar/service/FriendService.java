package com.writestar.service;

import java.util.List;
import java.util.Map;

import com.writestar.domain.Criteria;
import com.writestar.domain.FriendRequestVO;
import com.writestar.domain.FriendVO;

public interface FriendService {
	// 친구 목록 조회
	public List<FriendVO> selectFriendList(String to_user);
	
	// 친구요청 목록 조회
	public List<FriendRequestVO> selectRequestList(String to_user);
	
	// 친구요청 응답
	public boolean response(Map<String, Object> map);
	
	// 친구신청
	public void addFriend(Map<String, Object> map);
	
	// 친구 삭제
	public void removeFriend(FriendVO friend);
	
	// 친구요청 목록 조회
	public List<FriendRequestVO> checkRequest(String to_user);
}
