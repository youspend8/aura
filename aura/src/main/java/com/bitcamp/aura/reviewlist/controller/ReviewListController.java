package com.bitcamp.aura.reviewlist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.aura.review.dao.ReviewFileMapper;
import com.bitcamp.aura.review.model.ReviewVO;
import com.bitcamp.aura.review.service.ReviewService;
import com.bitcamp.aura.reviewlist.dao.ReviewListMapper;
import com.bitcamp.aura.reviewlist.model.ReviewListVO;
import com.bitcamp.aura.reviewlist.service.ReviewListService;

@Controller
@RequestMapping(value="/reviewList")
public class ReviewListController {
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private ReviewListService listService;
	@Autowired
	private ReviewFileMapper reviewFileMapper;
	@Autowired
	private ReviewListMapper reviewListMapper;
	
	@RequestMapping("/reviewPost")
	@ResponseBody
	public int reviewPost(
			@ModelAttribute ReviewListVO params,
			HttpSession session) {
		if(session.getAttribute("nickname")!=null) {
			params.setNickname((String)session.getAttribute("nickname")); 
			listService.doReview(params);
			return 1;
		}
		return 0;
	}
	
	@RequestMapping("/favostar")
	@ResponseBody
	public boolean favostar(
			@ModelAttribute ReviewListVO params, 
			HttpSession session){
		System.out.println("여기까지는 들어옵니다.");
		System.out.println("params(파람 찍히는 것 확인)1:"+ params);
		
		if(session.getAttribute("nickname")!=null ) {
			listService.doReview(params);
			return true;
		}
		return false;
	}
		

	@RequestMapping("/modal_review")
	@ResponseBody
	public List<ReviewListVO> modal_review(HttpSession session) {
//		ModelAndView mv = new ModelAndView();
		String nickname = (String) session.getAttribute("nickname");
		List<ReviewListVO> reviewListVo = reviewListMapper.selectByNickname(nickname);
//		int postNum = reviewListVo.get(0).getPostNum();
//		System.out.println("postNum" + postNum);
//		List<ReviewFileVO> reviewFileVo = reviewFileMapper.selectByPostNum(postNum);
//		System.out.println("type:" + type);
		
		List<ReviewVO> reviewList = reviewService.searchAll();
		
		reviewListVo.forEach(item -> {
			item.setTitle(reviewService.searchOne(item.getPostNum()).getTitle());
			item.setPostType(StreamSupport.stream(reviewList.spliterator(), true)  
					.filter(r -> r.getNum() == item.getPostNum())
					.mapToInt(ReviewVO::getType).toArray()[0]);
		});
		
		System.out.println("reviewListVo" + reviewListVo); //리뷰리스트의  List의 내용은 넘어옴
		
		return StreamSupport.stream(reviewListVo.spliterator(), true)
				.sorted((r1, r2) -> r1.getNum() < r2.getNum() ? 1 : -1)
				.collect(Collectors.toList());
	}
	
	
	
	
	
	
	
	
	
	
	
}
