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
	<div class="container mt-4">
		<h2 class="mb-4 text-center">Tìm kiếm Video</h2>

		<!-- Form tìm kiếm -->
		<form action="search" method="get" class="mb-4">
			<div class="input-group">
				<input type="text" name="keyword" class="form-control"
					placeholder="Nhập từ khóa..." value="${param.keyword}">
				<button type="submit" class="btn btn-primary">
					<i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
				</button>
			</div>
		</form>

		<!-- Hiển thị kết quả -->
		<c:if test="${empty results}">
			<p class="text-center text-danger">Không tìm thấy video nào!</p>
		</c:if>

		<c:if test="${not empty results}">
			<div class="row">
				<c:forEach var="video" items="${results}">
					<div class="col-md-4 mb-4">
						<div class="card h-100 shadow-sm">
							<!-- Thumbnail YouTube -->
							<img src="https://img.youtube.com/vi/${video.poster}/0.jpg"
								class="card-img-top" alt="${video.title}">
							<div class="card-body">
								<h5 class="card-title">${video.title}</h5>
								<p class="card-text">
									<strong>Views:</strong> ${video.views} <br> <strong>Category:</strong>
									${video.category}
								</p>
							</div>
							<div class="card-footer text-center">
								<a href="https://www.youtube.com/watch?v=${video.poster}"
									target="_blank" class="btn btn-success"> Xem Video </a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
</body>
</html>