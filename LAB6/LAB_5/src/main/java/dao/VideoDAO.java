package dao;

import java.util.List;

import entity.Video;

public interface VideoDAO {
	/* Tìm các video có title chứa từ khóa <<keyword>> */
	List<Video> findByKeyword(String keyword);

	/* Truy vấn 10 video được yêu thích nhiều nhất */
	List<Video> top10Favorite();

	/* Tìm các video không được ai thích */
	List<Video> findUnlikedVideos();

	/* Tìm video được chia sẻ trong năm 2024 và sắp xếp theo thời gian */
	List<Video> findSharedVideos2024();
}
