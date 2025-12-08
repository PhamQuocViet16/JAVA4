package dao;

import java.util.List;

import entity.Favorite;
import entity.User;
import entity.Video;

public interface FavoriteDAO {
	// Lưu favorite
	void save(Favorite favorite);

	// Lấy danh sách yêu thích theo user
	List<Favorite> findByUser(User user);

	// kiểm tra đã like chưa
	boolean exists(User user, Video video);
	
	//Xoá favorite
	void delete(User user, Video video);
}
