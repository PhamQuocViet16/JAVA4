package dao;

import java.util.List;

import entity.Video;

public interface VideoDAO {
	/** Truy vấn tất cả */
	List<Video> findAll();

	/** Truy vấn theo mã */
	Video findById(String id);

	/** Thêm mới */
	void create(Video entity);

	/** Cập nhật */
	void update(Video entity);

	/** Xóa theo mã */
	void deleteById(String id);
}
