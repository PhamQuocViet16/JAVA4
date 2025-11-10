<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>
</head>

<body>
   <jsp:include page="index.jsp"></jsp:include>
<div>
    <div class="body">
        <c:forEach var="item" items="${selectedItems}">
            <div class="card" style="display: flex; align-items: center;">
                <img class="card-img-top" src="img/${item.image}" alt="Card image cap" width="500px" height="500px">
                <div class="card-content">
                    <div class="card-body text-center">
                        <h5 class="card-title ">${item.name}</h5>
                    </div>
                    <div class="card-body">
                        <strike>${item.price}</strike> ${item.price * (1 - item.discount)}
                    </div>
                    <div class="card-action">
                        <a href="bai4list">Trở về</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>