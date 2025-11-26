<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fns"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Share-Summary</title>
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

	<div class="container mt-3">
		<a class="btn btn-secondary mb-3" href="${path}/Home"><i
			class="fa-solid fa-arrow-left"></i> Trang chủ</a>
		<h2 class="text-center mb-4">Tổng hợp chia sẻ Video</h2>
		<table class="table table-bordered table-striped">
			<thead class="table-dark">
				<tr>
					<th>Tiêu đề Video</th>
					<th>Số lượt chia sẻ</th>
					<th>Ngày chia sẻ đầu tiên</th>
					<th>Ngày chia sẻ cuối cùng</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="row" items="${summaryList}">
					<tr>
						<td>${row[0]}</td>
						<td>${row[1]}</td>
						<td><fmt:formatDate value="${row[2]}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${row[3]}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>