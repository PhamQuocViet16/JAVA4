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
							href="${path}/YeuThich?id=${userid}"> <i
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
									<li><a class="dropdown-item" href="#">Chỉnh Sửa Tài
											Khoản</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="dropdown-item" href="${path}/Login">Đăng
											Nhập</a></li>
									<li><a class="dropdown-item" href="#">Quên Mật Khẩu</a></li>
									<li><a class="dropdown-item" href="#">Đăng Ký</a></li>
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
	<div
		class="container d-flex justify-content-center align-items-center vh-100">
		<div class="col-md-4">

			<div class="card shadow-lg border-0 rounded-4">
				<div class="card-body p-4">

					<h3 class="text-center mb-4">Đăng Nhập</h3>
					<!-- Hiển thị thông báo lỗi từ filter -->
					<c:if test="${not empty sessionScope.securi}">
						<div class="alert alert-danger">${sessionScope.securi}</div>
						<!-- Xóa thông báo sau khi hiển thị -->
						<c:remove var="securi" scope="session" />
					</c:if>
					<form action="${path}/Login" method="post">
						<!-- Username -->
						<div class="mb-3">
							<label class="form-label">Username:</label> <input type="text"
								name="username" value="${username}" class="form-control"
								placeholder="Nhập username">
						</div>

						<!-- Password -->
						<div class="mb-3">
							<label class="form-label">Mật khẩu:</label> <input
								type="password" name="password" value="${password}"
								class="form-control" placeholder="Nhập mật khẩu">
						</div>

						<!-- Remember me -->
						<div class="form-check mb-3">
							<input class="form-check-input" type="checkbox"
								name="remember-me" id="rememberMe" ${remember}> <label
								class="form-check-label" for="rememberMe"> Nhớ mật khẩu
							</label>
						</div>

						<button type="submit" class="btn btn-primary w-100 py-2">
							Đăng nhập</button>

						<p class="text-danger mt-3">${message}</p>
					</form>

				</div>
			</div>

		</div>
	</div>
	<footer
		class="bg-dark text-white p-3 text-center justify-content-center mt-5">©
		Copyright by FPT Polytechnic</footer>
</body>
</html>