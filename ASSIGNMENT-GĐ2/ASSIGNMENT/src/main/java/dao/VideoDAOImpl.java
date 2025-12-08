package dao;

import java.util.List;

import entity.User;
import entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class VideoDAOImpl implements VideoDAO {
	EntityManager em = JPA.getEntityManager();

	@Override
	public List<Video> findAll() {
//		String jpql = "SELECT v FROM Video v ORDER BY v.views DESC";
		String jpql = "SELECT v FROM Video v ORDER BY v.id ASC";
		TypedQuery<Video> query = em.createQuery(jpql, Video.class);
		return query.getResultList();
	}

	@Override
	public Video findById(String id) {
		return em.find(Video.class, id);
	}

	@Override
	public void create(Video entity) {
		try {
			em.getTransaction().begin();
			em.persist(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}

	}

	@Override
	public void update(Video entity) {
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
		Video entity = em.find(Video.class, id);
		try {
			em.getTransaction().begin();
			em.remove(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}

	}

	@Override
	public List<Video> findByKeyword(String keyword) {
		try {
			String jpql = "SELECT v FROM Video v WHERE v.title LIKE :keyword";
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setParameter("keyword", "%" + keyword + "%");
			return query.getResultList();
		} catch (Exception e) {
			return null;
		}
	}

}
