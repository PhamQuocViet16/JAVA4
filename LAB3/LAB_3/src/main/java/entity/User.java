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
@Table(name = "Users")
public class User {
	@Id
	@Column(name = "Id")
	private String id;

	@Column(name = "Password")
	private String password;

	@Column(name = "Fullname")
	private String fullname;

	@Column(name = "Email")
	private String email;

	@Column(name = "Admin")
	private boolean admin = false;

	@OneToMany(mappedBy = "user")
	private List<Favorite> favorites;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public List<Favorite> getFavorites() {
		return favorites;
	}

	public void setFavorites(List<Favorite> favorites) {
		this.favorites = favorites;
	}

}
