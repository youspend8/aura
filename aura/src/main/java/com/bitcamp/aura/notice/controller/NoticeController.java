package com.bitcamp.aura.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.aura.notice.service.NoticeService;
import com.google.gson.Gson;

@Controller
@RequestMapping(value="/notice")
public class NoticeController {
	@Autowired
	private NoticeService service;
	
	@RequestMapping(value="/getBoard")
	@ResponseBody
	public String getBoard(@RequestParam("num") int num) {
		
		return new Gson().toJson(service.searchOne(num));
	}
}
