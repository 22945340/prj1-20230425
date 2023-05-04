<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="current"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
					<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/list">목록</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${current eq 'add' ? 'active' : '' }" href="/add">글쓰기</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${current eq 'signup' ? 'active' : '' }" href="/member/signup">회원가입</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${current eq 'memberList' ? 'active' : '' }" href="/member/list">회원목록</a>
				</li>
			</ul>
			
			

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
			


			<form action="${pageLink }" class="d-flex" role="search">
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="searchOption">
					<option value="writer" ${param.searchOption eq 'writer' ? 'selected' : '' }>작성자</option>
					<option value="title" ${param.searchOption eq 'title' ? 'selected' : '' }>제목</option>
					<option value="writerTitle" ${param.searchOption eq 'writerTitle' ? 'selected' : '' }>작성자+제목</option>
				</select>

				<input name="search" class="form-control me-2" type="search" placeholder="Search" aria-label="Search" value="${param.search }">
				<button class="btn btn-outline-success" type="submit">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</form>
		</div>
	</div>
</nav>