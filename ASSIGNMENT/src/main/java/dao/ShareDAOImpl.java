package dao;

import java.util.List;

import entity.Share;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class ShareDAOImpl implements ShareDAO {

	EntityManager em = JPA.getEntityManager();

	@Override
	public List<Share> findAll() {
		String jpql = "SELECT s FROM Share s ORDER BY s.shareDate DESC";
		TypedQuery<Share> query = em.createQuery(jpql, Share.class);
		return query.getResultList();
	}

	@Override
	public Share findById(String id) {
		return em.find(Share.class, id);
	}

	@Override
	public void create(Share entity) {
		try {
			em.getTransaction().begin();
			em.persist(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public void update(Share entity) {
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
		Share entity = em.find(Share.class, id);
		try {
			em.getTransaction().begin();
			em.remove(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public List<Share> findByUser(String userId) {
		try {
			String jpql = "SELECT s FROM Share s WHERE s.user.id = :uid";
			TypedQuery<Share> query = em.createQuery(jpql, Share.class);
			query.setParameter("uid", userId);
			return query.getResultList();
		} catch (Exception e) {
			return null;
		}
	}
}
