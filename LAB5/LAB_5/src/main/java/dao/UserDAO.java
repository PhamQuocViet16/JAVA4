package dao;

import java.util.List;

import entity.User;

public interface UserDAO {
	/** Truy vấn tất cả */
	List<User> findAll();

	/** Truy vấn theo mã */
	User findById(String id);

	/** Thêm mới */
	void create(User entity);

	/** Cập nhật */
	void update(User entity);

	/** Xóa theo mã */
	void deleteById(String id);
	
	/* Truy vấn user theo từ khóa (id, fullname, email) */
	List<User> findByKeyword(String keyword);

	/* Tìm User theo id hoặc email (chú ý: email là duy nhất) */
	User findByIdOrEmail(String id, String email);

	/* Kiểm tra username và password khi đăng nhập */
	User findByUsernameOrEmail(String id);
}
