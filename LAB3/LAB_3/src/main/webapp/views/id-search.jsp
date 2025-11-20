<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fns"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Id Search</title>
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
<style>
body {
	background: #f4f6f9;
	padding-top: 40px;
}

.search-card {
	border-radius: 12px;
	padding: 25px;
	background: white;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.07);
}

.result-card {
	border-radius: 12px;
	background: white;
	padding: 20px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.07);
}

.user-info li {
	margin-bottom: 5px;
	font-size: 17px;
}
</style>
</head>
<body>
	<c:set var="path" value="${pageContext.request.contextPath}" />

	<div class="container">

		<!-- SEARCH BOX -->
		<div class="search-card mb-4">
			<h4 class="mb-3">
				<i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm User theo ID
			</h4>

			<form action="${path}/id-search" method="post">
				<div class="input-group">
					<input name="id" type="text" class="form-control"
						placeholder="Nhập username để tìm...">
					<button class="btn btn-dark px-4" type="submit">TÌM</button>
				</div>
			</form>

			<!-- ERROR MESSAGE -->
			<c:if test="${not empty error_id}">
				<div class="alert alert-danger mt-3">
					<i class="fa-solid fa-circle-exclamation"></i> ${error_id}
				</div>
			</c:if>
		</div>

		<!-- USER INFO -->
		<c:if test="${not empty user}">
			<div class="result-card mb-4">
				<h5 class="mb-3">
					<i class="fa-solid fa-user"></i> Thông tin User
				</h5>
				<ul class="user-info">
					<li><strong>Họ tên:</strong> ${user.fullname}</li>
					<li><strong>Email:</strong> ${user.email}</li>
				</ul>
			</div>
		</c:if>

		<!-- FAVORITE VIDEOS TABLE -->
		<div class="result-card">
			<h5 class="mb-3">
				<i class="fa-solid fa-heart"></i> Danh sách Video yêu thích
			</h5>

			<table class="table table-hover align-middle">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Title</th>
						<th>Views</th>
						<th>Active</th>
						<th>User</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="v" items="${favorite}">
						<tr>
							<td>${v.id}</td>
							<td>${v.video.title}</td>
							<td>${v.video.views}</td>
							<td><c:choose>
									<c:when test="${v.video.active}">
										<span class="badge bg-success">Active</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-secondary">Inactive</span>
									</c:otherwise>
								</c:choose></td>
							<td>${v.user.fullname}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

	</div>
</body>
</html>