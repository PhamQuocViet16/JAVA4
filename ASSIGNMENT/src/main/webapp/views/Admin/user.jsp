<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fns"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ONLINE ENTERTAINMENT</title>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
	crossorigin="anonymous"></script>
</head>
<body>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<c:set var="userSession" value="${sessionScope.user}" />
	<c:set var="userid"
		value="${userSession != null ? userSession.id : ''}" />
	<nav class="navbar navbar-expand-sm navbar-dark bg-dark sticky-top">
		<div class="container">
			<!-- Logo -->
			<a class="navbar-brand" href="${path}/Home"> <img
				src="${path}/images/logo-energy-pilates.png" alt=""
				style="width: 150px;">
			</a>

			<!-- Button responsive -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Menu -->
			<div class="collapse navbar-collapse" id="collapsibleNavbar">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link"
						href="${path}/Home?id=${userid}"> <i class="fa-solid fa-house"></i>
							Home
					</a></li>
					<!-- Menu Yêu thích cho User hoặc chưa đăng nhập -->
					<c:if
						test="${empty userSession || (not empty userSession && userSession.admin == false)}">
						<li class="nav-item"><a class="nav-link"
							href="${path}/Favorite?id=${userid}"> <i
								class="fa-solid fa-bookmark"></i> Yêu Thích Của Tôi
						</a></li>
					</c:if>

					<!-- Menu Admin -->
					<c:if test="${not empty userSession && userSession.admin == true}">
						<li class="nav-item"><a class="nav-link"
							href="${path}/Video?id=${userid}"> <i
								class="fa-solid fa-video"></i> Video
						</a></li>

						<li class="nav-item"><a class="nav-link"
							href="${path}/User?id=${userid}"> <i
								class="fa-solid fa-users"></i> Users
						</a></li>

						<li class="nav-item"><a class="nav-link"
							href="${path}/Reports?id=${userid}"> <i
								class="fa-solid fa-chart-column"></i> Reports
						</a></li>
					</c:if>

					<!-- Tài khoản luôn hiển thị kế bên menu Yêu thích/Admin -->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown"> <i class="fa-solid fa-user"></i> <c:choose>
								<c:when test="${not empty userSession}">
                                Xin chào, ${userSession.fullname}
                            </c:when>
								<c:otherwise>
                                Tài khoản
                            </c:otherwise>
							</c:choose>
					</a>

						<ul class="dropdown-menu">
							<c:choose>
								<c:when test="${not empty userSession}">
									<li><a class="dropdown-item" href="${path}/Logout">Đăng
											Xuất</a></li>
									<li><a class="dropdown-item" href="#">Đổi Mật Khẩu</a></li>
									<li><a class="dropdown-item" href="${path}/AccountUpdate">Chỉnh Sửa Tài
											Khoản</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="dropdown-item" href="${path}/Login">Đăng
											Nhập</a></li>
									<li><a class="dropdown-item" href="#">Quên Mật Khẩu</a></li>
									<li><a class="dropdown-item" href="${path}/Register">Đăng Ký</a></li>
								</c:otherwise>
							</c:choose>
						</ul></li>

				</ul>

				<!-- Ngôn ngữ -->
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#">Tiếng
							Việt</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Tiếng
							Anh</a></li>
				</ul>

			</div>
		</div>
	</nav>
	<div class="container my-4">
		<h2 class="text-center mb-4">Quản Lý Người Dùng</h2>

		<!-- Thông báo -->
		<c:if test="${not empty message}">
			<c:set var="alertClass" value="alert-info" />
			<c:set var="alertIcon" value="fa-info-circle" />

			<c:choose>
				<c:when
					test="${fns:contains(message,'Thêm') or fns:contains(message,'Cập nhật') or fns:contains(message,'Xóa')}">
					<c:set var="alertClass" value="alert-success" />
					<c:set var="alertIcon" value="fa-circle-check" />
				</c:when>
				<c:when test="${fns:contains(message,'Vui lòng nhập')}">
					<c:set var="alertClass" value="alert-warning" />
					<c:set var="alertIcon" value="fa-triangle-exclamation" />
				</c:when>
				<c:when test="${fns:contains(message,'Lỗi')}">
					<c:set var="alertClass" value="alert-danger" />
					<c:set var="alertIcon" value="fa-circle-xmark" />
				</c:when>
			</c:choose>

			<div
				class="alert ${alertClass} alert-dismissible fade show d-flex align-items-center"
				role="alert">
				<i class="fa-solid ${alertIcon} me-2"></i> <span>${message}</span>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
		</c:if>

		<!-- Form tìm kiếm -->
		<c:url var="url" value="/User" />
		<form method="get" action="${url}/search"
			class="d-flex justify-content-center mb-4">
			<div class="input-group w-50">
				<span class="input-group-text bg-white border-end-0"
					id="search-icon"> <i class="fa-solid fa-magnifying-glass"></i>
				</span> <input type="text" name="keyword"
					class="form-control border-start-0" placeholder="Tìm người dùng..."
					aria-label="Tìm người dùng" aria-describedby="search-icon">
				<button class="btn btn-primary" type="submit">Tìm</button>
			</div>
		</form>


		<!-- Form người dùng -->
		<c:url var="url" value="/User" />
		<form method="post" class="border rounded p-4 bg-light shadow-sm mb-4">
			<div class="mb-3">
				<label class="form-label">Username:</label> <input name="id"
					value="${item.id}" class="form-control"
					placeholder="Nhập username người dùng">
			</div>

			<div class="mb-3">
				<label class="form-label">Password:</label> <input name="password"
					type="password" value="${item.password}" class="form-control"
					placeholder="Nhập mật khẩu">
			</div>

			<div class="mb-3">
				<label class="form-label">Fullname:</label> <input name="fullname"
					value="${item.fullname}" class="form-control"
					placeholder="Nhập họ tên">
			</div>

			<div class="mb-3">
				<label class="form-label">Email:</label> <input name="email"
					type="email" value="${item.email}" class="form-control"
					placeholder="Nhập email">
			</div>

			<div class="mb-3">
				<label class="form-label d-block">Role:</label>
				<div class="form-check form-check-inline">
					<input name="admin" class="form-check-input" type="radio"
						value="true" ${item.admin ? 'checked' : ''}> <label
						class="form-check-label">Admin</label>
				</div>
				<div class="form-check form-check-inline">
					<input name="admin" class="form-check-input" type="radio"
						value="false" ${!item.admin ? 'checked' : ''}> <label
						class="form-check-label">User</label>
				</div>
			</div>

			<div class="text-center">
				<button formaction="${url}/create" class="btn btn-success px-4 me-2">
					<i class="fa-solid fa-plus"></i> Thêm
				</button>
				<button formaction="${url}/update" class="btn btn-warning px-4 me-2">
					<i class="fa-solid fa-pen"></i> Cập nhật
				</button>
				<button formaction="${url}/delete" class="btn btn-danger px-4 me-2">
					<i class="fa-solid fa-trash"></i> Xóa
				</button>
				<button formaction="${url}/reset" class="btn btn-secondary px-4">
					<i class="fa-solid fa-refresh"></i> Làm mới
				</button>
			</div>
		</form>

		<!-- Danh sách người dùng -->
		<div class="table-responsive shadow-sm">
			<table
				class="table table-bordered table-striped align-middle text-center">
				<thead class="table-dark">
					<tr>
						<th>Username</th>
						<th>Password</th>
						<th>Fullname</th>
						<th>Email</th>
						<th>Role</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="u" items="${list}">
						<tr>
							<td>${u.id}</td>
							<td>${u.password}</td>
							<td>${u.fullname}</td>
							<td>${u.email}</td>
							<td>${u.admin?'Admin':'User'}</td>
							<td><a href="${url}/edit?id=${u.id}"
								class="btn btn-sm btn-primary">Edit</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<footer
		class="bg-dark text-white p-3 text-center justify-content-center mt-5">©
		Copyright by FPT Polytechnic</footer>
</body>

</html>