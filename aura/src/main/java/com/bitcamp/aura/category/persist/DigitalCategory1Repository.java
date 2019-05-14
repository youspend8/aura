package com.bitcamp.aura.category.persist;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.bitcamp.aura.category.model.DigitalCategory1;

@Repository
public interface DigitalCategory1Repository extends CrudRepository<DigitalCategory1, Integer> {

}
