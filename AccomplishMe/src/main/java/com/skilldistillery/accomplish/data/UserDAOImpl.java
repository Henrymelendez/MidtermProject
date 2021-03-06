package com.skilldistillery.accomplish.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.accomplish.entities.User;

@Service
@Transactional
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public User findById(int userId) {
		return em.find(User.class, userId);
	}

	@Override
	public User findByUserNameAndPassword(String username, String password) {
		String jpql = "SELECT u FROM User u WHERE u.username = :username AND u.active = 1";
		User user = null;
		try {
			user = em.createQuery(jpql, User.class).setParameter("username", username).getSingleResult();
			
		} catch (NoResultException e){
			
		}
		if (user != null && !user.getPassword().equals(password)) {
			user = null;
		}

		return user;
	}
	
	@Override
	public List<User> findByFirstAndLastName(String name) {
		List<User> users = new ArrayList<>();
		String jpql = "SELECT u FROM User u WHERE u.firstName LIKE :name OR u.lastName LIKE :name AND u.active = 1";
		try {
			users = em.createQuery(jpql, User.class).setParameter("name", name).getResultList();
			
		} catch (NoResultException e){
			
		}
		
		return users;
	}

	@Override
	public User createaUser(User user) {
		String jpql = "SELECT username FROM User";
		List<String> existingUsernames = em.createQuery(jpql, String.class).getResultList();
		boolean freeName = true;
		for (String username : existingUsernames) {
			if (user.getUsername().equals(username)) {
				freeName = false;
			}
		}
		if (freeName) {
			em.persist(user);
		}

		return user;
	}
	
	@Override
	public boolean deleteUser(int userId) {
		boolean isUserDeleted = false;
		User user = em.find(User.class, userId);
		if(user != null) {
			user.setActive(false);
			isUserDeleted = !user.getActive();
			
			
		}
		return isUserDeleted;
	}
	
	@Override
	public User editUser(User user) {
		int id = user.getId();
		
		User userToEdit = em.find(User.class, id);
		
		userToEdit.setHeight(user.getHeight());
		userToEdit.setWeight(user.getWeight());
		userToEdit.setFirstName(user.getFirstName());
		userToEdit.setLastName(user.getLastName());
		
		return userToEdit;
	}
	
	@Override
	public User editUsernamePassword(User user) {
		int id = user.getId();
		
		User userToEdit = em.find(User.class, id);
		
		userToEdit.setUsername(user.getUsername());
		userToEdit.setPassword(user.getPassword());
		
		return userToEdit;
	}

	@Override
	public User addPhoto(User user) {
		User managed = em.find(User.class, user.getId());
		
		managed.setUserPhoto(user.getUserPhoto());
		
		return managed;
	}
}
