package com.writestar.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.writestar.domain.Criteria;
import com.writestar.domain.FriendRequestVO;

public interface FriendRequestMapper {
	// 친구요청 목록 조회
	public List<FriendRequestVO> selectRequest(String to_user);
	
	// 친구요청 기록 삭제
	public void deleteRequest(Map<String, Object> map);

	// 친구신청
	public void insertRequest(Map<String, Object> map);
	
	// 친구요청 목록 조회
	public List<FriendRequestVO> checkRequest(String to_user);
}
