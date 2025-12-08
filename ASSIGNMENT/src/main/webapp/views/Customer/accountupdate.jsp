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
<body class="d-flex flex-column min-vh-100">
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

	<div class="container mt-5 flex-fill" style="max-width: 600px;">
		<h3 class="text-center mb-4">Cập Nhật Thông Tin Tài Khoản</h3>

		<c:if test="${not empty message}">
			<div class="alert alert-success">${message}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/AccountUpdate"
			method="post">
			<div class="mb-3">
				<label for="id" class="form-label">Username:</label> <input
					type="text" class="form-control" id="id" name="id"
					value="${user.id}" placeholder="Nhập username của bạn">
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">Mật khẩu:</label> <input
					type="text" class="form-control" id="password" name="password"
					value="${user.password}" placeholder="Nhập mật khẩu mới">
			</div>

			<div class="mb-3">
				<label for="fullname" class="form-label">Họ và tên</label> <input
					type="text" class="form-control" id="fullname" name="fullname"
					value="${user.fullname}" required placeholder="Nhập họ và tên">
			</div>

			<div class="mb-3">
				<label for="email" class="form-label">Email</label> <input
					type="email" class="form-control" id="email" name="email"
					value="${user.email}" required placeholder="Nhập địa chỉ email">
			</div>

			<button type="submit" class="btn btn-primary w-100">Cập nhật</button>
		</form>
	</div>

	<footer
		class="bg-dark text-white p-3 text-center justify-content-center mt-5">©
		Copyright by FPT Polytechnic</footer>
</body>
</html>