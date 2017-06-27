<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Item List Page</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/app/css/styles.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/vendor/bootstrap-3.0.0/css/bootstrap.css"
	type="text/css" media="screen, projection">
</head>
<body>
 
	<sec:authentication property="principal" var="userDetails" />
	<div style="display: inline-flex">
		welcome&nbsp;&nbsp; <span id="userName">${f:h(userDetails.account.name)}</span>
		<form method="post" action="${pageContext.request.contextPath}/logout">
			<input type="submit" id="logout" value="logout" />
			<sec:csrfInput />
		</form>
		<form method="get"
			action="${pageContext.request.contextPath}/account/update">
			<input type="submit" name="form1" id="updateAccount"
				value="Account Update" />
		</form>
	</div>
	<br>
	<br>
 
	<div class="container">
		<p>select a category</p>
 
		<form:form method="get"
			action="${pageContext.request.contextPath}/goods/"
			modelAttribute="goodViewForm">
			<form:select path="categoryId" items="${CL_CATEGORIES}" />
			<input type="submit" id="update" value="update" />
		</form:form>
		<br />
		<t:messagesPanel />
		<table>
			<tr>
				<th>Name</th>
				<th>Price</th>
                <th>Quantity</th>
			</tr>
			<c:forEach items="${page.content}" var="goods" varStatus="status">
				<tr>
					<td><a id="${f:h(goods.name)}"
						href="${pageContext.request.contextPath}/goods/${f:h(goods.id)}">${f:h(goods.name)}</a></td>
					<td><fmt:formatNumber value="${f:h(goods.price)}" type="CURRENCY" currencySymbol="&yen;" maxFractionDigits="0" /></td>
                    <td><form:form method="post" action="${pageContext.request.contextPath}/goods/addToCart" modelAttribute="goodAddForm">
                            <input type="text" name="quantity" id="quantity${status.index}" value="1" />
                            <input type="hidden" name="goodsId" value="${f:h(goods.id)}" />
                            <input type="submit" id="add${status.index}" value="add" />
                        </form:form></td>
				</tr>
			</c:forEach>
		</table>
		<t:pagination page="${page}" outerElementClass="pagination" />
	</div>
	<div>
		<p>
			<fmt:formatNumber value="${page.totalElements}" />
			results <br> ${f:h(page.number + 1) } / ${f:h(page.totalPages)}
			Pages
		</p>
	</div>
 
    <div>
        <spring:eval var="cart" expression="@cart" />
        <form method="get" action="${pageContext.request.contextPath}/cart">
            <input type="submit" id="viewCart" value="view cart" />
        </form>
        <table>
            <c:forEach items="${cart.cartItems}" var="cartItem" varStatus="status">
                <tr>
                    <td><span id="itemName${status.index}">${f:h(cartItem.goods.name)}</span></td>
                    <td><span id="itemPrice${status.index}"><fmt:formatNumber
                                value="${cartItem.goods.price}" type="CURRENCY"
                                currencySymbol="&yen;" maxFractionDigits="0" /></span></td>
                    <td><span id="itemQuantity${status.index}">${f:h(cartItem.quantity)}</span></td>
                </tr>
            </c:forEach>
            <tr>
                <td>Total</td>
                <td><span id="totalPrice"><fmt:formatNumber value="${f:h(cart.totalAmount)}" type="CURRENCY" currencySymbol="&yen;" maxFractionDigits="0" /></span></td>
                <td></td>
            </tr>
        </table>
    </div>

</body>
</html>