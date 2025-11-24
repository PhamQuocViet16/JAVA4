package dao;

import java.util.List;

import entity.Favorite;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JPA;

public class FavoriteDAOImpl implements FavoriteDAO {

	EntityManager em = JPA.getEntityManager();

//	public List<Favorite> findFavoritesByUserId(String userId) {
//	User user = em.find(User.class, userId); // load user
//	if (user == null) {
//		return null;
//	}
//	// Trả về list favorite từ quan hệ @OneToMany
//	return user.getFavorites();
//}

	@Override
	public List<Favorite> findFavoritesByUserIdJPQL(String userId) {
		String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :uid";
		TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
		query.setParameter("uid", userId);
		return query.getResultList();
	}

	@Override
	public List<Favorite> findFavoritesByUserIdJPQL1(String userId) {
		// Sử dụng tham số số ?1 thay vì :uid
		String jpql = "SELECT f FROM Favorite f WHERE f.user.id = ?1";
		TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
		query.setParameter(1, userId); // truyền giá trị vào ?1
		return query.getResultList();
	}

}
