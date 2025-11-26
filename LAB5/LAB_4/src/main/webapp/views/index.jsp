<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ - Video Portal</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<c:set var="path" value="${pageContext.request.contextPath}" />

	<!-- NAVBAR -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
		<div class="container">
			<a class="navbar-brand" href="${path}/Home"> <img
				src="${path}/images/logo-energy-pilates.png" alt="Logo"
				style="width: 150px;">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link" href="${path}/Home">Trang
							chủ</a></li>
					<c:if test="${not empty sessionScope.user}">
						<li class="nav-item"><a class="nav-link"
							href="${path}/search">Tìm kiếm Video</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${path}/share-summary">Tổng hợp chia sẻ</a></li>
					</c:if>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown"> <c:choose>
								<c:when test="${not empty sessionScope.user}">
                                Xin chào, ${sessionScope.user.fullname}
                            </c:when>
								<c:otherwise>
                                Tài khoản
                            </c:otherwise>
							</c:choose>
					</a>
						<ul class="dropdown-menu">
							<c:choose>
								<c:when test="${not empty sessionScope.user}">
									<li><a class="dropdown-item" href="${path}/Logout">Đăng
											Xuất</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="dropdown-item" href="${path}/Login">Đăng
											Nhập</a></li>
									<li><a class="dropdown-item" href="#">Đăng Ký</a></li>
								</c:otherwise>
							</c:choose>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- MAIN CONTENT -->
	<c:choose>
		<c:when test="${not empty sessionScope.user}">
			<!-- User đã đăng nhập -->
			<div class="container text-center mt-5">
				<h3>Xin chào, ${sessionScope.user.fullname}!</h3>
				<a class="btn btn-primary m-2" href="${path}/search">Tìm kiếm
					Video</a> <a class="btn btn-success m-2" href="${path}/share-summary">Tổng
					hợp chia sẻ</a>
			</div>
		</c:when>
		<c:otherwise>
			<!-- User chưa đăng nhập, hiển thị form -->
			<div
				class="container d-flex justify-content-center align-items-center vh-100">
				<div class="col-md-4">
					<div class="card shadow-lg border-0 rounded-4">
						<div class="card-body p-4">
							<h3 class="text-center mb-4">Đăng Nhập</h3>
							<form action="${path}/Login" method="post">
								<div class="mb-3">
									<label class="form-label">Username:</label> <input type="text"
										name="username" value="${username}" class="form-control"
										placeholder="Nhập username">
								</div>
								<div class="mb-3">
									<label class="form-label">Mật khẩu:</label> <input
										type="password" name="password" value="${password}"
										class="form-control" placeholder="Nhập mật khẩu">
								</div>
								<div class="form-check mb-3">
									<input class="form-check-input" type="checkbox"
										name="remember-me" id="rememberMe"
										${remember ? "checked" : ""}> <label
										class="form-check-label" for="rememberMe"> Nhớ mật
										khẩu </label>
								</div>
								<button type="submit" class="btn btn-primary w-100 py-2">Đăng
									nhập</button>
								<p class="text-danger mt-3">${message}</p>
							</form>
						</div>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>

	<!-- FOOTER -->
	<footer class="bg-dark text-white p-3 text-center mt-5"> ©
		Copyright by FPT Polytechnic </footer>
</body>
</html>
