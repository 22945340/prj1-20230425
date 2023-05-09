<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="current"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<nav class="navbar navbar-expand-lg bg-dark mb-3 " data-bs-theme="dark">
	<div class="container-lg">
		<a class="navbar-brand" href="#">
			<img src="/img/Netflix.png" width="100px" height="56px" alt="" />
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/list">자유 게시판</a>
				</li>
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item">
						<a class="nav-link ${current eq 'memberList' ? 'active' : '' }" href="/member/list">회원목록</a>
					</li>
				</sec:authorize>
			</ul>
		</div>
		
		<div>
		<ul class="navbar-nav me-auto mb-2 mb-lg-0" >

				<sec:authorize access="isAnonymous()">
					<li class="nav-item">
						<a class="nav-link ${current eq 'signup' ? 'active' : '' }" href="/member/signup">회원가입</a>
					</li>

					<li class="nav-item">
						<a class="nav-link ${current eq 'login' ? 'active' : '' }" href="/member/login">로그인</a>
					</li>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<li class="nav-item">
						<sec:authentication property="principal.username" />님 환영합니다.
					</li>				
					<li class="nav-item">
						<a class="nav-link" href="/member/logout">로그아웃</a>
					</li>
				</sec:authorize>
			</ul>
		</div>
	</div>
</nav>

<c:url value="/list" var="pageLink">
	<c:param name="page" value="${pageInfo.prevPageNumber }"></c:param>
	<c:param name="num" value="${pageInfo.num}"></c:param>
	<c:if test="${not empty param.search }">
		<c:param name="search" value="${param.search }"></c:param>
	</c:if>
	<c:if test="${not empty param.searchOption }">
		<c:param name="searchOption" value="${param.searchOption }"></c:param>
	</c:if>

</c:url>
