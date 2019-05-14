package com.bitcamp.aura.category.service;

import java.util.List;

import com.bitcamp.aura.category.model.DigitalCategory1;
import com.bitcamp.aura.category.model.DigitalCategory2;
import com.bitcamp.aura.category.model.DigitalCategory3;

public interface DigitalCategoryService {
	public List<List<? extends Object>> readAll();
	public List<DigitalCategory1> readAllCategory1();
	public List<DigitalCategory2> readAllCategory2();
	public List<DigitalCategory3> readAllCategory3();
}
