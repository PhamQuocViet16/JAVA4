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
<form action="" method="post">
<input name="canha" placeholder="cạnh a?" value="${canha}"><br>
<input name="canhb" placeholder="cạnh b?" value="${canhb}"><br>


<button formaction="chuvi">Tính Chu Vi</button>
<button formaction="dientich">Tính Diện Tích</button>
<button formaction="tinhhieu">Tính Hiệu</button>
<a href="index.jsp">Về trang chủ</a>

<h1>Chu vi là: ${cv}</h1>
<h1>Diện tích là: ${dt}</h1>
<h1>Hiệu là: ${hieu}</h1>
</form>
</body>
</html>