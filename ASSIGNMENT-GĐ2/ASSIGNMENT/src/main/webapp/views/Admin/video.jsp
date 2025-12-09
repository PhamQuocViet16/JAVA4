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
									<li><a class="dropdown-item" href="${path}/AccountUpdate">Chỉnh
											Sửa Tài Khoản</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="dropdown-item" href="${path}/Login">Đăng
											Nhập</a></li>
									<li><a class="dropdown-item" href="#">Quên Mật Khẩu</a></li>
									<li><a class="dropdown-item" href="${path}/Register">Đăng
											Ký</a></li>
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

	<div class="container mt-4">

		<h2 class="text-center mb-4">Quản Lý Video</h2>

		<!-- Thông báo -->
		<c:if test="${not empty message}">
			<div class="alert alert-info">${message}</div>
		</c:if>

		<!-- Form thêm/sửa video -->
		<c:url var="url" value="/Video" />
		<form method="get" action="${url}/search"
			class="d-flex justify-content-center mb-4">
			<div class="input-group w-50">
				<span class="input-group-text bg-white border-end-0"
					id="search-icon"> <i class="fa-solid fa-magnifying-glass"></i>
				</span> <input type="text" name="keyword"
					class="form-control border-start-0" placeholder="Tìm video..."
					aria-label="Tìm video" aria-describedby="search-icon"
					value="${param.keyword != null ? param.keyword : ''}">
				<button class="btn btn-primary" type="submit">Tìm</button>
			</div>
		</form>
		<div class="card shadow mb-4">
			<div class="card-header bg-primary text-white">
				<h5 class="mb-0">Thông Tin Video</h5>
			</div>
			<div class="card-body">
				<form action="" method="post">
					<div class="row g-3">
						<!-- Cột 1 -->
						<div class="col-md-6">
							<div class="mb-3">
								<label class="form-label fw-bold">ID</label> <input type="text"
									class="form-control" name="id" value="${item.id}"
									placeholder="Nhập ID video" />
							</div>
							<div class="mb-3">
								<label class="form-label fw-bold">Title</label> <input
									type="text" class="form-control" name="title"
									value="${item.title}" placeholder="Nhập tiêu đề video" />
							</div>
							<div class="mb-3">
								<label class="form-label fw-bold">Poster URL</label> <input
									type="text" class="form-control" name="poster"
									value="${item.poster}" placeholder="Nhập URL poster" />
							</div>
							<div class="mb-3">
								<label class="form-label fw-bold">Category</label> <input
									type="text" class="form-control" name="category"
									value="${item.category}" placeholder="Nhập danh mục" />
							</div>
						</div>

						<!-- Cột 2 -->
						<div class="col-md-6">
							<div class="mb-3">
								<label class="form-label fw-bold">Description</label>
								<textarea class="form-control" name="description" rows="8"
									placeholder="Nhập mô tả video...">${item.description}</textarea>
							</div>
							<div class="mb-3">
								<label class="form-label fw-bold">Views</label> <input
									type="number" class="form-control" name="views"
									value="${item.views}" min="0" />
							</div>
							<div class="form-check mt-4">
								<input class="form-check-input" type="checkbox" name="active"
									value="true" <c:if test="${item.active}">checked</c:if> /> <label
									class="form-check-label fw-bold">Active</label>
							</div>
						</div>
					</div>

					<!-- Nút hành động -->
					<div class="mt-4 d-flex gap-2">
						<button formaction="${url}/create"
							class="btn btn-success flex-fill">
							<i class="fa-solid fa-plus"></i> Thêm
						</button>
						<button formaction="${url}/update"
							class="btn btn-primary flex-fill">
							<i class="fa-solid fa-pen"></i> Cập nhật
						</button>
						<button formaction="${url}/delete"
							class="btn btn-danger flex-fill"
							onclick="return confirm('Bạn có chắc muốn xóa video này?')">
							<i class="fa-solid fa-trash"></i> Xóa
						</button>
						<button formaction="${url}/reset"
							class="btn btn-secondary flex-fill">
							<i class="fa-solid fa-refresh"></i> Làm mới
						</button>
					</div>
				</form>
			</div>
		</div>

		<!-- Bảng danh sách video -->
		<div class="card shadow">
			<div class="card-header bg-info text-white">
				<h5 class="mb-0">Danh Sách Video</h5>
			</div>
			<div class="card-body table-responsive">
				<table
					class="table table-bordered table-hover align-middle text-center">
					<thead class="table-light">
						<tr>
							<th>ID</th>
							<th>Title</th>
							<th>Poster</th>
							<th>Category</th>
							<th>Description</th>
							<th>Views</th>
							<th>Active</th>
							<th>Hành động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="v" items="${list}">
							<tr>
								<td>${v.id}</td>
								<td>${v.title}</td>
								<td><img src="${v.poster}" width="80" height="50"
									alt="poster" /></td>
								<td>${v.category}</td>
								<td class="text-start"
									style="max-width: 250px; white-space: pre-wrap;">${v.description}</td>
								<td>${v.views}</td>
								<td><c:if test="${v.active}">✔</c:if></td>
								<td><a href="${url}/edit?id=${v.id}"
									class="btn btn-warning btn-sm mb-1"><i
										class="fa-solid fa-pen"></i> Sửa</a> <a
									href="${url}/delete?id=${v.id}" class="btn btn-danger btn-sm"
									onclick="return confirm('Bạn có chắc muốn xóa video này?')">
										<i class="fa-solid fa-trash"></i> Xóa
								</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
</body>
</html>