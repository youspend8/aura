package com.bitcamp.aura.manager.controller;

import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bitcamp.aura.category.service.DigitalCategoryService;
import com.bitcamp.aura.review.model.ReviewVO;
import com.bitcamp.aura.review.service.ReviewService;
import com.bitcamp.aura.reviewlist.service.ReviewListService;
import com.google.gson.Gson;

@RestController
@RequestMapping(value="/api/review")
public class ReviewRestApi {
	@Autowired
	private ReviewService service;
	@Autowired
	private ReviewListService reviewListService;
	@Autowired
	private DigitalCategoryService digitalCateService;
	
	@RequestMapping(value="/list")
	public String list() throws ParseException {
		List<ReviewVO> review = service.searchAll();
		
		return new Gson().toJson(review);
	}
	
	@PostMapping(value="/")
	public boolean write(
			@RequestParam HashMap<String, Object> params,
			@RequestParam("file") MultipartFile[] multipartFiles) {
		System.out.println(params);
		service.writeReview(params, multipartFiles);
		return true;
	}
	
	@DeleteMapping(value="/{num}")
	public boolean delete(
			@PathVariable("num") int num) {
		
		return service.deleteReview(num) == 1 ? true : false;
	}
	
	@RequestMapping(value="/{num}/{type}")
	public String getPost(
			@PathVariable("num") int num,
			@PathVariable("type") int type) {
		HashMap<String, Object> params = new HashMap<>();
		System.out.println(1);
		params.put("type", type);
		params.put("num", num);
		
		HashMap<String, Object> review = service.searchByNum(params);
		System.out.println(review);
		StringBuilder sb = new StringBuilder();
		Gson gson = new Gson();
		sb.append(gson.toJson(review));
		System.out.println(sb.toString());
		return sb.toString();
	}
	
	@RequestMapping(value="/write")
	public String writeForm() {
		
		return new Gson().toJson(Arrays.asList(
				digitalCateService.readAllCategory1(),
				digitalCateService.readAllCategory2(),
				digitalCateService.readAllCategory3()));
	}
	
	@GetMapping(value="/todayReview")
	public int todayReview() {
		System.out.println(reviewListService.selectReviewCount());
		return reviewListService.selectReviewCount();
	}
	
	@GetMapping(value="/popReviewStats")
	public String popReview() {
		
		return new Gson().toJson(service.searchPopular());
	}
}
