package dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class ShareDAOImpl implements ShareDAO {
	EntityManager em = JPA.getEntityManager();

	@Override
	public List<Object[]> shareSummary() {
		try {
			String jpql = "SELECT s.video.title, COUNT(s.id), MIN(s.shareDate), MAX(s.shareDate) "
					+ "FROM Share s GROUP BY s.video.title";
			TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
			return query.getResultList();
		} catch (Exception e) {
			return null;
		}
	}

}
