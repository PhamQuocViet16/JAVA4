package dao;

import java.util.List;

import entity.Favorite;

public interface FavoriteDAO {
	// cách 1
	List<Favorite> findFavoritesByUserIdJPQL(String userId);
	// cách 2
	List<Favorite> findFavoritesByUserIdJPQL1(String userId);
}
