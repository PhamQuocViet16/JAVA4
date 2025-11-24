package dao;

import java.util.List;

public interface ShareDAO {
	/*
	 * Xây dựng trang web hiển thị thông tin chia sẻ tổng hợp của từng video gồm)
	 * Tiêu đề video, Số lượt chia sẻ, ngày chia sẻ đầu tiên, ngày chia sẻ cuối
	 * cùng)
	 */
	List<Object[]> shareSummary();
}
