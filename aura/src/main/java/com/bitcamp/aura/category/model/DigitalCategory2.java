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
@Table(name="DIGITAL_CATEGORY2")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DigitalCategory2 {
	@Id
	@Column(name="CATEGORY_NUM")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="DIGITAL_CATEGORY2_SEQ")
	@SequenceGenerator(sequenceName="DIGITAL_CATEGORY2_SEQ", initialValue=1, allocationSize=1, name="DIGITAL_CATEGORY2_SEQ")
	private int num;

	@Column(name="CATEGORY_NAME")
	private String name;

	@Column(name="CATEGORY1_NUM")
	private int category1Num;
}
