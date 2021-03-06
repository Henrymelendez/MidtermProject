package com.skilldistillery.accomplish.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAAccomplishMe");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 2);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	@DisplayName("Test User Mapping")
	void test_user_mappping() {
		assertNotNull(user);
		assertEquals("Mason", user.getUsername());
	}

	@Test
	@DisplayName("Test User Challenge mapping")
	void test_user_challenge_mapping() {

		assertNotNull(user);
		assertNotNull(user.getUserChallenges());
		assertTrue(user.getUserChallenges().size() > 0);

	}

	@Test
	@DisplayName("Test created Challenge mapping")
	void test_created_challenge_mapping() {
		user = em.find(User.class, 1);
		assertNotNull(user);
		assertNotNull(user.getCreatedChallenges());
		assertTrue(user.getCreatedChallenges().size() > 0);
	}
	
	@Test
	@DisplayName("Test created details")
	void test_created_challenge_detail(){
		assertNotNull(user);
		assertNotNull(user.getCreatedChallengeDetails());
		assertTrue(user.getCreatedChallengeDetails().size() > 0);
	}
}
