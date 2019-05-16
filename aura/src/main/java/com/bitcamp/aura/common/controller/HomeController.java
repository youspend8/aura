package com.bitcamp.aura.common.controller;

import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitcamp.aura.notice.model.NoticeVO;
import com.bitcamp.aura.notice.service.NoticeService;
import com.bitcamp.aura.review.service.ReviewService;
import com.bitcamp.aura.user.service.UserService;

@Controller
public class HomeController {
	@Autowired
	private UserService userService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping(value="/")
	public String index() {
		return "index";
	}
	
	@RequestMapping(value="/main")
	public String main(Model model) {
		model.addAttribute("noticeList", StreamSupport.stream(noticeService.searchAll().spliterator(), false)
											.filter(e -> e.getIsNotice() == 1)
											.sorted((e1, e2) -> e1.getNum() > e2.getNum() ? -1 : 1)
											.collect(Collectors.toList()));
		model.addAttribute("eventList", StreamSupport.stream(noticeService.searchAll().spliterator(), false)
											.filter(e -> e.getIsNotice() == 0)
											.sorted((e1, e2) -> e1.getNum() > e2.getNum() ? -1 : 1)
											.collect(Collectors.toList()));
		model.addAttribute("popReview", reviewService.searchPopular());
		model.addAttribute("newReview", reviewService.searchNew());
		return "main";
	}
	
	@RequestMapping(value="/manager")
	public String manager(HttpSession session) {
		if (userService.getUser((String)session.getAttribute("nickname")).getIsAdmin() == 1) {
			return "redirect:http://localhost:3000/";
		}
		return "redirect:http://localhost:3000/";
	}
	
}


