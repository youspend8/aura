package com.bitcamp.aura.user.social;

import com.bitcamp.aura.user.model.UserVO;

public interface KakaoLogin {
	
	public String getAccessToken(String code);
	public UserVO getUserInfo(String accessToken);


}
