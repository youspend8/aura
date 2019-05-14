package com.bitcamp.aura.category.service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitcamp.aura.category.model.SignLocationVO;
import com.bitcamp.aura.category.persist.SignLocationRepository;

@Service
@Transactional
public class SignLocationServiceImpl implements SignLocationService {

	@Autowired
	private SignLocationRepository repo;

	@Override
	public SignLocationVO create(SignLocationVO signLocVo) {
		// TODO Auto-generated method stub
		return repo.save(signLocVo);
	}

	@Override
	public Iterable<SignLocationVO> createAll(Iterable<SignLocationVO> iterator) {
		// TODO Auto-generated method stub
		return repo.saveAll(iterator);
	}

	@Override
	public SignLocationVO update(SignLocationVO signLocVo) {
		// TODO Auto-generated method stub
		return repo.save(signLocVo);
	}

	@Override
	public void delete(int num) {
		// TODO Auto-generated method stub
		repo.deleteById(num);
	}

	@Override
	public void deleteAll() {
		// TODO Auto-generated method stub
		repo.deleteAll();
	}

	@Override
	public SignLocationVO read(int num) {
		// TODO Auto-generated method stub
		return repo.findById(num).orElseThrow(() -> new EntityNotFoundException(null));
	}

	@Override
	public List<SignLocationVO> readAll() {
		// TODO Auto-generated method stub
		return StreamSupport.stream(repo.findAll().spliterator(), true)
				.collect(Collectors.toList());
	}

}
