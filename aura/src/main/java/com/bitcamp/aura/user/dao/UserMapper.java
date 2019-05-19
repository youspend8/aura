package com.bitcamp.aura.user.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bitcamp.aura.user.model.UserVO;

@Mapper
public interface UserMapper {
	public int insert (UserVO userVo);
	public int update (UserVO userVo);
	public int delete (String nickname);
	public UserVO selectOne(String nickname);
	public UserVO selectOneUserid(String userid);
	public UserVO selectOneEmail(String email);
	public List<UserVO> selectByParams(HashMap<String, Object> params);
	public List<UserVO> selectAll();
	
	public HashMap<String, Object> selectGenderCount();
	public HashMap<String, Object> selectUserRegCount(HashMap<String, Object> params);
}
