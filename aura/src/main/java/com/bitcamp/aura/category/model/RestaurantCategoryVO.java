package com.bitcamp.aura.category.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="RESTAURANT_CATEGORY")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RestaurantCategoryVO {
	@Id
	@Column(name="CATEGORY_NUM")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="RESTAURANT_CATEGORY_SEQ")
	@SequenceGenerator(name="RESTAURANT_CATEGORY_SEQ", initialValue=1, allocationSize=1, sequenceName="RESTAURANT_CATEGORY_SEQ")
	private int num;
	
	@Column(name="CATEGORY_NAME", length=30)
	private String name;
}
