package com.bitcamp.aura.category.service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.aura.category.model.DigitalCategory1;
import com.bitcamp.aura.category.model.DigitalCategory2;
import com.bitcamp.aura.category.model.DigitalCategory3;
import com.bitcamp.aura.category.persist.DigitalCategory1Repository;
import com.bitcamp.aura.category.persist.DigitalCategory2Repository;
import com.bitcamp.aura.category.persist.DigitalCategory3Repository;

@Service
public class DigitalCategoryServiceImpl implements DigitalCategoryService {

	@Autowired
	private DigitalCategory1Repository repo1;
	@Autowired
	private DigitalCategory2Repository repo2;
	@Autowired
	private DigitalCategory3Repository repo3;
	
	@Override
	public List<List<? extends Object>> readAll() {
		// TODO Auto-generated method stub
		List<DigitalCategory1> cate1 = StreamSupport.stream(repo1.findAll().spliterator(), true)
											.sorted((c1, c2) -> c1.getNum() > c2.getNum() ? 1 : -1)
											.collect(Collectors.toList());
		List<DigitalCategory2> cate2 = StreamSupport.stream(repo2.findAll().spliterator(), true)
											.sorted((c1, c2) -> c1.getNum() > c2.getNum() ? 1 : -1)
											.collect(Collectors.toList());
		List<DigitalCategory3> cate3 = StreamSupport.stream(repo3.findAll().spliterator(), true)
											.sorted((c1, c2) -> c1.getNum() > c2.getNum() ? 1 : -1)
											.collect(Collectors.toList());
		return Arrays.asList(cate1, cate2, cate3);
	}

}
