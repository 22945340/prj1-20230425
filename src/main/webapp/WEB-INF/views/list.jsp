<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>

	<my:navBar current="list" />

	<my:alert />

	<c:url value="/list" var="pageLink">
		<c:param name="page" value="${pageInfo.prevPageNumber }"></c:param>
		<c:if test="${not empty param.search }">
			<c:param name="search" value="${param.search }"></c:param>
		</c:if>
		<c:if test="${not empty param.searchOption }">
			<c:param name="searchOption" value="${param.searchOption }"></c:param>
		</c:if>
	</c:url>

	<div class="container-lg">
		<h1>자유 게시판</h1>

		<hr />
		<div>
			<div style="float: left">

				<form action="${pageLink }" method="get" name="selectNum">

					<input type="hidden" name="search" value="${param.search }" />
					<input type="hidden" name="searchOption" value="${param.searchOption }" />

					<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="num" onchange="selectNum.submit()">
						<option value="10" ${pageInfo.num eq 10 ? 'selected' : '' }>10개씩 보기</option>
						<option value="20" ${pageInfo.num eq 20 ? 'selected' : '' }>20개씩 보기</option>
						<option value="30" ${pageInfo.num eq 30 ? 'selected' : '' }>30개씩 보기</option>
					</select>
				</form>
			</div>

			<div style="float: right">
				<form action="${pageLink }" class="d-flex" role="search">
					<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="searchOption">
						<option value="writer" ${param.searchOption eq 'writer' ? 'selected' : '' }>작성자</option>
						<option value="title" ${param.searchOption eq 'title' ? 'selected' : '' }>제목</option>
						<option value="writerTitle" ${param.searchOption eq 'writerTitle' ? 'selected' : '' }>작성자+제목</option>
					</select>

					<input name="search" class="form-control me-2" type="search" placeholder="Search" aria-label="Search" value="${param.search }">
					<button class="btn btn-outline-secondary" type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form> <br />
				<button style="float:right" onclick="location.href='/add'" class="btn btn-outline-success">글쓰기</button>
			</div>

		<table class="table">
			<thead>
				<tr>
					<th>#</th>
					<th><i class="fa-solid fa-heart"></i></th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일시</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList }" var="board">
					<tr>
						<td>${board.id }</td>
						<td>${board.likeCount }</td>
						<td>
							<a href="/id/${board.id }"> ${board.title } </a>
							<c:if test="${board.fileCount ge 1  }">
								<span class="badge text-bg-light">
									<i class="fa-regular fa-image"></i>
									${board.fileCount }
								</span>
							</c:if>

						</td>
						<td>${board.writer }</td>
						<td>${board.inserted }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>



	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">

			<!-- 맨앞 -->
			<c:if test="${pageInfo.currentPageNumber > 1 }">
				<my:pageItem pageNumber="1">
					<i class="fa-solid fa-angles-left"></i>
				</my:pageItem>
			</c:if>

			<!-- 이전 -->
			<c:if test="${pageInfo.currentPageNumber > 1 }">
				<my:pageItem pageNumber="${pageInfo.currentPageNumber -1}">
					<i class="fa-solid fa-angle-left"></i>
				</my:pageItem>
			</c:if>


			<c:forEach begin="${pageInfo.begin }" end="${pageInfo.end }" var="pageNumber">
				<!-- li.page-item>a.page-link -->
				<my:pageItem pageNumber="${pageNumber }">
				${pageNumber }
			</my:pageItem>

			</c:forEach>

			<!-- 다음 버튼 -->
			<c:if test="${pageInfo.nextPageNumber le pageInfo.lastPageNumber }">
				<my:pageItem pageNumber="${pageInfo.currentPageNumber + 1 }">
					<i class="fa-solid fa-angle-right"></i>
				</my:pageItem>
			</c:if>


			<!-- 맨뒤로 -->
			<c:if test="${ pageInfo.currentPageNumber < pageInfo.lastPageNumber }">
				<my:pageItem pageNumber="${pageInfo.lastPageNumber }">
					<i class="fa-solid fa-angles-right"></i>
				</my:pageItem>
			</c:if>
		</ul>
	</nav>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>
















</body>
</html>














