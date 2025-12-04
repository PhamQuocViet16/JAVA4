package dao;

import java.util.List;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class UserDAOImpl implements UserDAO {
	private EntityManager em = JPA.getEntityManager();

	@Override
	public List<User> findAll() {
		String jpql = "SELECT u FROM User u";
		return em.createQuery(jpql, User.class).getResultList();
	}

	@Override
	public User findById(String id) {
		try {
			String jpql = "SELECT u FROM User u WHERE LOWER(u.id) = :id";
			return em.createQuery(jpql, User.class).setParameter("id", id.toLowerCase()).getSingleResult();
		} catch (Exception e) {
			System.out.println("User not found for ID = " + id);
			return null;
		}
	}

	@Override
	public void create(User entity) {
		try {
			em.getTransaction().begin();
			em.persist(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
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
			e.printStackTrace();
		}
	}

	@Override
	public void deleteById(String id) {
		User entity = em.find(User.class, id);
		if (entity == null)
			return;
		try {
			em.getTransaction().begin();
			em.remove(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	@Override
	public User findByIdOrEmail(String id, String password) {
		try {
			String jpql = "SELECT u FROM User u WHERE (u.id = :id OR u.email = :id) AND u.password = :password";
			return em.createQuery(jpql, User.class).setParameter("id", id.trim()).setParameter("password", password)
					.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public User findByUsernameOrEmail(String id) {
		try {
			String jpql = "SELECT u FROM User u WHERE u.id = :id OR u.email = :id";
			return em.createQuery(jpql, User.class).setParameter("id", id.trim()).getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<User> findByKeyword(String keyword) {
		try {
			String jpql = "SELECT u FROM User u WHERE u.id LIKE :kw OR u.fullname LIKE :kw OR u.email LIKE :kw";
			return em.createQuery(jpql, User.class).setParameter("kw", "%" + keyword + "%").getResultList();
		} catch (Exception e) {
			return null;
		}
	}
}
