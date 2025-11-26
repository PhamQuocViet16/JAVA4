package dao;

import java.util.List;

import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class UserDAOImpl implements UserDAO {
	EntityManager em = JPA.getEntityManager();

	@Override
	public List<User> findAll() {
		String jpql = "SELECT o FROM User o";
		TypedQuery<User> query = em.createQuery(jpql, User.class);
		return query.getResultList();
	}

	@Override
	public User findById(String id) {
		return em.find(User.class, id);
	}

	@Override
	public void create(User entity) {
		try {
			em.getTransaction().begin();
			em.persist(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}

	}

	@Override
	public void update(User entity) {
		try {
			em.getTransaction().begin();
			em.merge(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}

	}

	@Override
	public void deleteById(String id) {
		User entity = em.find(User.class, id);
		try {
			em.getTransaction().begin();
			em.remove(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}

	}

	@Override
	public User findByIdOrEmail(String id, String password) {
		try {
			String jpql = "SELECT u FROM User u " + "WHERE (u.id = :id OR u.email = :id) "
					+ "AND u.password = :password";
			TypedQuery<User> query = em.createQuery(jpql, User.class);
			query.setParameter("id", id.trim());
			query.setParameter("password", password);

			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

}
