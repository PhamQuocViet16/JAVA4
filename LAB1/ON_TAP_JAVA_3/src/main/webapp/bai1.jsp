<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="menu.jsp"></jsp:include>>
<h1>Đây là Bài 1</h1>
<form action="" method="post">
<button formaction="bai1/insert">Thêm mới</button>
<button formaction="bai1/update">Cập nhật</button>
<button formaction="bai1/delete">Xoá</button>

<a href="index.jsp">Về trang chủ</a>
</form>
</body>
</html>