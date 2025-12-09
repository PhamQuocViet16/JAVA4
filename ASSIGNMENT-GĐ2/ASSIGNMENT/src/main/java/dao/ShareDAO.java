package dao;

import java.util.List;

import entity.Share;

public interface ShareDAO {
	List<Share> findAll();

	Share findById(Long id);

	void create(Share entity);

	void update(Share entity);

	void deleteById(Long id);

	List<Share> findByUser(String user);
	
	List<Object[]> findSharesByVideo(String videoId);
}
