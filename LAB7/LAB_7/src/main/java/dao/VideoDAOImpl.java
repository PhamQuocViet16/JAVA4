package dao;

import java.util.List;

import entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class VideoDAOImpl implements VideoDAO {

	EntityManager em = JPA.getEntityManager();

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

	@Override
	public List<Video> top10Favorite() {
		try {
			String jpql = "SELECT f.video FROM Favorite f GROUP BY f.video ORDER BY COUNT(f.id) DESC";
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setMaxResults(10);
			return query.getResultList();
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<Video> findUnlikedVideos() {
		try {
			String jpql = "SELECT v FROM Video v WHERE v.favorites IS EMPTY";
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			return query.getResultList();
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<Video> findSharedVideos2024() {
		try {
			String jpql = "SELECT s.video FROM Share s " + "WHERE s.shareDate BETWEEN '2024-01-01' AND '2024-12-31' "
					+ "ORDER BY s.shareDate ASC";
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			return query.getResultList();
		} catch (Exception e) {
			return null;
		}
	}


}
