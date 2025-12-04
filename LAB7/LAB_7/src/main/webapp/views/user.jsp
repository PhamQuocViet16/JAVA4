<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Người Dùng (Fetch API)</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container mt-4">
		<h2>Quản Lý Người Dùng</h2>

		<!-- Form thêm/sửa user -->
		<form id="userForm" class="row g-3 mb-4">
			<div class="col-md-2">
				<input type="text" class="form-control" id="id" placeholder="ID"
					required>
			</div>
			<div class="col-md-3">
				<input type="text" class="form-control" id="fullname"
					placeholder="Họ tên" required>
			</div>
			<div class="col-md-3">
				<input type="email" class="form-control" id="email"
					placeholder="Email" required>
			</div>
			<div class="col-md-2">
				<input type="password" class="form-control" id="password"
					placeholder="Password" required>
			</div>
			<div class="col-md-2">
				<button type="submit" class="btn btn-primary w-100" id="saveBtn">Thêm
					/ Cập nhật</button>
			</div>
		</form>

		<!-- Bảng danh sách người dùng -->
		<table class="table table-bordered table-striped" id="userTable">
			<thead>
				<tr>
					<th>ID</th>
					<th>Họ tên</th>
					<th>Email</th>
					<th>Admin</th>
					<th>Hành động</th>
				</tr>
			</thead>
			<tbody>
				<!-- Dữ liệu sẽ load từ fetch API -->
			</tbody>
		</table>
	</div>

	<script>
// Biến context path từ JSP
const contextPath = "${pageContext.request.contextPath}";
const apiUrl = contextPath + "/api/users";

// Hàm load danh sách user
async function loadUsers() {
	try {
		const res = await fetch(apiUrl);
		if (!res.ok) throw new Error("Không thể tải danh sách user");
		const users = await res.json();
		const tbody = document.querySelector("#userTable tbody");
		tbody.innerHTML = "";
		users.forEach(u => {
			tbody.innerHTML += `
				<tr>
					<td>${u.id}</td>
					<td>${u.fullname}</td>
					<td>${u.email}</td>
					<td>${u.admin ? "Yes" : "No"}</td>
					<td>
						<button class="btn btn-sm btn-info" onclick="editUser('${u.id}')">Sửa</button>
						<button class="btn btn-sm btn-danger" onclick="deleteUser('${u.id}')">Xóa</button>
					</td>
				</tr>
			`;
		});
	} catch (err) {
		console.error(err);
		alert(err.message);
	}
}

// Thêm user (POST)
async function addUser(user) {
	const res = await fetch(apiUrl, {
		method: "POST",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(user)
	});
	if (!res.ok) {
		const msg = await res.text();
		throw new Error(msg || "Thêm user thất bại");
	}
	return await res.json();
}

// Cập nhật user (PUT)
async function updateUser(id, user) {
	const res = await fetch(`${apiUrl}/${id}`, {
		method: "PUT",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(user)
	});
	if (!res.ok) {
		const msg = await res.text();
		throw new Error(msg || "Cập nhật user thất bại");
	}
}

// Submit form
document.getElementById("userForm").addEventListener("submit", async function(e) {
	e.preventDefault();
	const idInput = document.getElementById("id");
	const id = idInput.value.trim();
	const fullname = document.getElementById("fullname").value.trim();
	const email = document.getElementById("email").value.trim();
	const password = document.getElementById("password").value;

	if (!id || !fullname || !email || !password) {
		alert("Vui lòng điền đầy đủ thông tin");
		return;
	}

	const user = { id, fullname, email, password, admin: false };

	try {
		// Kiểm tra user đã tồn tại
		const resCheck = await fetch(`${apiUrl}/${id}`);
		if (resCheck.ok) {
			// Nếu tồn tại -> PUT
			await updateUser(id, user);
			alert("Cập nhật user thành công");
		} else if (resCheck.status === 404) {
			// Nếu không tồn tại -> POST
			await addUser(user);
			alert("Thêm user thành công");
		} else {
			throw new Error("Lỗi kiểm tra user");
		}
		this.reset();
		idInput.readOnly = false; // bật lại khi submit xong
		loadUsers();
	} catch (err) {
		console.error(err);
		alert(err.message);
	}
});

// Fill form khi click Sửa
async function editUser(id) {
	try {
		const res = await fetch(`${apiUrl}/${id}`);
		if (!res.ok) throw new Error("User không tồn tại");
		const u = await res.json();
		document.getElementById("id").value = u.id;
		document.getElementById("fullname").value = u.fullname;
		document.getElementById("email").value = u.email;
		document.getElementById("password").value = u.password;
		document.getElementById("id").readOnly = true; // khóa ID khi sửa
	} catch (err) {
		alert(err.message);
	}
}

// Xóa user
async function deleteUser(id) {
	if (!confirm("Bạn có chắc muốn xóa user này?")) return;
	const res = await fetch(`${apiUrl}/${id}`, { method: "DELETE" });
	if (!res.ok) {
		const msg = await res.text();
		throw new Error(msg || "Xóa user thất bại");
	}
	loadUsers();
}

// Load danh sách khi mở trang
loadUsers();
</script>
</body>
</html>
