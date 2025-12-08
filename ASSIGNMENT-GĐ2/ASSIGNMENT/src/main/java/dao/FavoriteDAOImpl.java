package dao;

import java.util.List;

import entity.Favorite;
import entity.User;
import entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class FavoriteDAOImpl implements FavoriteDAO {
	EntityManager em = JPA.getEntityManager();

	@Override
	public void save(Favorite favorite) {
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(favorite);
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (tx.isActive())
				tx.rollback();
		}

	}

	@Override
	public List<Favorite> findByUser(User user) {
		try {
			String jpql = "SELECT f FROM Favorite f WHERE f.user = :user";
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("user", user);
			return query.getResultList();
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public boolean exists(User user, Video video) {
		try {
			String jpql = "SELECT COUNT(f) FROM Favorite f WHERE f.user = :user AND f.video.id = :videoId";
			TypedQuery<Long> query = em.createQuery(jpql, Long.class);
			query.setParameter("user", user);
			query.setParameter("videoId", video.getId());
			Long count = query.getSingleResult();
			return count != null && count > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public void delete(User user, Video video) {
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			// Tìm đối tượng Favorite trước
			String jpql = "SELECT f FROM Favorite f WHERE f.user = :user AND f.video.id = :videoId";
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("user", user);
			query.setParameter("videoId", video.getId());
			List<Favorite> list = query.getResultList();

			// Nếu tồn tại thì xóa
			for (Favorite f : list) {
				em.remove(f);
			}

			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			if (tx.isActive())
				tx.rollback();
		}
	}

}
