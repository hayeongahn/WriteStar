package com.writestar.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.writestar.domain.FriendVO;

public interface FriendMapper {
	// 친구 목록 조회
	public List<FriendVO> selectFriend(String to_user);
	
	// 친구수락 데이터 입력
	public void insertFriend(Map<String, Object> map);
	
	// 친구수락 데이터 컬럼 반전 입력
	public boolean reverseInsertFriend(Map<String, Object> map);
	
	// 친구삭제
	public void deleteFriend(FriendVO friend);
}
