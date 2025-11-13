<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fns"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<div class="container my-4">
		<h2 class="text-center mb-4">Quản lý người dùng</h2>

		<!-- Thông báo -->
		<c:if test="${not empty message}">
			<div
				class="alert 
            <c:choose>
                <c:when test="${fns:contains(message,'Thêm') or fns:contains(message,'Cập nhật') or fns:contains(message,'Xóa')}">
                    alert-success
                </c:when>
                <c:when test="${fns:contains(message,'Vui lòng nhập')}">
                    alert-warning
                </c:when>
                <c:otherwise>
                    alert-danger
                </c:otherwise>
            </c:choose>
        text-center">
				${message}</div>
		</c:if>

		<!-- Form người dùng -->
		<c:url var="url" value="/user" />
		<form method="post" class="border rounded p-4 bg-light shadow-sm mb-4">
			<div class="mb-3">
				<label class="form-label">ID:</label> <input name="id"
					value="${item.id}" class="form-control"
					placeholder="Nhập ID người dùng">
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
				<button formaction="${url}/create" class="btn btn-success px-4 me-2">Thêm</button>
				<button formaction="${url}/update" class="btn btn-warning px-4 me-2">Cập
					nhật</button>
				<button formaction="${url}/delete" class="btn btn-danger px-4 me-2">Xóa</button>
				<button formaction="${url}/reset" class="btn btn-secondary px-4">Làm
					mới</button>
			</div>
		</form>

		<!-- Danh sách người dùng -->
		<div class="table-responsive shadow-sm">
			<table
				class="table table-bordered table-striped align-middle text-center">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
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
							<td><a href="${url}/edit/${u.id}"
								class="btn btn-sm btn-primary">Edit</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>

</html>