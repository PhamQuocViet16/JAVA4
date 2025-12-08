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


	<div class="container mt-4 min-vh-100">

		<!-- Share Notifications -->
		<c:if test="${param.shareSuccess == 'true'}">
			<div class="alert alert-success text-center">🎉 Gửi video thành
				công!</div>
		</c:if>

		<c:if test="${param.shareError == 'true'}">
			<div class="alert alert-danger text-center">❌ Gửi email thất
				bại!</div>
		</c:if>

		<c:if test="${param.shareError == 'notLogin'}">
			<div class="alert alert-warning text-center">⚠ Bạn phải đăng
				nhập để chia sẻ video!</div>
		</c:if>

		<!-- Search Form -->
		<form method="get" action="${path}/Home"
			class="d-flex justify-content-center mb-4 mt-3">
			<div class="input-group w-50">
				<span class="input-group-text bg-white border-end-0"><i
					class="fa-solid fa-magnifying-glass"></i></span> <input type="text"
					name="keyword" class="form-control border-start-0"
					placeholder="Tìm video..."
					value="${param.keyword != null ? param.keyword : ''}">
				<button class="btn btn-primary" type="submit">Tìm</button>
			</div>
		</form>

		<!-- No Video Found -->
		<c:if test="${empty videos}">
			<div class="col-12 text-center py-5">
				<h3>
					<i class="fa-solid fa-magnifying-glass"></i> Không tìm thấy video
					nào với từ khóa: "
					<c:out value='${param.keyword}' />
					"
				</h3>
			</div>
		</c:if>

		<!-- Video List -->
		<div class="row">
			<c:forEach var="video" items="${videos}">
				<div class="col-md-4 mb-3">
					<div class="card h-100">

						<a href="${path}/VideoDetail?id=${video.id}"> <iframe
								class="card-img-top" width="100%" height="200"
								src="https://www.youtube.com/embed/${video.poster}"
								frameborder="0" allowfullscreen></iframe>
						</a>

						<div class="card-body">
							<h5 class="card-title">
								<a href="${path}/VideoDetail?id=${video.id}"
									class="text-dark text-decoration-none">${video.title}</a>
							</h5>

							<p class="card-text">${fns:substring(video.description, 0, 100)}...</p>

							<p class="card-text">
								<small class="text-muted">Lượt xem: ${video.views}</small>
							</p>

							<!-- Like + Share Buttons -->
							<div class="d-flex gap-2 mt-2">
								<!-- Like Button -->
								<c:set var="liked" value="false" />
								<c:if test="${not empty userSession}">
									<c:forEach var="f" items="${likedVideos}">
										<c:if test="${f.video.id == video.id}">
											<c:set var="liked" value="true" />
										</c:if>
									</c:forEach>
								</c:if>

								<c:choose>
									<c:when test="${liked}">
										<a
											href="${path}/Favorite?videoId=${video.id}&action=delete&page=${currentPage}&redirect=Home"
											class="btn btn-sm btn-danger"> <i
											class="fa-solid fa-thumbs-up"></i> Bỏ Like
										</a>
									</c:when>
									<c:otherwise>
										<a
											href="${path}/Favorite?videoId=${video.id}&action=add&page=${currentPage}&redirect=Home"
											class="btn btn-sm btn-primary"> <i
											class="fa-solid fa-thumbs-up"></i> Like
										</a>
									</c:otherwise>
								</c:choose>

								<!-- Share Button opens modal -->
								<button class="btn btn-sm btn-warning" data-bs-toggle="modal"
									data-bs-target="#shareModal_${video.id}">
									<i class="fa-solid fa-envelope"></i> Share
								</button>
							</div>
						</div>

						<!-- SHARE MODAL -->
						<div class="modal fade" id="shareModal_${video.id}" tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<form action="${path}/Share" method="post">
										<div class="modal-header">
											<h5 class="modal-title">Chia sẻ video</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal"></button>
										</div>
										<div class="modal-body">
											<input type="hidden" name="videoId" value="${video.id}">
											<label>Email người nhận:</label> <input type="email"
												name="email" class="form-control" required>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">Đóng</button>
											<button type="submit" class="btn btn-primary">
												<i class="fa-solid fa-paper-plane"></i> Gửi
											</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						<!-- END SHARE MODAL -->

					</div>
				</div>
			</c:forEach>
		</div>

	</div>

	<!-- Pagination -->
	<c:if test="${not empty videos}">
		<div class="mt-5">
			<ul class="pagination justify-content-center">
				<li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a
					class="page-link" href="${path}/Home?page=${currentPage - 1}">«</a>
				</li>

				<c:forEach var="i" begin="1" end="${totalPages}">
					<li class="page-item ${i == currentPage ? 'active' : ''}"><a
						class="page-link" href="${path}/Home?page=${i}">${i}</a></li>
				</c:forEach>

				<li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
					<a class="page-link" href="${path}/Home?page=${currentPage + 1}">»</a>
				</li>
			</ul>
		</div>
	</c:if>
	<footer
		class="bg-dark text-white p-3 text-center justify-content-center mt-5">©
		Copyright by FPT Polytechnic</footer>
</body>
</html>