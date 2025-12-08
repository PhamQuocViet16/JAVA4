package dao;

import java.util.List;

import entity.Share;

public interface ShareDAO {
	List<Share> findAll();

	Share findById(String id);

	void create(Share entity);

	void update(Share entity);

	void deleteById(String id);

	List<Share> findByUser(String user);
}
