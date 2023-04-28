<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">


		<c:if test="${pageInfo.currentPageNumber > 1 }">
			<li class="page-item">
				<c:url value="/list" var="pageLink">
					<c:param name="page" value="1"></c:param>
					<c:param name="num" value="${pageInfo.num}"></c:param>
				</c:url>
				<a href="${pageLink }" class="page-link">
					<i class="fa-solid fa-angles-left"></i>
				</a>
			</li>
		</c:if>
		<c:if test="${pageInfo.currentPageNumber > 1 }">
			<li class="page-item">
				<c:url value="/list" var="pageLink">
					<c:param name="page" value="${pageInfo.prevPageNumber }"></c:param>
					<c:param name="num" value="${pageInfo.num}"></c:param>
				</c:url>
				<a href="${pageLink }" class="page-link">
					<i class="fa-solid fa-angle-left"></i>
				</a>
			</li>
		</c:if>

		<c:forEach begin="${pageInfo.begin }" end="${pageInfo.end }" var="pageNumber">
			<!-- li.page-item>a.page-link -->
			<c:url value="/list" var="pageLink">
				<c:param name="page" value="${pageNumber }"></c:param>
				<c:param name="num" value="${pageInfo.num}"></c:param>
			</c:url>
			<li class="page-item">
				<a href="${pageLink }" class="page-link ${pageNumber eq pageInfo.currentPageNumber ? 'active' : '' }">${pageNumber }</a>
			</li>
		</c:forEach>

		<c:if test="${pageInfo.nextPageNumber le pageInfo.lastPageNumber }">
			<li class="page-item">
				<c:url value="/list" var="pageLink">
					<c:param name="page" value="${pageInfo.nextPageNumber }"></c:param>
					<c:param name="num" value="${pageInfo.num}"></c:param>
				</c:url>
				<a href="${pageLink }" class="page-link">
					<i class="fa-solid fa-angle-right"></i>
				</a>
				<!-- 다음 -->
			</li>
		</c:if>


		<c:if test="${ pageInfo.currentPageNumber < pageInfo.lastPageNumber }">
			<li class="page-item">
				<c:url value="/list" var="pageLink">
					<c:param name="page" value="${pageInfo.lastPageNumber }"></c:param>
					<c:param name="num" value="${pageInfo.num}"></c:param>
				</c:url>
				<a href="${pageLink }" class="page-link">
					<i class="fa-solid fa-angles-right"></i>
				</a>
				<!-- 맨뒤로 -->
			</li>
		</c:if>
	</ul>
</nav>