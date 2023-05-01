<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="pageNumber" %>

<c:url value="/list" var="pageLink">
	<c:param name="page" value="${pageNumber }"></c:param>
	<c:param name="num" value="${pageInfo.num}"></c:param>
	<c:if test="${not empty param.search }">
		<c:param name="search" value="${param.search }"></c:param>
	</c:if>
	<c:if test="${not empty param.searchOption }">
		<c:param name="searchOption" value="${param.searchOption }"></c:param>
	</c:if>
</c:url>
<li class="page-item">
	<a href="${pageLink }" class="page-link ${pageNumber eq pageInfo.currentPageNumber ? 'active' : '' }">
		<jsp:doBody></jsp:doBody>
	</a>
</li>