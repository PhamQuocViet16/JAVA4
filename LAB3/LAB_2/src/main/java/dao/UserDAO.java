package dao;

import java.util.List;

import entity.User;

public interface UserDAO {
	/**Truy vấn tất cả*/
	List<User> findAll();
	/**Truy vấn theo mã*/
	User findById(String id);
	/**Thêm mới*/
	void create(User entity);
	/**Cập nhật*/
	void update(User entity);
	/**Xóa theo mã*/
	void deleteById(String id);
}
