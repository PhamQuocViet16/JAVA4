package entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Sinh ra GETER/SETTER
@NoArgsConstructor // Hàm tại ko tham số
@AllArgsConstructor // Hàm tạo với đầy đủ tham số
@Entity
@Table(name = "Videos")
public class Video {
	@Id
	@Column(name = "Id")
	private String id;

	@Column(name = "Title")
	private String title;

	@Column(name = "Poster")
	private String poster;

	@Column(name = "Description")
	private String description;

	@Column(name = "Views")
	private int views = 0;

	@Column(name = "Active")
	private boolean active = false;

	@Column(name = "Category")
	private String category;

	@OneToMany(mappedBy = "video")
	private List<Favorite> favorites;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public List<Favorite> getFavorites() {
		return favorites;
	}

	public void setFavorites(List<Favorite> favorites) {
		this.favorites = favorites;
	}

}
