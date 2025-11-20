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

	<nav class="navbar navbar-expand-sm navbar-light bg-light sticky-top">
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

					<!-- Menu Yêu thích cho User hoặc chưa đăng nhập -->
					<c:if
						test="${empty userSession || (not empty userSession && userSession.admin == false)}">
						<li class="nav-item"><a class="nav-link"
							href="${path}/YeuThich"> <i class="fa-solid fa-bookmark"></i>
								Yêu Thích Của Tôi
						</a></li>
					</c:if>

					<!-- Menu Admin -->
					<c:if test="${not empty userSession && userSession.admin == true}">
						<li class="nav-item"><a class="nav-link"
							href="${path}/Home"> <i class="fa-solid fa-house"></i>
								Home
						</a></li>

						<li class="nav-item"><a class="nav-link"
							href="${path}/Videos"> <i class="fa-solid fa-video"></i>
								Videos
						</a></li>

						<li class="nav-item"><a class="nav-link" href="${path}/User">
								<i class="fa-solid fa-users"></i> Users
						</a></li>

						<li class="nav-item"><a class="nav-link"
							href="${path}/Reports"> <i class="fa-solid fa-chart-column"></i>
								Reports
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
									<li><a class="dropdown-item" href="${path}/Logout">Đăng Xuất</a></li>
									<li><a class="dropdown-item" href="#">Đổi Mật Khẩu</a></li>
									<li><a class="dropdown-item" href="#">Chỉnh Sửa Tài Khoản</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="dropdown-item" href="${path}/Login">Đăng Nhập</a></li>
									<li><a class="dropdown-item" href="#">Quên Mật Khẩu</a></li>
									<li><a class="dropdown-item" href="#">Đăng Ký</a></li>
								</c:otherwise>
							</c:choose>
						</ul></li>

				</ul>

				<!-- Ngôn ngữ ở ngoài cùng bên phải -->
				<ul class="navbar-nav d-flex">
					<li class="nav-item"><a class="nav-link">Tiếng Việt</a></li>
					<li class="nav-item"><a class="nav-link">Tiếng Anh</a></li>
				</ul>

			</div>
		</div>
	</nav>


	<div class="container mt-4">
		<div class="row">
			<c:forEach var="video" items="${videos}">
				<div class="col-md-4 mb-3">
					<div class="card">
						<!-- Nếu Poster là YouTube ID -->
						<iframe class="card-img-top" width="100%" height="200"
							src="https://www.youtube.com/embed/${video.poster}"
							title="${video.title}" frameborder="0" allowfullscreen></iframe>

						<div class="card-body">
							<h5 class="card-title">${video.title}</h5>
							<p class="card-text">${fns:substring(video.description, 0, 100)}...
							</p>
							<p class="card-text">
								<small class="text-muted">Lượt xem: ${video.views}</small>
							</p>

							<!-- Nút Like -->
							<div class="d-flex gap-2 mt-2">
								<!-- Like: dùng link JS hoặc gọi servlet -->
								<a href="${path}/LikeVideo?videoId=${video.id}"
									class="btn btn-sm btn-primary"> <i
									class="fa-solid fa-thumbs-up"></i> Like
								</a>

								<!-- Nút Share -->
								<a
									href="mailto:?subject=Chia sẻ video: ${video.title}
              &body=Hãy xem video này: ${path}/VideoDetail?id=${video.id}"
									class="btn btn-sm btn-warning"> <i
									class="fa-solid fa-envelope"></i> Share
								</a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- Phân Trang 1 trang 6 video  -->
	<div class="mt-5">
		<ul class="pagination justify-content-center">

			<!-- Previous -->
			<li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a
				class="page-link" href="${path}/Home?page=${currentPage - 1}">Previous</a>
			</li>

			<!-- Page numbers -->
			<c:forEach var="i" begin="1" end="${totalPages}">
				<li class="page-item ${i == currentPage ? 'active' : ''}"><a
					class="page-link" href="${path}/Home?page=${i}">${i}</a></li>
			</c:forEach>

			<!-- Next -->
			<li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
				<a class="page-link" href="${path}/Home?page=${currentPage + 1}">Next</a>
			</li>

		</ul>
	</div>
	<footer
		class="bg-dark text-white p-3 text-center justify-content-center mt-5">© Copyright by FPT Polytechnic</footer>
</body>
</html>